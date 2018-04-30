//
//  TestApp0Tests.swift
//  TestApp0Tests
//
//  Created by 堀泰祐 on 2018/04/24.
//  Copyright © 2018 taisukeh. All rights reserved.
//

import XCTest
@testable import TestApp0

class TestApp0Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
  func testExampleSkip() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testExample2() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertEqual("foo", "bar", "it should be error")
  }
  
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
      }
    }
    
  func testPerformanceExample2() {
    // This is an example of a performance test case.
    self.measure {
      Thread.sleep(forTimeInterval: 3.0)
    }
  }
  
}
