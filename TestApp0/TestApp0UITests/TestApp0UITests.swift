//
//  TestApp0UITests.swift
//  TestApp0UITests
//
//  Created by 堀泰祐 on 2018/04/24.
//  Copyright © 2018 taisukeh. All rights reserved.
//

import XCTest

class TestApp0UITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUIExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      let attachment0 = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
      attachment0.lifetime = .keepAlways  // 成功後もデータを保持
      attachment0.name = "image0"
      add(attachment0)

      let attachment2 = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
      attachment2.lifetime = .deleteOnSuccess
      attachment2.name = "image2"
      add(attachment2)

      let attachment1 = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
      attachment1.lifetime = .keepAlways  // 成功後もデータを保持
      add(attachment1)
      
    }

  func testUIExample2() {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    for i in 0 ..< 10 {
      capture("image\(i)", lifeTime: .keepAlways)
    }
    
    XCTFail("ふぁーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー")
  }
  

}
