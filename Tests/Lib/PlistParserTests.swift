import XCTest
import Foundation
@testable import Lib

class PlistParserTests: XCTestCase {
  let parser = PlistTestParser()

    override func setUp() {
        super.setUp()
    }

    func testGenerate() throws {
      let file = URL(fileURLWithPath: "/Users/tahori/workspace/xc-test-reporter/Tests/Lib/fixtures/TestSummaries0.plist")
      let d = try PropertyListDecoder().decode(Report.self, from: Data(contentsOf: file))
      print("\(d)")
      // XCTAssertEqual(PlistParser().parse(), 10)
    }
}
