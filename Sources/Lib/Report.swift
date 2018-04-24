public struct Report: Codable {
  let FormatVersion: String
  let RunDestination: RunDestination
  let TestableSummaries: [TestableSummary]
}

public struct RunDestination: Codable {
  let LocalComputer: LocalComputer
  let Name: String
  let TargetArchitecture: String
}

public struct LocalComputer: Codable {
  let ModelCode: String
  let ModelName: String
  let Name: String
  let NativeArchitecture: String
  let OperatingSystemVersion: String
  let OperatingSystemVersionWithBuildNumber: String
  let Platform: Platform
}

public struct TargetDevice: Codable {
  let ModelCode: String
  let ModelName: String
  let Name: String
  let NativeArchitecture: String
  let OperatingSystemVersion: String
  let OperatingSystemVersionWithBuildNumber: String
  let Platform: Platform
}

public struct Platform: Codable {
  let Identifier: String
  let Name: String
}

public struct TargetSDK: Codable {
  let Identifier: String
  let Name: String
  let OperatingSystemVersion: String
}

public struct TestableSummary: Codable {
  let ProjectPath: String
  let TargetName: String
  let TestName: String
  let Tests: [Test]
}

public struct Test: Codable {
  let Duration: Double
  let Subtests: [Test]?
  let TestIdentifier: String
  let TestName: String
  let TestObjectClass: String
  let TestStatus: String?
  let FailureSummaries: [FailureSummary]?
  let ActivitySummaries: [ActivitySummary]?
}

public enum TestStatus: String, Codable {
  case success = "Success"
  case failure = "Failure"
}

public struct FailureSummary: Codable {
  let FileName: String
  let LineNumber: Int
  let Message: String
  let PerformanceFailure: Bool
}

public struct ActivitySummary: Codable {
  let ActivityType: String

  let Attachments: [Attachment]? // com.apple.dt.xctest.activity-type.attachmentContainer
  let Title: String
}

public struct Attachment: Codable {
  let Filename: String
  let HasPayload: Bool
  let Lifetime: Int
  let Name: String
  let Timestamp: Double
  let UniformTypeIdentifier: String
}

public struct UserInfo: Codable {
  let Scale: Int
}
