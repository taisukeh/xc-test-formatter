import Utility
import Foundation
import Basic

public func cli() {
  do {
    // CLIツールについての説明
    let parser = ArgumentParser(commandName: "xcode-test-reporter",
                                usage: "[--path <path>] [--output_directory <path>]",
                                overview: "Convert xcodebuild plist files to HTML/JUnit reports.")
    // --query オプションを追加
    let pathArg = parser.add(option: "--path", shortName: "-p",
                             kind: String.self,
                             usage: "Path containing the plist files (default: .)",
                             completion: .none)

    let outDirArg = parser.add(option: "--output_directory", shortName: "-o",
                              kind: String.self,
                              usage: "Directoy in which the report files should be written to (default: ./report)",
                              completion: .none)

    // 引数をパースしてクエリを取得
    let args = Array(CommandLine.arguments.dropFirst())
    let result = try parser.parse(args)

    let path = result.get(pathArg) ?? "."
    let outDir = result.get(outDirArg) ?? "report"


    // 実行
    try main(path: path, outDir: outDir)
  } catch ArgumentParserError.expectedValue(let value) {
    print("Missing value for argument \(value).")
  } catch ArgumentParserError.expectedArguments(let parser, let stringArray) {
    parser.printUsage(on: stdoutStream)
  } catch {
    print("\(error)")
  }
}

func plistFiles(path: String) throws  -> [String] {
  let files = try FileManager.default.contentsOfDirectory(atPath: path)

  return files.filter { $0.hasSuffix("TestSummaries.plist") }
}

func main(path: String, outDir: String) throws {
  let files = try plistFiles(path: path)

  if files.isEmpty {
    printError("No test result files found in directory '\(path)', make sure the file name ends with 'TestSummaries.plist\n")
    
    exit(1)
  }

  let pathUrl = URL(fileURLWithPath: path)

  try files.forEach { file in
    let fileUrl = URL(fileURLWithPath: file, relativeTo: pathUrl)
    try generateReport(plistUrl: fileUrl)
  }
}

func generateReport(plistUrl: Foundation.URL) throws {
  let data = try Data(contentsOf: plistUrl)
  let decoder = PropertyListDecoder()
  let r = try decoder.decode(Report.self, from: data)

  let basePath = FileManager.default.currentDirectoryPath
  let outurl = URL(fileURLWithPath: "report3")
  
  try HtmlGenerator().generate(report: r, plistPath: plistUrl, outDir: outurl)
  try JUnitGenerator().generate(report: r, plistPath: plistUrl, outDir: outurl)
}

func printError(_ s: String) {
  stderrStream.write(s)
  stderrStream.flush()
}
