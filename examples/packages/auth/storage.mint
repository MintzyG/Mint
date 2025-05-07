// auth/storage.mint - Private storage module for auth package
// @since Mint 0.5.0

// Explicitly declare this file as part of a private module
module _storage

// This module handles user storage operations and is private to the auth package
// External packages importing "auth" won't be able to access these functions

// Import the User type from the main module
use . { User }

// In-memory storage for demonstration
mut users = []

// Find a user by username
findUser(string username) -> <User; string> {
  for user in users {
    if user.username == username {
      return <value: user>
    }
  }
  
  return <error: "User not found">
}

// Find a user by ID
findUserById(int id) -> <User; string> {
  for user in users {
    if user.id == id {
      return <value: user>
    }
  }
  
  return <error: "User not found">
}

// Save a user (create or update)
saveUser(User user) -> <void; string> {
  try {
    // Check if user already exists
    bool userExists = false
    for i in 0..users.length() {
      if users[i].id == user.id {
        // Update existing user
        users[i] = user
        userExists = true
        break
      }
    }
    
    if !userExists {
      // Add new user
      users.push(user)
    }
    
    return <value: void>
  } catch e {
    return <error: "Failed to save user: " + e.toString()>
  }
}

// Delete a user
deleteUser(int id) -> <void; string> {
  try {
    mut newUsers = []
    mut found = false
    
    for user in users {
      if user.id != id {
        newUsers.push(user)
      } else {
        found = true
      }
    }
    
    if !found {
      return <error: "User not found">
    }
    
    users = newUsers
    return <value: void>
  } catch e {
    return <error: "Failed to delete user: " + e.toString()>
  }
} 