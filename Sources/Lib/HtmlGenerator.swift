import Foundation

public class HtmlGenerator {
  public init() {}

  public func generate(report: Report) -> String {

    let jsonEncoder = JSONEncoder()
    let jsonData = try! jsonEncoder.encode(report)
    let jsonString = String(data: jsonData, encoding: .utf8)!
    return html_index(stateData: jsonString)
  }
}
