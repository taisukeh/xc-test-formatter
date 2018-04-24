import Foundation

public class PlistTestParser {
  public init() {
  }

  public func parse(file: String) -> NSDictionary? {
    return NSDictionary(contentsOfFile: file)
  }
}

