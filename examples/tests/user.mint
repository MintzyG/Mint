// user.mint - User module implementation
// @since Mint 0.3.1

struct User {
  string name
  string email
  int age
  bool verified = false
}

// Validates a user and returns any validation errors
validateUser(User user) -> (bool, []string) {
  errors := []
  
  // Name validation
  if user.name.length() < 2 {
    errors.append("Name must be at least 2 characters")
  }
  
  // Email validation - simple check for @ symbol
  if !user.email.contains("@") {
    errors.append("Email must contain @ symbol")
  }
  
  // Age validation
  if user.age < 18 {
    errors.append("User must be at least 18 years old")
  }
  
  return errors.length() == 0, errors
}

// Creates a new verified user if validation passes
createVerifiedUser(string name, string email, int age) -> <User;error> {
  user := User{
    name: name,
    email: email,
    age: age
  }
  
  isValid, errors := validateUser(user)
  if !isValid {
    return error("Invalid user: " + errors.join(", "))
  }
  
  // User is valid, mark as verified
  return user{verified: true}  // Update with new verified status
} 