//
//  TestHelper.swift
//  TestApp0UITests
//
//  Created by 堀泰祐 on 2018/04/29.
//  Copyright © 2018 taisukeh. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
  func capture(_ name: String, lifeTime: XCTAttachment.Lifetime = .deleteOnSuccess) {
    let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
    attachment.lifetime = lifeTime
    attachment.name = name
    add(attachment)
  }
}

