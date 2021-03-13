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
