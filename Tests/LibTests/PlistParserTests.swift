import XCTest
import Foundation
@testable import Lib

class PlistParserTests: XCTestCase {
  override func setUp() {
    super.setUp()
  }

  static var allTests = [
    ("testParse", testParse),
  ]

  func testParse() throws {
    let plist = "file:///Users/tahori/Library/Developer/Xcode/DerivedData/TestApp0-eokgthoeibfdbbczwrztpepdinxt//Logs/Test/5F749F97-27BC-4ACA-B201-9257FFD24B76_TestSummaries.plist"
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
