// pattern_matching.mint - Pattern matching examples
// @since Mint 0.2.5

// Define a C-like enum for basic pattern matching
enum Color {
  Red = 0
  Green = 1
  Blue = 2
  Yellow = 3
}

// Using the enum with pattern matching
getColorName(Color color) -> string {
  return match color {
    Color.Red -> "Red"
    Color.Green -> "Green" 
    Color.Blue -> "Blue"
    Color.Yellow -> "Yellow"
    _ -> "Unknown color"
  }
}

// Pattern matching with result types
readConfig(string filename) -> <Map<string, string>;error> {
  if filename.endsWith(".cfg") == false {
    return error("Invalid file extension")
  }
  
  // Simulating successful file read
  if filename == "app.cfg" {
    map := {
      "port": "8080",
      "host": "localhost",
      "debug": "true"
    }
    return map
  }
  
  return error("File not found")
}

// Pattern matching with guards
describeNumber(int n) -> string {
  return match n {
    0 -> "Zero"
    n if n < 0 -> "Negative number"
    n if n % 2 == 0 -> "Positive even number"
    n if n % 2 == 1 -> "Positive odd number"
    _ -> "Unreachable" // This case is actually unreachable but required for exhaustiveness
  }
}

// Pattern matching with tuples
describePair((int, int) pair) -> string {
  return match pair {
    (0, 0) -> "Origin"
    (0, y) -> "On Y-axis at " + y.toString()
    (x, 0) -> "On X-axis at " + x.toString()
    (x, y) if x == y -> "On the diagonal where X equals Y"
    (x, y) if x == -y -> "On the diagonal where X equals -Y"
    (x, y) -> "Point at " + x.toString() + ", " + y.toString()
  }
}

// Pattern matching with destructuring of complex data
processUser(Map<string, any> user) -> string {
  return match user {
    { "name": string name, "age": int age } if age < 18 -> 
      name + " is a minor"
      
    { "name": string name, "age": int age, "verified": true } -> 
      name + " is verified and " + age.toString() + " years old"
      
    { "name": string name, "premium": true } -> 
      name + " is a premium user"
      
    { "name": string name } -> 
      name + " is a basic user"
      
    _ -> "Invalid user data"
  }
}

// Pattern matching with multiple return values
getUserData(int userId) -> <string,int,bool;error> {
  if userId <= 0 {
    return error("Invalid user ID")
  }
  
  if userId == 404 {
    return error("User not found")
  }
  
  string name = "User " + userId.toString()
  int age = 20 + (userId % 20)
  bool isActive = userId % 2 == 0
  
  return name, age, isActive
}

main() {
  // Basic enum pattern matching
  colors := [Color.Red, Color.Green, Color.Blue, Color.Yellow]
  
  for color in colors {
    colorName := getColorName(color)
    colorValue := color.value()  // Get integer value of enum
    print("Color " + colorName + " has value: " + colorValue.toString())
  }
  
  // Pattern matching with result types
  print("\n=== Pattern Matching with Result Types ===")
  result := readConfig("app.cfg")
  
  // Pattern matching with single value results
  configInfo := match result {
    ok config -> "Config loaded with " + config.size().toString() + " settings"
    err msg -> "Failed to load config: " + msg
  }
  print(configInfo)
  
  // Pattern matching with multiple value results
  userData := getUserData(42)
  userInfo := match userData {
    ok name, age, active -> 
      "User: " + name + ", Age: " + age.toString() + ", Active: " + active.toString()
    err msg -> 
      "Error: " + msg
  }
  print(userInfo)
  
  // Pattern matching with guards
  print("\n=== Pattern Matching with Guards ===")
  numbers := [-5, 0, 2, 7]
  for n in numbers {
    print(n.toString() + " is " + describeNumber(n))
  }
  
  // Pattern matching with tuples
  print("\n=== Pattern Matching with Tuples ===")
  points := [(0, 0), (5, 0), (0, -3), (2, 2), (3, -3), (4, 7)]
  for point in points {
    print("Point " + point.toString() + ": " + describePair(point))
  }
  
  // Pattern matching with destructuring
  print("\n=== Pattern Matching with Destructuring ===")
  users := [
    {"name": "Alice", "age": 15},
    {"name": "Bob", "age": 25, "verified": true},
    {"name": "Charlie", "premium": true},
    {"name": "Dave"}
  ]
  
  for user in users {
    print(processUser(user))
  }
} 