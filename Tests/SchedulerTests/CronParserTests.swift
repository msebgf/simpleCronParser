//
//  CronParserTests.swift
//  
//
//  Created by Sebastian Guerrero on 21/12/2021.
//

import XCTest
@testable import Scheduler

class CronParserTests: XCTestCase {
  
  func testParser() {
    // give
    let sut = CronParser(nextExecutionTime: (10, 10, "today"), task: "customTask")
    
    // when
    let parsed = sut.parse()
    
    // then
    XCTAssertEqual(parsed, "10:10 today - customTask")
  }
}
