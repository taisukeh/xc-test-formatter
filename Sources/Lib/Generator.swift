import Foundation

public protocol Generator {
  func generateReport(report: Report, plistPath: URL, outDir: URL) throws;
}

extension Generator {
  func generate(report: Report, plistPath: URL, outDir: URL) throws {
    try createOutputDir(outDir: outDir)
    try generateReport(report: report, plistPath: plistPath, outDir: outDir)
  }

  private func createOutputDir(outDir: URL) throws {
    if !FileManager.default.fileExists(atPath: outDir.path) {
      try FileManager.default.createDirectory(atPath: outDir.path,
                                              withIntermediateDirectories: true,
                                              attributes: nil)
    }
  }
}
