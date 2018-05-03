public struct ReportSummary: Codable {
  var testSummary: TestSummary = TestSummary(tests: 0, success: 0, failed: 0)
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

    return TestSummary(tests: success + failed, success: success, failed: failed)
  }

  func testSummary(test: Test) -> TestSummary {
    if let status = test.TestStatus {
      if status == "Success" {
        return TestSummary(tests: 1, success: 1, failed: 0)
      } else {
        return TestSummary(tests: 1, success: 0, failed: 1)
      }
    }

    if let subtests = test.Subtests {
      return testSummary(tests: subtests)
    }

    return TestSummary(tests: 0, success: 0, failed: 0)
  }
} 

public struct TestSummary: Codable {
  var tests: Int = 0
  var success: Int = 0
  var failed: Int = 0

  init(tests: Int, success: Int, failed: Int) {
    self.tests = tests
    self.success = success
    self.failed = failed
  }

  init(success: Int, failed: Int) {
    self.tests = success + failed
    self.success = success
    self.failed = failed
  }

  init() {
  }

  var isSuccess: Bool {
    return failed == 0
  }
}

func + (l: TestSummary, r: TestSummary) -> TestSummary {
  return TestSummary(tests: l.tests + r.tests,
                     success: l.success + r.success,
                     failed: l.failed + r.failed)
}

func += (l: inout TestSummary, r: TestSummary) {
  l = l + r
}

