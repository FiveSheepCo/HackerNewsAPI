import Foundation

extension HackerNewsAPI {
    public enum Error: Swift.Error {
        case badLogin
        case unknown
        case notLoggedIn
        case missingUpvoteLink
        case missingCommentForm
    }
}
