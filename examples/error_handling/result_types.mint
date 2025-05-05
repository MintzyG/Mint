// result_types.mint - Error handling with Result types and propagation
// @since Mint 0.2.3

// Function that can fail and return an error
readUserData(string userId) -> <User;error> {
  // Simulate user lookup
  if userId == "" {
    return error("User ID cannot be empty")
  }
  
  if userId == "invalid" {
    return error("User not found")
  }
  
  // Successful case
  return User{
    name: "Example User",
    email: "user@example.com",
    age: 25,
    verified: true
  }
}

// Function that returns detailed error types
parseJson(string data) -> <Map<string, any>;JsonError> {
  if data == "" {
    return JsonError.Empty("Input string is empty")
  }
  
  if !data.startsWith("{") {
    return JsonError.InvalidFormat("JSON must start with '{'")
  }
  
  // Simulate successful parsing
  result := Map<string, any>{}
  result["success"] = true
  result["count"] = 42
  return result
}

// Define custom error type
enum JsonError {
  Empty(string message)
  InvalidFormat(string message)
  ParseFailed(string message, int position)
}

// Function that demonstrates the error propagation operator
processUser(string userId) -> <string;error> {
  // The ? operator will propagate errors automatically
  user := readUserData(userId)?
  
  // This code only runs if readUserData succeeds
  return "Processed user: " + user.name
}

// Function that combines multiple operations that can fail
validateAndProcessUser(string userId, string userData) -> <string;error> {
  // Both of these can fail, but ? will propagate the error
  user := readUserData(userId)?
  parsedData := parseJson(userData)?
  
  // This code only runs if both operations succeed
  return "User " + user.name + " processed with data count: " + parsedData["count"].toString()
}

// Example pipeline with error handling
processUserPipeline(string userId) -> <string;error> {
  return userId
    |> readUserData?         // Error propagation in a pipeline
    |> processUserProfile?   // Another function that could fail
    |> generateUserReport    // Final transformation
}

processUserProfile(User user) -> <ProfileData;error> {
  // Example function - normally would do actual processing
  if !user.verified {
    return error("Cannot process unverified user")
  }
  
  return ProfileData{userId: user.email, status: "Active"}
}

struct ProfileData {
  string userId
  string status
}

generateUserReport(ProfileData data) -> string {
  return "REPORT: User " + data.userId + " is " + data.status
}

main() {
  // Successful case
  result := processUser("valid-id")
  if result.isOk() {
    print(result.unwrap())
  } else {
    print("Error: " + result.error().message)
  }
  
  // Error case
  errorResult := processUser("invalid")
  match errorResult {
    Ok(value) -> print("Success: " + value)
    Err(error) -> print("Failed: " + error.message)
  }
} 