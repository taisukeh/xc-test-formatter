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
    let plist = "Tests/LibTests/fixtures/TestSummaries0.plist"

    let url = URL(fileURLWithPath: plist)

    let data = try Data(contentsOf: url)
    let decoder = PropertyListDecoder()
    let r = try decoder.decode(Report.self, from: data)

    let outurl = URL(fileURLWithPath: "test_report")

    let _ = try HtmlGenerator().generate(report: r, plistPath: url, outDir: outurl)
    let _ = try JUnitGenerator().generate(report: r, plistPath: url, outDir: outurl)
  }
}
