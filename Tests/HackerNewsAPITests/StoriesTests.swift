import XCTest
@testable import HackerNewsAPI

final class StoriesTests: XCTestCase {
    
    enum Constants {
        static let timeout: TimeInterval = 5
    }
    
    func testMaxItem() {
        let expectation = expectation(description: "Max Item")
        
        HackerNewsAPI.shared.getMaxItem { result in
            switch result {
            case .success(let maxItem):
                XCTAssert(maxItem > 0)
            case .failure(let error):
                XCTFail("Threw Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func testTopStories() {
        let expectation = expectation(description: "Top Stories")
        
        HackerNewsAPI.shared.getTopStories { result in
            switch result {
            case .success(let stories):
                XCTAssert(!stories.isEmpty)
            case .failure(let error):
                XCTFail("Threw Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func testNewStories() {
        let expectation = expectation(description: "New Stories")
        
        HackerNewsAPI.shared.getNewStories { result in
            switch result {
            case .success(let stories):
                XCTAssert(!stories.isEmpty)
            case .failure(let error):
                XCTFail("Threw Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func testBestStories() {
        let expectation = expectation(description: "Best Stories")
        
        HackerNewsAPI.shared.getBestStories { result in
            switch result {
            case .success(let stories):
                XCTAssert(!stories.isEmpty)
            case .failure(let error):
                XCTFail("Threw Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func testAskStories() {
        let expectation = expectation(description: "Ask Stories")
        
        HackerNewsAPI.shared.getAskStories { result in
            switch result {
            case .success(let stories):
                XCTAssert(!stories.isEmpty)
            case .failure(let error):
                XCTFail("Threw Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func testShowStories() {
        let expectation = expectation(description: "Show Stories")
        
        HackerNewsAPI.shared.getShowStories { result in
            switch result {
            case .success(let stories):
                XCTAssert(!stories.isEmpty)
            case .failure(let error):
                XCTFail("Threw Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func testJobStories() {
        let expectation = expectation(description: "Job Stories")
        
        HackerNewsAPI.shared.getJobStories { result in
            switch result {
            case .success(let stories):
                XCTAssert(!stories.isEmpty)
            case .failure(let error):
                XCTFail("Threw Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
}
