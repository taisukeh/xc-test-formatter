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

      let html = HtmlGenerator().generate(report: r)

      guard let outurl = URL(string: "file:///Users/tahori/workspace/xc-test-reporter/report.html") else { XCTFail(); return }
      
      try html.write(to: outurl, atomically: true, encoding: .utf8)

      // XCTAssertEqual(PlistParser().parse(), 10)
    }
}
