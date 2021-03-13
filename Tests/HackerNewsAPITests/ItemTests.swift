import XCTest
@testable import HackerNewsAPI

final class ItemTests: XCTestCase {
    
    enum Constants {
        static let timeout: TimeInterval = 5
    }
    
    func testStory() {
        let expectation = expectation(description: "Story")
        
        HackerNewsAPI.shared.getItem(for: 8863) { result in
            switch result {
            case .success(let item):
                XCTAssertEqual(
                    item,
                    HNItem(
                        id: 8863,
                        deleted: nil,
                        type: .story,
                        by: "dhouston",
                        time: Date(timeIntervalSince1970: 1175714200),
                        text: nil,
                        dead: nil,
                        parent: nil,
                        poll: nil,
                        kids: [9224, 8917, 8952, 8958, 8884, 8887, 8869, 8940, 8908, 9005, 8873, 9671, 9067, 9055, 8865, 8881, 8872, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8870, 8878, 8980, 8934, 8943, 8876],
                        url: "http://www.getdropbox.com/u/2/screencast.html",
                        score: 104,
                        title: "My YC app: Dropbox - Throw away your USB drive",
                        parts: nil,
                        descendants: 71
                    )
                )
            case .failure(let error):
                XCTFail("Threw Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func testComment() {
        let expectation = expectation(description: "Comment")
        
        HackerNewsAPI.shared.getItem(for: 2921983) { result in
            switch result {
            case .success(let item):
                XCTAssertEqual(
                    item,
                    HNItem(
                        id: 2921983,
                        deleted: nil,
                        type: .comment,
                        by: "norvig",
                        time: Date(timeIntervalSince1970: 1314211127),
                        text: "Aw shucks, guys ... you make me blush with your compliments.<p>Tell you what, Ill make a deal: I\'ll keep writing if you keep reading. K?",
                        dead: nil,
                        parent: 2921506,
                        poll: nil,
                        kids: [2922097, 2922429, 2924562, 2922709, 2922573, 2922140, 2922141],
                        url: nil,
                        score: nil,
                        title: nil,
                        parts: nil,
                        descendants: nil
                    )
                )
            case .failure(let error):
                XCTFail("Threw Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func testAsk() {
        let expectation = expectation(description: "Ask")
        
        HackerNewsAPI.shared.getItem(for: 121003) { result in
            switch result {
            case .success(let item):
                XCTAssertEqual(
                    item,
                    HNItem(
                        id: 121003,
                        deleted: nil,
                        type: .story,
                        by: "tel",
                        time: Date(timeIntervalSince1970: 1203647620),
                        text: "<i>or</i> HN: the Next Iteration<p>I get the impression that with Arc being released a lot of people who never had time for HN before are suddenly dropping in more often. (PG: what are the numbers on this? I\'m envisioning a spike.)<p>Not to say that isn\'t great, but I\'m wary of Diggification. Between links comparing programming to sex and a flurry of gratuitous, ostentatious  adjectives in the headlines it\'s a bit concerning.<p>80% of the stuff that makes the front page is still pretty awesome, but what\'s in place to keep the signal/noise ratio high? Does the HN model still work as the community scales? What\'s in store for (++ HN)?",
                        dead: nil,
                        parent: nil,
                        poll: nil,
                        kids: [121016, 121109, 121168],
                        url: nil,
                        score: 25,
                        title: "Ask HN: The Arc Effect",
                        parts: nil,
                        descendants: 16
                    )
                )
            case .failure(let error):
                XCTFail("Threw Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func testJob() {
        let expectation = expectation(description: "Job")
        
        HackerNewsAPI.shared.getItem(for: 192327) { result in
            switch result {
            case .success(let item):
                XCTAssertEqual(
                    item,
                    HNItem(
                        id: 192327,
                        deleted: nil,
                        type: .job,
                        by: "justin",
                        time: Date(timeIntervalSince1970: 1210981217),
                        text: "Justin.tv is the biggest live video site online. We serve hundreds of thousands of video streams a day, and have supported up to 50k live concurrent viewers. Our site is growing every week, and we just added a 10 gbps line to our colo. Our unique visitors are up 900% since January.<p>There are a lot of pieces that fit together to make Justin.tv work: our video cluster, IRC server, our web app, and our monitoring and search services, to name a few. A lot of our website is dependent on Flash, and we\'re looking for talented Flash Engineers who know AS2 and AS3 very well who want to be leaders in the development of our Flash.<p>Responsibilities<p><pre><code>    * Contribute to product design and implementation discussions\n    * Implement projects from the idea phase to production\n    * Test and iterate code before and after production release \n</code></pre>\nQualifications<p><pre><code>    * You should know AS2, AS3, and maybe a little be of Flex.\n    * Experience building web applications.\n    * A strong desire to work on website with passionate users and ideas for how to improve it.\n    * Experience hacking video streams, python, Twisted or rails all a plus.\n</code></pre>\nWhile we\'re growing rapidly, Justin.tv is still a small, technology focused company, built by hackers for hackers. Seven of our ten person team are engineers or designers. We believe in rapid development, and push out new code releases every week. We\'re based in a beautiful office in the SOMA district of SF, one block from the caltrain station. If you want a fun job hacking on code that will touch a lot of people, JTV is for you.<p>Note: You must be physically present in SF to work for JTV. Completing the technical problem at <a href=\"http://www.justin.tv/problems/bml\" rel=\"nofollow\">http://www.justin.tv/problems/bml</a> will go a long way with us. Cheers!",
                        dead: nil,
                        parent: nil,
                        poll: nil,
                        kids: nil,
                        url: "",
                        score: 6,
                        title: "Justin.tv is looking for a Lead Flash Engineer!",
                        parts: nil,
                        descendants: nil
                    )
                )
            case .failure(let error):
                XCTFail("Threw Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func testPollopt() {
        let expectation = expectation(description: "Pollopt")
        
        HackerNewsAPI.shared.getItem(for: 160704) { result in
            switch result {
            case .success(let item):
                XCTAssertEqual(
                    item,
                    HNItem(
                        id: 160704,
                        deleted: nil,
                        type: .poll,
                        by: "pg",
                        time: Date(timeIntervalSince1970: 1207886576),
                        text: "Several users have suggested we ban Valleywag, not for anything in particular that they write about, but because their articles are always such deliberate linkbait.  I personally agree.  In 99% of Valleywag articles, the most interesting thing is the title.  But I don\'t want to be accused of censorship, so I thought I\'d ask for opinions first.",
                        dead: nil,
                        parent: nil,
                        poll: nil,
                        kids: [160896, 160749, 160761, 160778, 160768, 160844, 161031, 160716, 160715, 160848, 160874, 161172, 160849, 160738, 160956, 161035, 161106, 160751, 160714, 160776, 161360, 161322, 160814, 160737, 160727, 160936, 160937, 161242, 161318, 160752, 161329, 160794, 160729, 161715, 161257, 160742, 161694, 162057, 161410, 160791, 160930, 160762, 160807, 162049, 160940, 161945, 160744, 160813],
                        url: nil,
                        score: 75,
                        title: "Poll: Ban Valleywag?",
                        parts: [160705, 160706],
                        descendants: 102
                    )
                )
            case .failure(let error):
                XCTFail("Threw Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
}
