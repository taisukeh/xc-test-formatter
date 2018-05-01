import Foundation

public struct Report: Codable {
  let FormatVersion: String
  let RunDestination: RunDestination
  let TestableSummaries: [TestableSummary]

  var testSummary: TestSummary {
    return TestableSummaries.reduce(into: TestSummary()) { $0 += $1.testSummary }
  }

  var Duration: Double {
    return TestableSummaries.reduce(0.0) { $0 + $1.Duration }
  }
}

public struct RunDestination: Codable {
  let LocalComputer: LocalComputer
  let Name: String
  let TargetArchitecture: String
  let TargetDevice: TargetDevice
}

public struct LocalComputer: Codable {
  let CPUKind: String
  let LogicalCPUCoresPerPackage: Int
  let CPUSpeedInMHz: Int
  let RAMSizeInMegabytes: Int
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

  var testSummary: TestSummary {
    return Tests.reduce(into: TestSummary()) { $0 += $1.testSummary }
  }

  var Duration: Double {
    return Tests.reduce(0.0) { $0 + $1.Duration }
  }
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
  let PerformanceMetrics: [PerformanceMetric]?

  var Passed: Int {
    if let tests = Subtests {
      return tests.filter { $0.TestStatus == "Success" }.count
    } else {
      return 0;
    }
  }

  var testSummary: TestSummary {
    if let tests = Subtests {
      return tests.reduce(into: TestSummary()) { $0 += $1.testSummary }
    }

    if let status = TestStatus {
      if status == "Success" {
        return TestSummary(success: 1, failed: 0)
      } else {
        return TestSummary(success: 0, failed: 1)
      }
    }

    return TestSummary()
  }
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

public struct PerformanceMetric: Codable {
  let Identifier: String
  let MaxPercentRegression: Int
  let MaxPercentRelativeStandardDeviation: Int
  let MaxRegression: Double
  let MaxStandardDeviation: Double
  let Measurements: [Double]
  let Name: String
  let UnitOfMeasurement: String
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
