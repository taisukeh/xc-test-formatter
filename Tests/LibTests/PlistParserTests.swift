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
    let basePath = FileManager.default.currentDirectoryPath
    let plist = "Tests/LibTests/fixtures/TestSummaries0.plist"

    guard let url = URL(string: "file://\(basePath)/\(plist)") else { XCTFail(); return }

    let data = try Data(contentsOf: url)
    let decoder = PropertyListDecoder()
    let r = try decoder.decode(Report.self, from: data)

    guard let outurl = URL(string: "file://\(basePath)/report") else { XCTFail(); return }
    
    try HtmlGenerator().generate(report: r, plistPath: url, outDir: outurl)
    // XCTAssertEqual(PlistParser().parse(), 10)
  }
}
