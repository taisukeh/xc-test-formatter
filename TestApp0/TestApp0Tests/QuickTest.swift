//
//  QuickTest.swift
//  TestApp0Tests
//
//  Created by 堀泰祐 on 2018/04/28.
//  Copyright © 2018 taisukeh. All rights reserved.
//

import Quick
import Nimble

class TableOfContentsSpec: QuickSpec {
  override func spec() {
    describe("the 'Documentation' directory") {
      describe("the 'Documentation' directory 2 ") {
        describe("the 'Documentation' directory 3 ") {
          it("has everything you need to get started") {
            expect("Foo Groups aaa").to(contain("Groups"))
            expect("Quick").to(contain("Quick"))
          }
          
          context("if it doesn't have what you're looking for") {
            it("needs to be updated") {
              expect("Foo Groups aaa").to(contain("Groups"))
            }
          }
        }
      }
    }
  }
}
