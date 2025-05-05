// enums.mint - Examples of C-like enums in Mint
// @since Mint 0.2.2

// Basic enum definition with implicit values (0, 1, 2, ...)
enum Day {
  Monday      // 0
  Tuesday     // 1
  Wednesday   // 2
  Thursday    // 3
  Friday      // 4
  Saturday    // 5
  Sunday      // 6
}

// Enum with explicit values
enum HttpStatus {
  OK = 200
  Created = 201
  BadRequest = 400
  NotFound = 404
  ServerError = 500
}

// Flags enum using powers of 2 for bitwise operations
enum Permission {
  None = 0
  Read = 1       // 2^0
  Write = 2      // 2^1
  Execute = 4    // 2^2
  Delete = 8     // 2^3
  All = 15       // Read | Write | Execute | Delete
}

// Enum with non-sequential values
enum ErrorCode {
  NoError = 0
  OutOfMemory = 101
  DivisionByZero = 202
  FileNotFound = 303
  InvalidInput = 404
}

// Functions using enums
isWeekend(Day day) -> bool {
  return day == Day.Saturday || day == Day.Sunday
}

isSuccessStatus(HttpStatus status) -> bool {
  // Enums can be compared with their integer values
  return status >= 200 && status < 300
}

formatErrorMessage(ErrorCode code) -> string {
  // Using enums in switch/match statements
  return match code {
    ErrorCode.NoError -> "No error occurred"
    ErrorCode.OutOfMemory -> "Error: System is out of memory"
    ErrorCode.DivisionByZero -> "Error: Cannot divide by zero"
    ErrorCode.FileNotFound -> "Error: The specified file was not found"
    ErrorCode.InvalidInput -> "Error: Invalid input provided"
    _ -> "Unknown error code: " + code.value().toString()
  }
}

// Working with permission flags using bitwise operations
hasPermission(Permission userPermissions, Permission requiredPermission) -> bool {
  return (userPermissions & requiredPermission) == requiredPermission
}

addPermission(Permission currentPermissions, Permission newPermission) -> Permission {
  // Cast the result back to Permission enum
  return Permission(currentPermissions | newPermission)
}

removePermission(Permission currentPermissions, Permission permissionToRemove) -> Permission {
  return Permission(currentPermissions & ~permissionToRemove)
}

// Main function with examples
main() {
  // Basic enum usage
  Day today = Day.Wednesday
  print("Today is day #" + today.value().toString())
  print("Is weekend? " + isWeekend(today).toString())
  
  // Converting integer to enum
  int dayNumber = 5 // Saturday
  Day convertedDay = Day(dayNumber)
  print("Converted day is " + (isWeekend(convertedDay) ? "weekend" : "weekday"))
  
  // HTTP status codes
  HttpStatus response = HttpStatus.OK
  print("HTTP " + response.toString() + " is " + 
        (isSuccessStatus(response) ? "success" : "failure"))
  
  // Error codes and formatting
  ErrorCode error = ErrorCode.FileNotFound
  print(formatErrorMessage(error))
  
  // Permission flags
  Permission userPerms = Permission.Read | Permission.Write
  print("Initial permissions: " + userPerms.toString())
  
  print("Has read permission: " + hasPermission(userPerms, Permission.Read).toString())
  print("Has execute permission: " + hasPermission(userPerms, Permission.Execute).toString())
  
  // Adding a permission
  userPerms = addPermission(userPerms, Permission.Execute)
  print("After adding execute: " + userPerms.toString())
  print("Has execute now: " + hasPermission(userPerms, Permission.Execute).toString())
  
  // Removing a permission
  userPerms = removePermission(userPerms, Permission.Write)
  print("After removing write: " + userPerms.toString())
  print("Has write now: " + hasPermission(userPerms, Permission.Write).toString())
  
  // Checking for combined permissions
  print("Has read AND execute: " + 
        hasPermission(userPerms, Permission.Read | Permission.Execute).toString())
} 