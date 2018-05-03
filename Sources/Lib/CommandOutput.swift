import Foundation

protocol CommandOutput {
  func reportGenerated(report: Report, file: URL)
  func outputAtLast()
}

class TextCommandOutput: CommandOutput {
  func reportGenerated(report: Report, file: URL) {
    print("Generated: \(file.path)")
  }

  func outputAtLast() {
    // do nothing
  }
}

class JsonCommandOutput: CommandOutput {
  struct ReportResult: Codable {
    let file: String
    let success: Bool
  }

  private var reports: [ReportResult] = []

  func reportGenerated(report: Report, file: URL) {
    reports.append(ReportResult(file: file.path, success: report.testSummary.isSuccess))
  }

  func outputAtLast() {
    let encoder = JSONEncoder()
    let data = try! encoder.encode(reports)
    print(String(data: data, encoding: String.Encoding.utf8)!)
  }
}
