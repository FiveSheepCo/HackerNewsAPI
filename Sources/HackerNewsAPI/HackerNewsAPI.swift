import Foundation
import AsyncNetworking
import SwiftSoup

public class HackerNewsAPI {
    /// Shared instance of `HackerNewsAPI`.
    public static let shared = HackerNewsAPI()
    
    private let baseURL = "https://hacker-news.firebaseio.com/v0/"
    public let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    
    public var authorizationCallback: (() async throws -> Void)?
    
    private init() {}
    
    // MARK: - Public Functions
    
    /// Gets an `HNItem` by its `id`.
    public func getItem(for id: Int) async throws -> HNItem {
        try await getCodable(at: "item/\(id).json")
    }
    
    /// Gets a `HNUser` by its `id`.
    public func getUser(for id: String) async throws -> HNUser {
        try await getCodable(at: "user/\(id).json")
    }
    
    /// Gets the current largest item id.
    public func getMaxItem() async throws -> Int {
        try await getCodable(at: "maxitem.json")
    }
    
    /// Gets up to 500 top stories.
    public func getStories(kind: StoryKind) async throws -> [Int] {
        try await getCodable(at: "\(kind.rawValue)stories.json")
    }
    
    @discardableResult
    public func login(username: String, password: String) async throws -> String {
        for cookie in HTTPCookieStorage.shared.cookies ?? [] {
            guard cookie.name == "user" && cookie.domain == "news.ycombinator.com" else { continue }
            
            return cookie.value
        }
        
        let result = try await AsyncNetworking.request(
            url: "https://news.ycombinator.com/login",
            options: [
                .requestMethod(value: .post),
                .body(value: .xWwwFormUrlencoded(value: [
                    "acct": username,
                    "pw": password,
                    "goto": "news"
                ])),
                .customRedirectHandler(handler: { _, _ in
                    nil
                })
            ]
        )
        
        // HN returns HTML containing "Bad Login" on failure
        guard
            let html = String(data: result.data, encoding: .utf8),
            html.range(of: "Bad Login", options: .caseInsensitive) == nil
        else {
            throw Error.badLogin
        }
        
        // On success, auth is carried in the "user" cookie, e.g. user=username&sessionToken
        guard
            let httpResponse = result.response.response as? HTTPURLResponse,
            let setCookie = httpResponse.allHeaderFields["Set-Cookie"] as? String
        else {
            throw Error.unknown
        }

        let cookies = setCookie
            .components(separatedBy: ";")
            .map { $0.trimmingCharacters(in: .whitespaces) }

        guard let userCookie = cookies.first(where: { $0.hasPrefix("user=") }) else {
            throw Error.unknown
        }

        // Strip "user=" prefix and return the auth value (username&sessionToken)
        let authValue = String(userCookie.dropFirst("user=".count))
        return authValue
    }
    
    public func logout() {
        for cookie in HTTPCookieStorage.shared.cookies ?? [] {
            guard cookie.name == "user" && cookie.domain == "news.ycombinator.com" else { continue }
            
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
    }
    
    private func ensureLogin(didTryCallback: Bool = false) async throws {
        // Ensure we are logged in (HN auth lives in the "user" cookie)
        let hasUserCookie = (HTTPCookieStorage.shared.cookies ?? []).contains {
            $0.name == "user" && $0.domain == "news.ycombinator.com"
        }
        
        if !hasUserCookie {
            if !didTryCallback, let authorizationCallback {
                try await authorizationCallback()
                try await ensureLogin(didTryCallback: true)
            } else {
                throw Error.notLoggedIn
            }
        }
    }
    
    public func upvote(itemID: Int) async throws {
        try await ensureLogin()

        // 1. Load the item page where the upvote link exists
        let itemResult = try await AsyncNetworking.request(
            url: "https://news.ycombinator.com/item?id=\(itemID)",
            options: [
                .customRedirectHandler(handler: { _, _ in nil })
            ]
        )
        
        guard let html = String(data: itemResult.data, encoding: .utf8) else {
            throw Error.unknown
        }

        // 2. Parse HTML using SwiftSoup
        let doc = try SwiftSoup.parse(html)

        // Upvote links look like:
        // <a id="up_12345" class="clicky" href="vote?id=12345&how=up&auth=...&goto=item%3Fid%3D12345">
        guard
            let upvoteElement = try doc.select("a#up_\(itemID)").first(),
            let href = try upvoteElement.attr("href") as String?
        else {
            throw Error.missingUpvoteLink
        }

        let voteURLString: String
        if href.hasPrefix("http") {
            voteURLString = href
        } else {
            voteURLString = "https://news.ycombinator.com/\(href)"
        }

        // 3. Perform the GET request to cast the vote
        _ = try await AsyncNetworking.request(
            url: voteURLString,
            options: [
                .requestMethod(value: .get),
                .customRedirectHandler(handler: { _, _ in nil })
            ]
        )
    }
    
    public func comment(parentID: Int, text: String) async throws {
        try await ensureLogin()
        
        // 1. Load the reply page for this item/comment.
        //    This works for:
        //    - top-level comments on a post (parentID = story id)
        //    - replies to comments (parentID = comment id)
        let replyResult = try await AsyncNetworking.request(
            url: "https://news.ycombinator.com/item?id=\(parentID)",
            options: [
                .requestMethod(value: .get),
                .customRedirectHandler(handler: { _, _ in
                    nil
                })
            ]
        )
        
        guard let html = String(data: replyResult.data, encoding: .utf8) else {
            throw Error.unknown
        }
        
        // 2. Parse HTML and find the comment form
        let doc = try SwiftSoup.parse(html)
        
        // <form method="post" action="comment"> … </form>
        guard let form = try doc.select("form[action=comment]").first() else {
            throw Error.missingCommentForm
        }
        
        // 3. Collect all existing hidden inputs (parent, goto, hmac, etc.)
        var params: [String: String] = [:]
        for input in try form.select("input[name]") {
            let name = try input.attr("name")
            let value = try input.attr("value")
            params[name] = value
        }
        
        // 4. Set the comment text
        params["text"] = text
        
        // 5. Build the POST URL from the form action
        let action = try form.attr("action") // usually "comment"
        let commentURL: String
        if action.hasPrefix("http") {
            commentURL = action
        } else {
            commentURL = "https://news.ycombinator.com/\(action)"
        }
        
        // 6. Submit the comment
        _ = try await AsyncNetworking.request(
            url: commentURL,
            options: [
                .requestMethod(value: .post),
                .body(value: .xWwwFormUrlencoded(value: params)),
                .customRedirectHandler(handler: { _, _ in
                    nil
                })
            ]
        )
    }
    
    // MARK: - User Functions
    
    public func getAllUserPosts(
        username: String,
        shouldStop: (([Int]) -> Bool)? = nil
    ) async throws -> [Int] {
        var allIDs: [Int] = []
        var seen = Set<Int>()
        var nextURL: String? = "https://news.ycombinator.com/submitted?id=\(username)"
        let maxPages = 50 // safety guard
        
        var pageCount = 0
        while let urlString = nextURL, pageCount < maxPages {
            pageCount += 1
            
            let result = try await AsyncNetworking.request(
                url: urlString,
                options: [
                    .requestMethod(value: .get),
                    .customRedirectHandler(handler: { _, _ in nil })
                ]
            )
            
            guard let html = String(data: result.data, encoding: .utf8) else {
                throw Error.unknown
            }
            
            let doc = try SwiftSoup.parse(html)
            
            // Posts on submitted page: <tr class="athing" id="123"> (no "comtr")
            let rows = try doc.select("tr.athing")
            for row in rows.array() {
                let classNames = try row.className().split(separator: " ")
                if classNames.contains(where: { $0 == "comtr" }) {
                    continue
                }
                let idString = try row.attr("id")
                if let id = Int(idString), !seen.contains(id) {
                    seen.insert(id)
                    allIDs.append(id)
                }
            }
            
            // Call the shouldStop closure
            if let shouldStop, shouldStop(allIDs) {
                break
            }
            
            // Find "more" link for pagination
            if let moreHref = try doc.select("a.morelink").first()?.attr("href"),
               !moreHref.isEmpty {
                if moreHref.hasPrefix("http") {
                    nextURL = moreHref
                } else {
                    nextURL = "https://news.ycombinator.com/\(moreHref)"
                }
            } else {
                nextURL = nil
            }
        }
        
        return allIDs
    }

    public func getAllUserComments(
        username: String,
        shouldStop: (([Int]) -> Bool)? = nil
    ) async throws -> [Int] {
        var allIDs: [Int] = []
        var seen = Set<Int>()
        var nextURL: String? = "https://news.ycombinator.com/threads?id=\(username)"
        let maxPages = 50 // safety guard
        
        var pageCount = 0
        while let urlString = nextURL, pageCount < maxPages {
            pageCount += 1
            
            let result = try await AsyncNetworking.request(
                url: urlString,
                options: [
                    .requestMethod(value: .get),
                    .customRedirectHandler(handler: { _, _ in nil })
                ]
            )
            
            guard let html = String(data: result.data, encoding: .utf8) else {
                throw Error.unknown
            }
            
            let doc = try SwiftSoup.parse(html)
            
            // Comment rows: <tr class="athing comtr" id="123456">
            let rows = try doc.select("tr.athing.comtr")
            for row in rows.array() {
                // Inside each row, author is in: <a class="hnuser">username</a>
                guard let userLink = try row.select("a.hnuser").first() else {
                    continue
                }
                let author = try userLink.text()
                guard author == username else {
                    // Skip comments from other users (thread replies)
                    continue
                }
                
                let idString = try row.attr("id")
                if let id = Int(idString), !seen.contains(id) {
                    seen.insert(id)
                    allIDs.append(id)
                }
            }
            
            // Call the shouldStop closure after each page
            if let shouldStop, shouldStop(allIDs) {
                break
            }
            
            // Find "more" link for pagination
            if let moreHref = try doc.select("a.morelink").first()?.attr("href"),
               !moreHref.isEmpty {
                if moreHref.hasPrefix("http") {
                    nextURL = moreHref
                } else {
                    nextURL = "https://news.ycombinator.com/\(moreHref)"
                }
            } else {
                nextURL = nil
            }
        }
        
        return allIDs
    }
    
    // MARK: - Private Functions
    
    private func getCodable<T: Codable>(at path: String) async throws -> T {
        let result = try await AsyncNetworking.request(url: baseURL + path)
        
        return try self.decoder.decode(T.self, from: result.data)
    }
}
