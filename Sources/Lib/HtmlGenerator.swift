import Foundation
import Stencil

public class HtmlGenerator {
  public init() {}

  public func generate(report: Report) {
    let context = [
      "report": report,
    ]

    let environment = Environment(loader: FileSystemLoader(paths: ["/Users/tahori/workspace/xc-test-reporter/Sources/Lib/Html/"]))
    let rendered = try! environment.renderTemplate(name: "index.html", context: context)
    print(rendered)
  }
}
