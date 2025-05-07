// logger/log.mint - Logging utilities
// @since Mint 0.4.0

// Import the utils package for timestamp function
import utils.formatting { timestamp }

// Log levels
enum LogLevel {
  DEBUG = 0
  INFO = 1
  WARN = 2
  ERROR = 3
  FATAL = 4
}

// Default log level
mut currentLogLevel = LogLevel.INFO

// Set the minimum log level (messages below this level will be ignored)
setLogLevel(LogLevel level) {
  currentLogLevel = level
}

// Get the current log level
getLogLevel() -> LogLevel {
  return currentLogLevel
}

// Log a message at DEBUG level
debug(string message) {
  log(LogLevel.DEBUG, message)
}

// Log a message at INFO level
info(string message) {
  log(LogLevel.INFO, message)
}

// Log a message at WARN level
warn(string message) {
  log(LogLevel.WARN, message)
}

// Log a message at ERROR level
error(string message) {
  log(LogLevel.ERROR, message)
}

// Log a message at FATAL level
fatal(string message) {
  log(LogLevel.FATAL, message)
}

// Main logging function
log(LogLevel level, string message) {
  // Check if this message should be logged based on current level
  if level < currentLogLevel {
    return
  }
  
  // Format the log message
  string time = timestamp()
  string levelStr = _getLevelString(level)
  string formattedMessage = "[" + time + "] [" + levelStr + "] " + message
  
  // Output the message
  if level >= LogLevel.ERROR {
    // Error messages go to stderr
    System.stderr.println(formattedMessage)
  } else {
    // Other messages go to stdout
    print(formattedMessage)
  }
}

// Initialize the logger when the package is imported
init() {
  info("Logger initialized")
}

// Private helper to convert log level to string
_getLevelString(LogLevel level) -> string {
  return match level {
    LogLevel.DEBUG -> "DEBUG"
    LogLevel.INFO -> "INFO"
    LogLevel.WARN -> "WARN"
    LogLevel.ERROR -> "ERROR"
    LogLevel.FATAL -> "FATAL"
    _ -> "UNKNOWN"
  }
} 