//
//  File.swift
//  
//
//  Created by Sebastian Guerrero on 19/12/2021.
//

import Foundation

enum SchedulerError: Error {
  case invalidArgument
}

struct Scheduler {
  
  let spanMinutes: String
  let hour: String
  
  let simulatedTimeString: String
  
  var simulatedTime:Date {
    get throws {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "HH:mm"
      guard let date = dateFormatter.date(from: simulatedTimeString) else {
        throw SchedulerError.invalidArgument
      }
      return date
    }
  }
  
  func getNextExecutionTime() throws -> (hour:Int, minutes:Int, day: String) {
    let simualtedTimeComponents = try getSimulatedTimeComponents()
    let nextExecutionMinutes = try evaluateSpanMinutes(simulatedMinutes: simualtedTimeComponents.minutes)
    let shouldMoveToNextHour = nextExecutionMinutes < simualtedTimeComponents.minutes
    var nextExecutionHour = try evaluateHour(simulatedHour: simualtedTimeComponents.hour, shouldMoveToNextHour: shouldMoveToNextHour)
        
    if nextExecutionHour == 24 {
      nextExecutionHour = 0
    }
    
    let shoulMoveToNextDay = nextExecutionHour < simualtedTimeComponents.hour ||
  (shouldMoveToNextHour && nextExecutionHour == simualtedTimeComponents.hour)
        
    let day = shoulMoveToNextDay ? "tomorrow" : "today"
    
    return (nextExecutionHour, nextExecutionMinutes, day)
  }
}

private extension Scheduler {
  func getSimulatedTimeComponents() throws -> (hour: Int, minutes: Int) {
    let calendar = Calendar.current
    let simulatedMinutes = try calendar.component(.minute, from: simulatedTime)
    let simulatedHour = try calendar.component(.hour, from: simulatedTime)
     return (simulatedHour, simulatedMinutes)
  }
  
  func evaluateSpanMinutes(simulatedMinutes: Int) throws -> Int {
    if spanMinutes == "*" {
      return simulatedMinutes
    }
    guard let spanMinutesInt = Int(spanMinutes),
          spanMinutesInt >= 0, spanMinutesInt < 60 else {
      throw SchedulerError.invalidArgument
    }
    
    return spanMinutesInt
  }
  
  func evaluateHour(simulatedHour: Int, shouldMoveToNextHour: Bool) throws -> Int {
    if hour == "*" {
      return simulatedHour + (shouldMoveToNextHour ? 1 : 0)
    }
    guard let hourInt = Int(hour),
          hourInt >= 0, hourInt < 24 else {
      throw SchedulerError.invalidArgument
    }
    
    return hourInt
  }
}
