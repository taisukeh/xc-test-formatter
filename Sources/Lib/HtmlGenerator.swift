import Foundation

public class HtmlGenerator {
  public init() {}

  public func generate(report: Report) -> String {

    return reportPage(report: report)
  }

  func html(title: String, body: String) -> String {
    return """
<!DOCTYPE html>
<html lang="en">
<head>

<title>\(title)</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://cdn.rawgit.com/Chalarangelo/mini.css/v2.3.7/dist/mini-default.min.css">
</head>

<body>

\(body)

</body>
</html>
"""
}

  func localComputerTable(localComputer: LocalComputer) -> String {
    return """
      <table class="horizontal">
        <caption>Local Computer</caption>
        <thead>
          <tr>
            <th>Model</th>
            <th>OS</th>
            <th>CPU</th>
            <th>RAM</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td data-label="Model">\(localComputer.ModelName)</td>
            <td data-label="OS">\(localComputer.Platform.Name + " " + localComputer.OperatingSystemVersion)</td>
            <td data-label="CPU">\(localComputer.CPUKind) \(localComputer.CPUSpeedInMHz)MHz, \(localComputer.LogicalCPUCoresPerPackage) core)</td>
            <td data-label="RAM">\(localComputer.RAMSizeInMegabytes) MB</td>
          </tr>
        </tbody>
      </table>
"""    
  }


  func targetDeviceTable(targetDevice: TargetDevice) -> String {
    return """
      <table class="horizontal">
        <caption>Target Device</caption>
        <thead>
          <tr>
            <th>Model</th>
            <th>Architecture</th>
            <th>OS</th>
            <th>Platform</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td data-label="Model Name">\(targetDevice.ModelName)</td>
            <td data-label="Architecture">\(targetDevice.NativeArchitecture)</td>
            <td data-label="OS">\(targetDevice.OperatingSystemVersion)</td>
            <td data-label="Platform Version">\(targetDevice.Platform.Name)</td>
          </tr>
        </tbody>
      </table>
"""    
  }

  func reportPage(report: Report) -> String {
    let body = """
<div class="container">
  <div class="row">
    <div class="col-sm-3">
      \(targetDeviceTable(targetDevice: report.RunDestination.TargetDevice))
      \(localComputerTable(localComputer: report.RunDestination.LocalComputer))
    </div>
  </div>
  <div class="row">
    <div class="col-sm">
    </div>
  </div>
</div>
"""


    return html(title: "Xcode Test Report",
                body: body)
  }
}
