import Foundation

public class JUnitGenerator: Generator {
  public init() {
  }

  public func generateReport(report: Report, plistPath: URL, outDir: URL) throws {
    let xml = testsuites(report: report)
    let fileUrl = outDir.appendingPathComponent("junit.xml")

    try xml.write(to: fileUrl, atomically: true, encoding: .utf8)
  }

  func testsuites(report: Report) -> String {
    let device = report.RunDestination.TargetDevice
    let name = "\(device.ModelName), \(device.OperatingSystemVersion), \(device.Platform.Name)"
    
    return """
<?xml version="1.0" encoding="UTF-8" ?> 
<testsuites name="\(name)" tests="\(report.testSummary.tests)" errors="0" failures="\(report.testSummary.failed)" time="\(report.Duration)">
\(report.TestableSummaries.map { testsuite($0) }.joined(separator: "\n") )
</testsuites>
"""
  }

  func testsuite(_ summary: TestableSummary) -> String {
    guard let test0 = summary.Tests[safe: 0],
          let tests1 = test0.Subtests,
          let test2 = tests1[safe: 0] else { return "" }

    return """
      <testsuite id="\(summary.TargetName.xmlEscape)" name="\(summary.TestName.xmlEscape)" tests="\(summary.testSummary.tests)" failures="\(summary.testSummary.failed)" time="\(summary.Duration)">
      \((test2.Subtests ?? []).map { test($0) }.joined(separator: "\n") )
      </testsuite>
"""
  }

  func test(_ test: Test) -> String {
    return """
      <testcase id="\(test.TestIdentifier.xmlEscape)" name="\(test.TestName.xmlEscape)" time="\(test.Duration)">
      \((test.FailureSummaries ?? []).map { failure($0) }.joined(separator: "\n"))
      </testcase>
"""
  }

  func failure(_ failure: FailureSummary) -> String {
    return """
      <failure message="\(failure.Message.xmlEscape)">
File: \(failure.FileName.xmlEscape)
Line: \(failure.LineNumber)
Message: \(failure.Message.xmlEscape)
      </failure>
"""
  }
}
