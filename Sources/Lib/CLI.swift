import Utility
import Foundation
import Basic

enum Format: String {
  case junit = "junit"
  case html = "html"
}

struct Options {
  var formats = [Format.junit]
  var pathUrl = URL(fileURLWithPath: ".")
  var outDirUrl = URL(fileURLWithPath: ".")
  var outputJson = false
}

public func cli() {
  do {
    // Command description
    let parser = ArgumentParser(commandName: "xcode-test-reporter",
                                usage: "",
                                overview: "Convert xcodebuild plist files to HTML/JUnit reports.")
    // options
    let pathArg = parser.add(option: "--path", shortName: "-p",
                             kind: String.self,
                             usage: "Path containing the plist files (default: .)",
                             completion: .none)

    let outDirArg = parser.add(option: "--output-directory", shortName: "-o",
                              kind: String.self,
                              usage: "Directoy in which the report files should be written to.  Same directory as source by default.",
                              completion: .none)

    let formatArg = parser.add(option: "--format", shortName: "-f",
                               kind: String.self,
                               usage: "The report format to output for (one of 'html', 'junit', or comma-separated values). (default: junit)",
                               completion: .none)

    let outputJsonArg = parser.add(option: "--output-json",
                               kind: Bool.self,
                               usage: "Output command results with JSON",
                               completion: .none)

    var options = Options()

    let args = Array(CommandLine.arguments.dropFirst())
    let result = try parser.parse(args)

    if let path = result.get(pathArg) {
      options.pathUrl = URL(fileURLWithPath: path)
    }

    if let outDir = result.get(outDirArg) {
      options.outDirUrl = URL(fileURLWithPath: outDir)
    } else {
      // Same directory as path by default
      if isDirectory(options.pathUrl) {
        options.outDirUrl = options.pathUrl
      } else {
        options.outDirUrl = options.pathUrl.deletingLastPathComponent()
      }
    }

    if let formatsStr = result.get(formatArg) {
      let formats = formatsStr.components(separatedBy: ",")

      options.formats = formats.map { formatStr -> Format in
        if let format = Format(rawValue: formatStr) {
          return format
        }
        printError("unknown format '\(formatStr)'")
        exit(1)
      }
    }

    options.outputJson = result.get(outputJsonArg) ?? false


    try main(options: options)
  } catch ArgumentParserError.expectedValue(let value) {
    printError("Missing value for argument \(value).")
  } catch ArgumentParserError.expectedArguments(let parser, _) {
    parser.printUsage(on: stderrStream)
  } catch {
    printError("\(error)")
  }
}

func plistFiles(pathUrl: Foundation.URL) throws  -> [String] {
  var isDirectory: ObjCBool = ObjCBool(false)

  let exists = FileManager.default.fileExists(atPath: pathUrl.path, isDirectory: &isDirectory)

  if !exists {
    printError("file or directory not found at the path.")
    exit(1)
  }

  if isDirectory.boolValue {
    let files = try FileManager.default.contentsOfDirectory(atPath: pathUrl.path)
    return files.filter { $0.hasSuffix("TestSummaries.plist") }
  } else {
    return [pathUrl.path]
  }
}

func main(options: Options) throws {
  let files = try plistFiles(pathUrl: options.pathUrl)

  if files.isEmpty {
    printError("No test result files found in directory '\(options.pathUrl.path)', make sure the file name ends with 'TestSummaries.plist\n")
    
    exit(1)
  }

  let output: CommandOutput = options.outputJson ? JsonCommandOutput() : TextCommandOutput()

  try files.forEach { file in
    let fileUrl = URL(fileURLWithPath: file, relativeTo: options.pathUrl)
    try generateReport(plistUrl: fileUrl, options: options, output: output)
  }

  output.outputAtLast()
}

func decodePlist<T>(_ type: T.Type, plistUrl: Foundation.URL) throws -> T where T : Decodable {
  let data = try Data(contentsOf: plistUrl)
  let decoder = PropertyListDecoder()
  return try decoder.decode(type, from: data)
}

func generateReport(plistUrl: Foundation.URL, options: Options, output: CommandOutput) throws {
  let report = try decodePlist(Report.self, plistUrl: plistUrl)

  try options.formats.forEach { format in
    let fileUrl: Foundation.URL
    switch format {
    case .html:
      fileUrl = try HtmlGenerator().generate(report: report,
                                             plistPath: plistUrl,
                                             outDir: options.outDirUrl)
    case .junit:
      fileUrl = try JUnitGenerator().generate(report: report,
                                              plistPath: plistUrl,
                                              outDir: options.outDirUrl)
    }

    output.reportGenerated(report: report, file: fileUrl)
  }
}

func isDirectory(_ url: Foundation.URL) -> Bool {
  var isDirectory: ObjCBool = ObjCBool(false)

  let exists = FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)

  if !exists {
    printError("file or directory not found at `\(url.path)`.")
    exit(1)
  }

  return isDirectory.boolValue
}

func printError(_ s: String) {
  stderrStream.write(s)
  stderrStream.flush()
}
