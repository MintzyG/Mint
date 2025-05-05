// basic_variables.mint - Variable declaration and usage examples
// @since Mint 0.1.5

demo() {
  // Type inferred variables (immutable by default)
  name := "Alice"
  age := 30
  
  // Typed variable declarations
  string country = "USA"
  float temperature = 22.5
  
  // Constants (compile-time evaluated)
  const PI = 3.14159
  const DEFAULT_TIMEOUT = 30_000  // Using underscores for readability
  
  // Mutable variables
  mut counter := 0
  mut message := "Hello"
  
  // Working with mutable variables
  counter += 1
  message += ", World!"
  
  // Using numeric literals with underscores for readability
  bigNumber := 1_000_000_000
  hexValue := 0xFF_AA_BB  // Grouped for readability
  
  // Printing variables
  print("Name: " + name)
  print("Age: " + age.toString())
  print("Country: " + country)
  print("Temperature: " + temperature.toString() + "°C")
  print("Counter: " + counter.toString())
  print("Message: " + message)
  print("Big number: " + bigNumber.toString())
  print("Hex value: " + hexValue.toString(16)) // Base 16 for hex
}

main() {
  demo()
} 