public struct ReportSummary: Codable {
  var testSummary: TestSummary = TestSummary(success: 0, failed: 0)
  var testableSummary: [String: TestSummary] = [:]

  public init(report: Report){
    report.TestableSummaries.forEach { s in
      let r = testSummary(testableSummary: s)
      testableSummary[s.TestName] = r

      testSummary += r
    }
  }

  func testSummary(testableSummary: TestableSummary) -> TestSummary {
    return testSummary(tests: testableSummary.Tests)
  }

  func testSummary(tests: [Test]) -> TestSummary {
    var success = 0
    var failed = 0

    tests.forEach { test in
      let r = testSummary(test: test)
      success += r.success
      failed += r.failed
    }

    return TestSummary(success: success, failed: failed)
  }

  func testSummary(test: Test) -> TestSummary {
    if let status = test.TestStatus {
      if status == "Success" {
        return TestSummary(success: 1, failed: 0)
      } else {
        return TestSummary(success: 0, failed: 1)
      }
    }

    if let subtests = test.Subtests {
      return testSummary(tests: subtests)
    }

    return TestSummary(success: 0, failed: 0)
  }
} 

public struct TestSummary: Codable {
  let success: Int
  let failed: Int
}

func + (l: TestSummary, r: TestSummary) -> TestSummary {
  return TestSummary(success: l.success + r.success,
                     failed: l.failed + r.failed)
}

func += (l: inout TestSummary, r: TestSummary) {
  l = l + r
}

