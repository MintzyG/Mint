// modules_demo.mint - Demonstration of module system usage
// @since Mint 0.5.0

// Import the auth package and its specialized oauth module
import (
  auth
  auth.oauth
  logger as log
)

main() {
  // Using the public auth module functions
  print("== Auth Package Demo ==")
  
  // Try registering a user
  print("\nRegistering user 'alice'...")
  <auth.User; string> registerResult = auth.registerUser("alice", "securePassword123")
  
  if registerResult.isError {
    log.error("Registration failed: " + registerResult.error)
  } else {
    auth.User user = registerResult.value
    log.info("User registered: " + user.username)
    
    // Try logging in
    print("\nLogging in as 'alice'...")
    <string; string> loginResult = auth.login("alice", "securePassword123")
    
    if loginResult.isError {
      log.error("Login failed: " + loginResult.error)
    } else {
      string token = loginResult.value
      log.info("Login successful, token: " + token)
    }
  }
  
  // Using the specialized OAuth module
  print("\n== OAuth Module Demo ==")
  
  // Initialize OAuth providers
  oauth.init(
    "google_client_id",
    "google_client_secret",
    "github_client_id",
    "github_client_secret"
  )
  
  // Get authorization URL for Google OAuth
  string redirectUri = "https://myapp.com/oauth/callback"
  string state = "random_state_value"
  string authUrl = oauth.getAuthorizationUrl(oauth.GOOGLE, redirectUri, state)
  
  print("Google OAuth URL: " + authUrl)
  
  // Simulate an OAuth code exchange
  print("\nExchanging authorization code...")
  <string; string> tokenResult = oauth.exchangeCodeForToken(oauth.GOOGLE, "mock_auth_code", redirectUri)
  
  if tokenResult.isError {
    log.error("Token exchange failed: " + tokenResult.error)
  } else {
    string accessToken = tokenResult.value
    log.info("Received access token: " + accessToken)
    
    // Get user profile
    print("\nFetching user profile...")
    <oauth.OAuthUserProfile; string> profileResult = oauth.getUserProfile(oauth.GOOGLE, accessToken)
    
    if profileResult.isError {
      log.error("Failed to get profile: " + profileResult.error)
    } else {
      oauth.OAuthUserProfile profile = profileResult.value
      log.info("Got profile for: " + profile.name + " (" + profile.email + ")")
    }
  }
  
  // The following would be compile errors, as these modules are private
  /*
  // _crypto is a private module, not accessible from outside auth package
  string hash = auth._crypto.hashPassword("test");  // Error!
  
  // _storage is a private module, not accessible from outside auth package
  auth._storage.findUser("alice");  // Error!
  */
  
  printModuleSystemDemo()
}

// This function explains how the module system works
printModuleSystemDemo() {
  print("\n== Module System Explanation ==")
  print("""
  1. The auth package contains 4 modules:
     - auth (implicit default module)
     - auth.oauth (specialized public module)
     - _crypto (private module)
     - _storage (private module)
     
  2. When importing the auth package, only the public modules are 
     accessible from outside the package:
     - The default 'auth' module is automatically imported
     - The 'auth.oauth' specialized module must be explicitly imported
     
  3. Private modules (_crypto, _storage) are only accessible 
     within the auth package.
     
  4. Within the auth package, modules can access each other using 
     the 'use' directive, like:
     use _crypto { hashPassword }
     
  5. This allows for better organization and encapsulation
     of implementation details.
  """)
} 