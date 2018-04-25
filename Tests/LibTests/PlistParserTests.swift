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

    func testParse() throws {
      guard let url = URL(string: "file:///Users/tahori/workspace/xc-test-reporter/Tests/LibTests/fixtures/TestSummaries0.plist") else { XCTFail(); return }

      let data = try Data(contentsOf: url)
      let decoder = PropertyListDecoder()
      let r = try decoder.decode(Report.self, from: data)

      HtmlGenerator().generate(report: r)

      // XCTAssertEqual(PlistParser().parse(), 10)
    }
}
