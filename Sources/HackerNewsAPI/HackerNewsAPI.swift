import Foundation
import SchafKit

public class HackerNewsAPI {
    /// Shared instance of `HackerNewsAPI`.
    public static let shared = HackerNewsAPI()
    
    private let baseURL = "https://hacker-news.firebaseio.com/v0/"
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    
    private init() {}
    
    // MARK: - Public Functions
    
    /// Gets an `HNItem` by its `id`.
    public func getItem(for id: Int, completion: @escaping (Result<HNItem, Error>) -> Void) {
        getCodable(at: "item/\(id).json", completion: completion)
    }
    
    /// Gets a `HNUser` by its `id`.
    public func getUser(for id: String, completion: @escaping (Result<HNUser, Error>) -> Void) {
        getCodable(at: "user/\(id).json", completion: completion)
    }
    
    /// Gets the current largest item id.
    public func getMaxItem(completion: @escaping (Result<Int, Error>) -> Void) {
        getCodable(at: "maxitem.json", completion: completion)
    }
    
    /// Gets up to 500 top stories.
    public func getTopStories(completion: @escaping (Result<[Int], Error>) -> Void) {
        getCodable(at: "topstories.json", completion: completion)
    }
    
    /// Gets up to 500 new stories.
    public func getNewStories(completion: @escaping (Result<[Int], Error>) -> Void) {
        getCodable(at: "newstories.json", completion: completion)
    }
    
    /// Gets up to 500 best stories.
    public func getBestStories(completion: @escaping (Result<[Int], Error>) -> Void) {
        getCodable(at: "beststories.json", completion: completion)
    }
    
    /// Gets up to 200 ask stories.
    public func getAskStories(completion: @escaping (Result<[Int], Error>) -> Void) {
        getCodable(at: "askstories.json", completion: completion)
    }
    
    /// Gets up to 200 show stories.
    public func getShowStories(completion: @escaping (Result<[Int], Error>) -> Void) {
        getCodable(at: "showstories.json", completion: completion)
    }
    
    /// Gets up to 200 job stories.
    public func getJobStories(completion: @escaping (Result<[Int], Error>) -> Void) {
        getCodable(at: "jobstories.json", completion: completion)
    }
    
    // MARK: - Private Functions
    
    private func getCodable<T: Codable>(at path: String, completion: @escaping (Result<T, Error>) -> Void) {
        OKNetworking.request(url: baseURL + path) { result in
            completion(
                result.flatMap({ requestResult in
                    do {
                        return .success(try self.decoder.decode(T.self, from: requestResult.data))
                    }
                    catch let error {
                        return .failure(error)
                    }
                })
            )
        }
    }
}
