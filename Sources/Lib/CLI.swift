import Utility
import Foundation
import Basic

enum Format: String {
  case junit = "junit"
  case html = "html"
}

struct Options {
  var junitFileName = "junit.xml"
  var htmlFileName = "index.html"
  var formats = [Format.junit]
  var path = "."
  var outDir = "."

  var pathUrl: Foundation.URL {
    return URL(fileURLWithPath: path)
  }

  var outDirUrl: Foundation.URL {
    return URL(fileURLWithPath: outDir)
  }
}

public func cli() {
  do {
    // Command description
    let parser = ArgumentParser(commandName: "xcode-test-reporter",
                                usage: "[--path <path>] [--output_directory <path>]",
                                overview: "Convert xcodebuild plist files to HTML/JUnit reports.")
    // options
    let pathArg = parser.add(option: "--path", shortName: "-p",
                             kind: String.self,
                             usage: "Path containing the plist files (default: .)",
                             completion: .none)

    let outDirArg = parser.add(option: "--output-directory", shortName: "-o",
                              kind: String.self,
                              usage: "Directoy in which the report files should be written to (default: ./report)",
                              completion: .none)

    let formatArg = parser.add(option: "--format", shortName: "-f",
                               kind: String.self,
                               usage: "The report format to output for (one of 'html', 'junit', or comma-separated values). (default: junit)",
                               completion: .none)

    let junitFileNameArg = parser.add(option: "--junit-file-name", shortName: "-j",
                               kind: String.self,
                               usage: "The report file name for junit (default : junit.xml)",
                               completion: .none)

    let htmlFileNameArg = parser.add(option: "--html-file-name", shortName: "-l",
                                     kind: String.self,
                                     usage: "The report file name for junit (default : index.html)",
                                     completion: .none)

    var options = Options()

    let args = Array(CommandLine.arguments.dropFirst())
    let result = try parser.parse(args)

    options.path = result.get(pathArg) ?? options.path
    options.outDir = result.get(outDirArg) ?? options.path // Same directory as path by default

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


    options.junitFileName = result.get(junitFileNameArg) ?? options.junitFileName
    options.htmlFileName = result.get(htmlFileNameArg) ?? options.htmlFileName

    try main(options: options)
  } catch ArgumentParserError.expectedValue(let value) {
    print("Missing value for argument \(value).")
  } catch ArgumentParserError.expectedArguments(let parser, _) {
    parser.printUsage(on: stdoutStream)
  } catch {
    print("\(error)")
  }
}

func plistFiles(path: String) throws  -> [String] {
  let files = try FileManager.default.contentsOfDirectory(atPath: path)

  return files.filter { $0.hasSuffix("TestSummaries.plist") }
}

func main(options: Options) throws {
  let files = try plistFiles(path: options.path)

  if files.isEmpty {
    printError("No test result files found in directory '\(options.path)', make sure the file name ends with 'TestSummaries.plist\n")
    
    exit(1)
  }

  try files.forEach { file in
    let fileUrl = URL(fileURLWithPath: file, relativeTo: options.pathUrl)
    try generateReport(plistUrl: fileUrl, options: options)
  }
}

func decodePlist<T>(_ type: T.Type, plistUrl: Foundation.URL) throws -> T where T : Decodable {
  let data = try Data(contentsOf: plistUrl)
  let decoder = PropertyListDecoder()
  return try decoder.decode(type, from: data)
}

func generateReport(plistUrl: Foundation.URL, options: Options) throws {
  let report = try decodePlist(Report.self, plistUrl: plistUrl)

  try options.formats.forEach { format in
    switch format {
    case .html:
      try HtmlGenerator().generate(report: report,
                                   plistPath: plistUrl,
                                   outDir: options.outDirUrl,
                                   fileName: options.htmlFileName)
    case .junit:
      try JUnitGenerator().generate(report: report,
                                    plistPath: plistUrl,
                                    outDir: options.outDirUrl,
                                    fileName: options.junitFileName)
    }
  }
}

func printError(_ s: String) {
  stderrStream.write(s)
  stderrStream.flush()
}
