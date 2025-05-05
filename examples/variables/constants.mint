// constants.mint - Examples of constants in Mint
// @since Mint 0.1.4

// Module-level constants
const PI = 3.14159265359
const MAX_USERS = 1000
const APP_NAME = "Mint Demo"
const DEBUG_MODE = true

// Constants with explicit types
const float GRAVITY = 9.81
const int MAX_RETRY_COUNT = 3
const string API_VERSION = "v1.0"
const bool FEATURE_ENABLED = false

// Constants with compile-time expressions
const DAYS_IN_WEEK = 7
const HOURS_IN_WEEK = DAYS_IN_WEEK * 24
const MINUTES_IN_WEEK = HOURS_IN_WEEK * 60

// Mathematical operations in constants
const CIRCLE_RADIUS = 5
const CIRCLE_AREA = PI * CIRCLE_RADIUS * CIRCLE_RADIUS
const DOUBLE_PI = PI * 2
const HALF_PI = PI / 2

// Bitwise operations in constants
const ACCESS_READ = 1 << 0    // 1 (binary: 001)
const ACCESS_WRITE = 1 << 1   // 2 (binary: 010)
const ACCESS_EXECUTE = 1 << 2 // 4 (binary: 100)
const ACCESS_ALL = ACCESS_READ | ACCESS_WRITE | ACCESS_EXECUTE // 7 (binary: 111)

// String operations in constants
const GREETING = "Hello"
const FULL_GREETING = GREETING + ", World!"

// Demonstrate usage of constants
calculateCircumference(float radius) -> float {
  return DOUBLE_PI * radius
}

hasReadAccess(int permissions) -> bool {
  return (permissions & ACCESS_READ) != 0
}

configureDevelopmentMode() {
  if DEBUG_MODE {
    print("Running in debug mode")
    print("Maximum users: " + MAX_USERS.toString())
  } else {
    print("Running in production mode")
  }
}

// Main function to show constants in action
main() {
  print("Application: " + APP_NAME)
  print("API Version: " + API_VERSION)
  
  // Using mathematical constants
  print("Circle area with radius " + CIRCLE_RADIUS.toString() + ": " + CIRCLE_AREA.toString())
  print("Circumference of circle with radius 10: " + calculateCircumference(10).toString())
  
  // Using bitwise constants for permissions
  int userPermissions = ACCESS_READ | ACCESS_WRITE // 3 (binary: 011)
  print("User has read access: " + hasReadAccess(userPermissions).toString())
  print("User has all access: " + ((userPermissions & ACCESS_ALL) == ACCESS_ALL).toString())
  
  // Demonstrating compile-time calculations
  print("Hours in a week: " + HOURS_IN_WEEK.toString())
  print("Minutes in a week: " + MINUTES_IN_WEEK.toString())
  
  // Using constants for configuration
  configureDevelopmentMode()
  
  // Constants cannot be modified
  // Uncommenting this line would cause a compilation error:
  // PI = 3.14 // ERROR: Cannot assign to constant 'PI'
} 