import Darwin
import OSLog

if CommandLine.arguments.count < 2 || CommandLine.arguments.count > 3 {
  let thisApp = CommandLine.arguments[0]
  print("Usage: my_app | \(thisApp) <subsystem.name> [<category>]")
  print("By default, <category> will be \"default\".")
  exit(1)
}

let subsystem: String = CommandLine.arguments[1]
let category: String =
    CommandLine.arguments.count >= 3 ? CommandLine.arguments[2] : "default"
print("Logging stdin to [\(subsystem):\(category)]...")

let logger = Logger(subsystem: subsystem, category: category)

while let line = readLine() {
  // Without setting privacy: public, the log is entirely hidden.
  logger.info("\(line, privacy: .public)")
  // Echo to stdout, as well.
  print(line)
}
