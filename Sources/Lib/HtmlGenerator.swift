import Foundation

public class HtmlGenerator: Generator {
  public init() {}

  public func generateReport(report: Report, plistPath: URL, outDir: URL) throws -> URL {
    let reportSummary = ReportSummary(report: report)

    let jsonEncoder = JSONEncoder()

    let html = html_index(
      reportData: String(data: try! jsonEncoder.encode(report), encoding: .utf8)!,
      reportSummaryData: String(data: try! jsonEncoder.encode(reportSummary), encoding: .utf8)!
    )

    let fileName = outputFileName(plistPath: plistPath, ext: "html")
    let htmlUrl = outDir.appendingPathComponent(fileName)

    try html.write(to: htmlUrl, atomically: true, encoding: .utf8)

    try copyAttachments(report: report, plistPath: plistPath, outDir: outDir)
    try copyLogo(outDir: outDir)

    return htmlUrl
  }

  func copyAttachments(report: Report, plistPath: URL, outDir: URL) throws {
    
    let plistDirUrl = plistPath.deletingLastPathComponent()
    let files = attachmentFiles(report: report)
    
    let attachmentsDir = plistDirUrl.appendingPathComponent("Attachments")
    let outAttachmentsDir = outDir.appendingPathComponent("Attachments")

    if !FileManager.default.fileExists(atPath: outAttachmentsDir.path) {
      try FileManager.default.createDirectory(atPath: outAttachmentsDir.path,
                                              withIntermediateDirectories: true,
                                              attributes: nil)
    }


    files.forEach { file in
      do {
        try FileManager.default.copyItem(at: attachmentsDir.appendingPathComponent(file),
                                         to: outAttachmentsDir.appendingPathComponent(file))
      } catch {
        
      }
    }
  }

  func copyLogo(outDir: URL) throws {
    let outUrl = outDir.appendingPathComponent("XcodeTestReporter.svg")

    try svg_XcodeTestReporter.write(to: outUrl, atomically: true, encoding: .utf8)
  }

  func attachmentFiles(report: Report) -> [String] {
    return report.TestableSummaries.flatMap { summary in
      attachmentFiles(tests: summary.Tests)
    }
  }

  func attachmentFiles(tests: [Test]?) -> [String] {

    guard let tests = tests else { return [] }
    return tests.flatMap { attachmentFiles(test: $0) }
  }

  func attachmentFiles(test: Test) -> [String] {
    var files: [String] = []
      
    let activitySummaries = test.ActivitySummaries ?? []

    activitySummaries.forEach { activitySummary in
      guard let attachments = activitySummary.Attachments else { return }

      attachments.forEach { attachment in
        files.append(attachment.Filename)
      }
    }

    files.append(contentsOf: attachmentFiles(tests: test.Subtests))

    return files
  }
}
