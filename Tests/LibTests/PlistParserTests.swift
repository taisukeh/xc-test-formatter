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
      let plist = "file:///Users/tahori/Library/Developer/Xcode/DerivedData/TestApp0-eokgthoeibfdbbczwrztpepdinxt//Logs/Test/BDA1400A-4908-4155-9573-DD8B12483C28_TestSummaries.plist"
      // let plist = "file:///Users/tahori/workspace/xc-test-reporter/Tests/LibTests/fixtures/TestSummaries0.plist"

      guard let url = URL(string: plist) else { XCTFail(); return }

      let data = try Data(contentsOf: url)
      let decoder = PropertyListDecoder()
      let r = try decoder.decode(Report.self, from: data)

      guard let outurl = URL(string: "file:///Users/tahori/workspace/xc-test-reporter/report") else { XCTFail(); return }
      
      try HtmlGenerator().generate(report: r, plistPath: url, outDir: outurl)
      // XCTAssertEqual(PlistParser().parse(), 10)
    }
}
