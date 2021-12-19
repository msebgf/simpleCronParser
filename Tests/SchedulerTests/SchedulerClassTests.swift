//
//  SchedulerClassTests.swift
//  
//
//  Created by Sebastian Guerrero on 19/12/2021.
//

import XCTest
@testable import Scheduler

class SchedulerClassTests: XCTestCase {
  
  var sut: Scheduler!
  
  
  func test_spanMinutesStarReturnsSameValue() throws {
    // given
    sut = Scheduler(spanMinutes: "*", hour: "*", simulatedTimeString: "16:20")
    
    // when
    let nextExecutionTime = try sut.getNextExecutionTime()
    
    // then
    XCTAssertEqual(nextExecutionTime.minutes, 20)
    
  }
  
  func test_spanMinutesReturnNextValidTime25() throws {
    // given
    sut = Scheduler(spanMinutes: "25", hour: "*", simulatedTimeString: "16:20")
    
    // when
    let nextExecutionTime = try sut.getNextExecutionTime()
    
    // then
    XCTAssertEqual(nextExecutionTime.minutes, 25)
    
  }
  
  func test_spanMinutesReturnNextValidTime17() throws {
    // given
    sut = Scheduler(spanMinutes: "17", hour: "*", simulatedTimeString: "16:20")
    
    // when
    let nextExecutionTime = try sut.getNextExecutionTime()
    
    // then
    XCTAssertEqual(nextExecutionTime.minutes, 17)
  }
  
  func test_hourStarReturnsSameValue() throws {
    // given
    sut = Scheduler(spanMinutes: "*", hour: "*", simulatedTimeString: "16:20")
    
    // when
    let nextExecutionTime = try sut.getNextExecutionTime()
    
    // then
    XCTAssertEqual(nextExecutionTime.hour, 16)
    
  }
  
  func test_hourReturnNextValidTime10() throws {
    // given
    sut = Scheduler(spanMinutes: "*", hour: "10", simulatedTimeString: "16:20")
    
    // when
    let nextExecutionTime = try sut.getNextExecutionTime()
    
    // then
    XCTAssertEqual(nextExecutionTime.hour, 10)
    
  }
  
  func test_hourReturnNextValidTime17() throws {
    // given
    sut = Scheduler(spanMinutes: "*", hour: "17", simulatedTimeString: "16:20")
    
    // when
    let nextExecutionTime = try sut.getNextExecutionTime()
    
    // then
    XCTAssertEqual(nextExecutionTime.hour, 17)
  }
  
  func test_mustJumpToNextHour() throws {
    // given
    sut = Scheduler(spanMinutes: "45", hour: "*", simulatedTimeString: "16:46")
    
    // when
    let nextExecutionTime = try sut.getNextExecutionTime()
    
    // then
    XCTAssertEqual(nextExecutionTime.hour, 17)
    XCTAssertEqual(nextExecutionTime.minutes, 45)
    XCTAssertEqual(nextExecutionTime.day, "today")
  }
  
  func test_mustJumpToNextDay() throws {
    // given
    sut = Scheduler(spanMinutes: "45", hour: "*", simulatedTimeString: "23:46")
    
    // when
    let nextExecutionTime = try sut.getNextExecutionTime()
    
    // then
    XCTAssertEqual(nextExecutionTime.hour, 0)
    XCTAssertEqual(nextExecutionTime.minutes, 45)
    XCTAssertEqual(nextExecutionTime.day, "tomorrow")
  }
  
  func test_mustJumpToNextDay1745() throws {
    // given
    sut = Scheduler(spanMinutes: "45", hour: "17", simulatedTimeString: "18:46")
    
    // when
    let nextExecutionTime = try sut.getNextExecutionTime()
    
    // then
    XCTAssertEqual(nextExecutionTime.hour, 17)
    XCTAssertEqual(nextExecutionTime.minutes, 45)
    XCTAssertEqual(nextExecutionTime.day, "tomorrow")
  }
  
  func test_mustJumpToNextDay1845() throws {
    // given
    sut = Scheduler(spanMinutes: "45", hour: "18", simulatedTimeString: "18:46")
    
    // when
    let nextExecutionTime = try sut.getNextExecutionTime()
    
    // then
    XCTAssertEqual(nextExecutionTime.hour, 18)
    XCTAssertEqual(nextExecutionTime.minutes, 45)
    XCTAssertEqual(nextExecutionTime.day, "tomorrow")
  }
  
  func test_mustJumpToNextDay145() throws {
    // given
    sut = Scheduler(spanMinutes: "50", hour: "1", simulatedTimeString: "18:46")
    
    // when
    let nextExecutionTime = try sut.getNextExecutionTime()
    
    // then
    XCTAssertEqual(nextExecutionTime.hour, 1)
    XCTAssertEqual(nextExecutionTime.minutes, 50)
    XCTAssertEqual(nextExecutionTime.day, "tomorrow")
  }
  
  func test_sameDay() throws {
    // given
    sut = Scheduler(spanMinutes: "15", hour: "13", simulatedTimeString: "9:50")
    
    // when
    let nextExecutionTime = try sut.getNextExecutionTime()
    
    // then
    XCTAssertEqual(nextExecutionTime.hour, 13)
    XCTAssertEqual(nextExecutionTime.minutes, 15)
    XCTAssertEqual(nextExecutionTime.day, "today")
  }
  
  func test_minutesThrow() {
    // given
    sut = Scheduler(spanMinutes: "60", hour: "*", simulatedTimeString: "9:50")
    
    // then
    XCTAssertThrowsError(try sut.getNextExecutionTime(), "invalid argument") { error in
      XCTAssertEqual(error as! SchedulerError, .invalidArgument)
    }
  }
  
  func test_hoursThrow() {
    // given
    sut = Scheduler(spanMinutes: "*", hour: "25", simulatedTimeString: "9:50")
    
    // then
    XCTAssertThrowsError(try sut.getNextExecutionTime(), "invalid argument") { error in
      XCTAssertEqual(error as! SchedulerError, .invalidArgument)
    }
  }
  
  func test_simulatedTimeThrow() {
    // given
    sut = Scheduler(spanMinutes: "*", hour: "*", simulatedTimeString: "29:50")
    
    // then
    XCTAssertThrowsError(try sut.simulatedTime, "invalid argument") { error in
      XCTAssertEqual(error as! SchedulerError, .invalidArgument)
    }
  }
}
