let inputPath = CommandLine.arguments[1]
let simulatedTime = CommandLine.arguments[2]
do {
  let contents = try String(contentsOfFile: inputPath, encoding: .utf8)
  var tasks = contents.components(separatedBy: .newlines)
  tasks.removeLast()
  
  for task in tasks {
    let taskComponents = task.components(separatedBy: .whitespaces)
    let scheduler = Scheduler(spanMinutes: taskComponents[0], hour: taskComponents[1], simulatedTimeString: simulatedTime)
    let nextExcecutionTime = try scheduler.getNextExecutionTime()
    print("\(nextExcecutionTime.hour):\(nextExcecutionTime.minutes) \(nextExcecutionTime.day) - \(taskComponents[2])")
  }
}
catch let error {
    print("Error: \(error)")
}
