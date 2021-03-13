import XCTest
@testable import HackerNewsAPI

final class HackerNewsAPITests: XCTestCase {
    
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
    
    func testUser() {
        let expectation = expectation(description: "User")
        
        HackerNewsAPI.shared.getUser(for: "jl") { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(
                    user,
                    HNUser(
                        id: "jl",
                        created: Date(timeIntervalSince1970: 1173923446),
                        karma: 4240,
                        about: "This is a test",
                        submitted: [25172559, 25172553, 19464269, 18498213, 16659709, 16659632, 16659556, 14237416, 11871616, 11483492, 11435082, 10985073, 10985027, 10984914, 10977351, 10969209, 10959149, 10918078, 10917848, 10897434, 10897419, 10897400, 10897365, 10868971, 10789678, 10784059, 10771938, 10756942, 10756938, 10756363, 10756187, 10755845, 10755835, 10755110, 10754784, 10754725, 10754649, 10749883, 10748263, 10748225, 10603008, 10603006, 10602989, 10488665, 10462014, 10459072, 10459039, 10459015, 10458960, 10389721, 10389705, 10389701, 10389693, 10389610, 10388321, 10384739, 10335836, 10324863, 10324857, 10324848, 10324844, 10324800, 10267145, 10216820, 10138032, 10138023, 10138017, 10138015, 10138006, 10138003, 10137996, 10070131, 10057381, 10046162, 10046157, 10046148, 10046142, 10046136, 10031224, 10017640, 10014388, 10014384, 10014383, 10013892, 9983286, 9965276, 9944027, 9931262, 9931248, 9931243, 9931236, 9927203, 9926118, 9926098, 9926091, 9926082, 9926080, 9892726, 9889770, 9889757, 9889753, 9889175, 9888406, 9888397, 9880421, 9856308, 9856301, 9842816, 9842802, 9841910, 9769088, 9769058, 9769050, 9769043, 9768591, 9768584, 9768572, 9768555, 9768540, 9740780, 9740582, 9736940, 9736939, 9736936, 9736935, 9736933, 9736928, 9733984, 9733691, 9721848, 9721828, 9721810, 9717442, 9717434, 9717420, 9704379, 9689518, 9689499, 9688210, 9688097, 9671630, 9649803, 9649783, 9649759, 9615172, 9615148, 9615142, 9591089, 9591086, 9591048, 9590791, 9585968, 9574037, 9574032, 9542195, 9536122, 9536113, 9536105, 9536094, 9536084, 9536077, 9501689, 9500565, 9467152, 9463339, 9462573, 9461893, 9461545, 9455344, 9298148, 9282319, 9282316, 9277853, 9273170, 9266803, 9247412, 9223698, 9223212, 9199788, 9199775, 9199737, 9155146, 9155137, 9155133, 9154030, 9154015, 9142478, 9141425, 9141412, 9141400, 9141388, 9141381, 9125298, 9124737, 9122174, 9122168, 9122160, 9122150, 9122146, 9116041, 9097991, 9096038, 9083989, 9049959, 9036326, 9036314, 9036310, 9036305, 9036297, 9006991, 8973383, 8944551, 8944544, 8902284, 8852964, 8852952, 8852587, 8852563, 8852546, 8852538, 8842759, 8842752, 8835420, 8835416, 8835339, 8835334, 8835333, 8835332, 8835331, 8835330, 8835313, 8835309, 8835294, 8765464, 8765462, 8719703, 8707068, 8692169, 8692164, 8692156, 8692150, 8692142, 8644017, 8559539, 8559525, 8525548, 8508976, 8327031, 8282120, 8265435, 8229264, 8229255, 8168423, 8090946, 8090326, 8087590, 8083679, 8038290, 8023719, 8023709, 8015238, 8015175, 7946624, 7946606, 7946592, 7946583, 7946572, 7946570, 7908266, 7908256, 7908254, 7908224, 7908220, 7848552, 7746770, 7746761, 7746739, 7740258, 7699907, 7692153, 7637962, 7630084, 7596179, 7596163, 7594569, 7562135, 7562111, 7494708, 7494171, 7488093, 7444860, 7327817, 7280290, 7278694, 7221605, 7109714, 7097557, 7097546, 7097254, 7073740, 7052857, 7039484, 7026281, 7026268, 7026239, 7026229, 7026204, 7026194, 7026157, 7026132, 6987273, 6649999, 6649706, 6629560, 6609127, 6454453, 6454452, 6327951, 6225810, 6170349, 6170337, 6170336, 6170325, 6170318, 6111999, 6094114, 6094113, 6094112, 6094095, 6094086, 6061785, 6061780, 6061769, 6001004, 5948788, 5871202, 5871195, 5727900, 5727897, 5580079, 5215202, 5215185, 5215164, 5215155, 5215135, 5112008, 4907948, 4901821, 4700469, 4678919, 3779193, 3711380, 3701405, 3627981, 3567812, 3567800, 3516606, 3516595, 3516590, 3473004, 3473000, 3457006, 3422158, 3136701, 2943046, 2843803, 2843795, 2843790, 2843777, 2794646, 2610670, 2610662, 2610654, 2609719, 2605175, 2605171, 2605164, 2582102, 2582045, 2581878, 2581817, 2581220, 2581219, 2581210, 2581202, 2581196, 2581188, 2482737, 2425640, 2411925, 2408077, 2407992, 2407940, 2278689, 2220295, 2144918, 2144852, 2141543, 2141539, 2141526, 2141489, 2118128, 2118124, 2118118, 2081167, 2081160, 2081151, 1952092, 1952082, 1875323, 1875295, 1857397, 1839737, 1809010, 1788048, 1780681, 1721745, 1676227, 1654023, 1651449, 1641019, 1631985, 1618759, 1522978, 1499641, 1473612, 1473538, 1441290, 1440993, 1436440, 1430510, 1430208, 1385525, 1384917, 1370453, 1346118, 1309968, 1305415, 1305037, 1278191, 1276771, 1270981, 1233287, 1211456, 1210688, 1210682, 1194189, 1193914, 1191653, 1190766, 1190319, 1189925, 1188455, 1188177, 1185884, 1165649, 1164314, 1160048, 1159156, 1158865, 1150900, 1115326, 1048592, 1038165, 1038119, 1038111, 1037828, 1037802, 1037794, 1036098, 1036090, 1036088, 1036017, 1036013, 1036001, 1035597, 1035596, 1035583, 1035547, 1035522, 1031332, 1031317, 1031271, 1031220, 1031166, 1031144, 1031124, 1010260, 997582, 997406, 982020, 974865, 973272, 973249, 973243, 971563, 968717, 966625, 965431, 965426, 961781, 933897, 924482, 923918, 922804, 922280, 922168, 920332, 919803, 917871, 912867, 910426, 902506, 891171, 807902, 806254, 796618, 786286, 764412, 764325, 683280, 683278, 683277, 681298, 681292, 670780, 669024, 666099, 666094, 666088, 665126, 661139, 661137, 661116, 661112, 660991, 657992, 657991, 655771, 655756, 655045, 651415, 651014, 650414, 650360, 649346, 649341, 649337, 643696, 642669, 642566, 642564, 641399, 640453, 639861, 638373, 638217, 629567, 627440, 626275, 596735, 591790, 591788, 591600, 587821, 575744, 547504, 532055, 521067, 506071, 492164, 491979, 440927, 440623, 435998, 435989, 435877, 435433, 435392, 421232, 416434, 413659, 413378, 413375, 413374, 413170, 409216, 409013, 406909, 403847, 402629, 390733, 390313, 387154, 386361, 386331, 385036, 385030, 384528, 384501, 383935, 383933, 383930, 383927, 383733, 375462, 296171, 295839, 263479, 258389, 252233, 251388, 251387, 250751, 245736, 245140, 243472, 240254, 240244, 240239, 237445, 234246, 233381, 233274, 232621, 232511, 232260, 232196, 232177, 232098, 232072, 232023, 232011, 231996, 231985, 229393, 226797, 226452, 226130, 226123, 225683, 225603, 225536, 225512, 225511, 225483, 225426, 224366, 224320, 223259, 221774, 221251, 221247, 221141, 221136, 221084, 221068, 221055, 221037, 221023, 221007, 220991, 220979, 220880, 220775, 220766, 220727, 220030, 220029, 213940, 213342, 212733, 211703, 211552, 211526, 211238, 210099, 210007, 209913, 209908, 209904, 209903, 177945, 170904, 165850, 161566, 158388, 158305, 158294, 156235, 151097, 148566, 147860, 146948, 146133, 145128, 142137, 141643, 136968, 134690, 134656, 134483, 133455, 129765, 128311, 126740, 126736, 126494, 125122, 124168, 123447, 123446, 122101, 122100, 121852, 121705, 121608, 121605, 120867, 120492, 119265, 119177, 115999, 114492, 114304, 111730, 110980, 110451, 110078, 108420, 107214, 107208, 107173, 107165, 106980, 106607, 106512, 106508, 105150, 104735, 103188, 103187, 102562, 102534, 102510, 102476, 101694, 101035, 101011, 100629, 100084, 99902, 99472, 99352, 99282, 99122, 98972, 98886, 98858, 98852, 98849, 98848, 98842, 98417, 98416, 98232, 98231, 96536, 96522, 96498, 96452, 96451, 96450, 96448, 96447, 96446, 96436, 96432, 96417, 96192, 96108, 96007, 96005, 95623, 95487, 95475, 95471, 95467, 95466, 95421, 95394, 95327, 95326, 95324, 95322, 95001, 95000, 94955, 94952, 94922, 94920, 94919, 94681, 94679, 94678, 94420, 94419, 94393, 94149, 94008, 93490, 93489, 92944, 92247, 91713, 90162, 90091, 89844, 89678, 89498, 86953, 86109, 85244, 85195, 85194, 85193, 85192, 84955, 84629, 83902, 82918, 76393, 68677, 61565, 60542, 47745, 47744, 41098, 39153, 38678, 37741, 33469, 12897, 6746, 5252, 4752, 4586, 4289]
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
