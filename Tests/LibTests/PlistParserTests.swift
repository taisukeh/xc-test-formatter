import XCTest
@testable import Lib

class PlistParserTests: XCTestCase {
  let parser = PlistTestParser()

    override func setUp() {
        super.setUp()
    }

    static var allTests = [
        ("testParse", testParse),
    ]

    func testParse() {
      if let d = parser.parse(file: "Tests/LibTests/fixtures/TestSummaries0.plist") {
        print("\(d)")
      } else {
        print("oopss")
      }
      // XCTAssertEqual(PlistParser().parse(), 10)
    }
}
