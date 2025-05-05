// multi_value_results.mint - Examples of returning multiple values with error handling
// @since Mint 0.3.1

// Parse x,y coordinates from a string like "10,20"
parseCoordinates(string input) -> <int,int;error> {
  // Split the input by comma
  []string parts = input.split(",")
  
  // Validate input format
  if parts.length() != 2 {
    return error("Invalid format: expected 'x,y'")
  }
  
  // Try to parse both parts as integers
  int x, error err1 = parseInt(parts[0])
  if err1 {
    return error("Invalid x coordinate: " + err1.message)
  }
  
  int y, error err2 = parseInt(parts[1])
  if err2 {
    return error("Invalid y coordinate: " + err2.message)
  }
  
  // Return both coordinates on success
  return x, y
}

// Function that uses the coordinate parser with ? operator
drawPoint(string coordString) -> <string;error> {
  // Use ? to unwrap or propagate error
  int x, int y = parseCoordinates(coordString)?
  
  // This code only runs if there was no error
  return "Drawing point at (" + x.toString() + ", " + y.toString() + ")"
}

// Function returning three values
getUserData(int userId) -> <string,int,bool;error> {
  // Validate input
  if userId <= 0 {
    return error("Invalid user ID")
  }
  
  if userId == 404 {
    return error("User not found")
  }
  
  // Success case, return multiple values directly
  string name = "User " + userId.toString()
  int age = 20 + (userId % 20)
  bool isActive = userId % 2 == 0
  
  return name, age, isActive
}

// Accessing the values directly with value1, value2, etc.
processUserProfile(int userId) -> <string;error> {
  // Get the user data
  <string,int,bool;error> result = getUserData(userId)
  
  // Check for error
  if result is err {
    return error("Failed to process user: " + result.error.message)
  }
  
  // Access values with .value1, .value2, .value3
  string name = result.value1
  int age = result.value2
  bool isActive = result.value3
  
  // Process the data
  return "Profile: " + name + " (age: " + age.toString() + ", " + 
         "active: " + isActive.toString() + ")"
}

// Using pattern matching with multi-value results
createUserReport(int userId) -> <string;error> {
  // Get the user data
  <string,int,bool;error> userData = getUserData(userId)
  
  // Use pattern matching to handle the result
  return match userData {
    ok name, age, active -> 
      "REPORT: " + name + " is " + age.toString() + " years old and " +
      (active ? "currently active" : "currently inactive")
    
    err msg -> 
      error("Failed to create report: " + msg)
  }
}

// Using ? operator with multi-value results
getUserStats(int userId) -> <string;error> {
  // The ? operator unwraps all values or returns the error
  string name, int age, bool isActive = getUserData(userId)?
  
  // Calculate some stats
  string ageGroup = age < 18 ? "minor" : (age < 65 ? "adult" : "senior")
  string status = isActive ? "active" : "inactive"
  
  return "Stats for " + name + ": " + ageGroup + ", " + status
}

// Main function showing all approaches
main() {
  // Test coordinate parsing
  print("\n=== Multiple Value Results ===")
  <string;error> drawResult = drawPoint("100,200")
  if drawResult is ok {
    print(drawResult.value)
  } else {
    print("Error: " + drawResult.error.message)
  }
  
  // Test with invalid input
  drawResult = drawPoint("invalid")
  if drawResult is ok {
    print(drawResult.value)
  } else {
    print("Error: " + drawResult.error.message)
  }
  
  // Test accessing values directly
  print("\n=== Accessing Multiple Values ===")
  <string;error> profileResult = processUserProfile(123)
  if profileResult is ok {
    print(profileResult.value)
  } else {
    print("Error: " + profileResult.error.message)
  }
  
  // Test pattern matching
  print("\n=== Pattern Matching with Multiple Values ===")
  <string;error> reportResult = createUserReport(42)
  if reportResult is ok {
    print(reportResult.value)
  } else {
    print("Error: " + reportResult.error.message)
  }
  
  // Test ? operator
  print("\n=== Using ? Operator with Multiple Values ===")
  <string;error> statsResult = getUserStats(99)
  if statsResult is ok {
    print(statsResult.value)
  } else {
    print("Error: " + statsResult.error.message)
  }
  
  // Test with error case
  statsResult = getUserStats(404) // This ID should return an error
  if statsResult is ok {
    print(statsResult.value)
  } else {
    print("Error: " + statsResult.error.message)
  }
} 