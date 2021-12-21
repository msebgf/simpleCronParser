//
//  File.swift
//  
//
//  Created by Sebastian Guerrero on 21/12/2021.
//

import Foundation

struct CronParser {
  
  let nextExecutionTime:(hour: Int, minutes: Int, day: String)
  let task: String
  
  func parse() -> String {
    return "\(nextExecutionTime.hour):\(nextExecutionTime.minutes) \(nextExecutionTime.day) - \(task)"
  }
}
