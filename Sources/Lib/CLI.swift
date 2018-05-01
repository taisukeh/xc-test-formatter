import Utility
import Foundation
import Basic

public func cli() {
  do {
    // CLIツールについての説明
    let parser = ArgumentParser(commandName: "xcode-test-reporter",
                                usage: "query [--query swift]", overview: "It's a just sample for swift package manager.")
    // --query オプションを追加
    let queryArg = parser.add(option: "--query", shortName: "-q", kind: String.self, usage: "A word what you want to search repository in GitHub.com", completion: .none)
    // 引数をパースしてクエリを取得
    let args = Array(CommandLine.arguments.dropFirst())
    let result = try parser.parse(args)
    guard let query = result.get(queryArg) else {
      throw ArgumentParserError.expectedArguments(parser, ["query"])
    }
    // 実行
    // main(query: query)
  } catch ArgumentParserError.expectedValue(let value) {
    print("Missing value for argument \(value).")
  } catch ArgumentParserError.expectedArguments(let parser, let stringArray) {
    parser.printUsage(on: stdoutStream)
  } catch {
    print(error.localizedDescription)
  }
}
