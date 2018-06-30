import XCTest
import DVR
import LazyNap

class ConfigTests: XCTestCase {

    func testInit() {
        let session = URLSession.shared
        let config = Config(session: session, scheme: "https", host: "example.com", port: 8080)
        XCTAssertEqual("https", config.scheme)
        XCTAssertEqual("example.com", config.host)
        XCTAssertEqual(8080, config.port)
        XCTAssertNil(config.auth)
    }
}
