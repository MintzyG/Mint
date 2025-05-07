// auth/auth.mint - Main auth package module
// @since Mint 0.5.0

// This file implicitly belongs to the "auth" module
// since it doesn't have an explicit module declaration

// Import private crypto module from within the same package
use _crypto { hashPassword, verifyPassword }
use _storage { findUser, saveUser }

// Define a User type
type User {
  int id
  string username
  string passwordHash
  bool isActive
  int loginAttempts
}

// Public function for user registration
registerUser(string username, string password) -> <User; string> {
  // Check if username already exists
  <User; string> userResult = findUser(username)
  
  if userResult.isError {
    if userResult.error != "User not found" {
      return <error: userResult.error>
    }
  } else {
    return <error: "Username already taken">
  }
  
  // Hash the password
  string hash = hashPassword(password)
  
  // Create a new user
  User user = {
    id: generateUserId(),
    username: username,
    passwordHash: hash,
    isActive: true,
    loginAttempts: 0
  }
  
  // Save the user
  <void; string> saveResult = saveUser(user)
  if saveResult.isError {
    return <error: "Failed to create user: " + saveResult.error>
  }
  
  return <value: user>
}

// Public function for user login
login(string username, string password) -> <string; string> {
  // Find the user
  <User; string> userResult = findUser(username)
  
  if userResult.isError {
    return <error: "Invalid username or password">
  }
  
  User user = userResult.value
  
  // Verify the password
  if !verifyPassword(password, user.passwordHash) {
    return <error: "Invalid username or password">
  }
  
  // Generate token (would call another private module function)
  string token = generateAuthToken(user)
  
  return <value: token>
}

// Private function to generate a user ID
_generateUserId() -> int {
  // Implementation would generate a unique ID
  return System.currentTimeMillis().toInt()
}

// Private function to generate an auth token
_generateAuthToken(User user) -> string {
  // Implementation would generate a secure token
  return "token_" + user.id.toString() + "_" + System.currentTimeMillis().toString()
} 