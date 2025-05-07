// main.mint - Example of importing and using packages
// @since Mint 0.4.0

// Using the new consolidated import syntax
import (
  math // Import the entire math package
  utils { format, timestamp } // Selective import from utils
  logger as log // Import with alias
)

main() {
  // Using functions from the math package
  int sum = math.add(5, 3)
  int product = math.multiply(4, 7)
  
  print("5 + 3 = " + sum.toString())
  print("4 * 7 = " + product.toString())
  
  // Using a function from a subpackage
  float area = math.geometry.calculateCircleArea(5.0)
  print("Area of circle with radius 5: " + area.toString())
  
  // Using direct imports 
  string message = format("Result calculated at {0}", timestamp())
  print(message)
  
  // Using the aliased logger package
  log.info("All calculations completed successfully")
  
  // Running more complex operations with the package
  runMathDemo()
}

// A function that demonstrates more complex package usage
runMathDemo() {
  numbers := [1, 5, 10, 15, 20]
  
  // Using various functions from the math package
  print("\n=== Math Package Demo ===")
  print("Sum: " + math.sum(numbers).toString())
  print("Average: " + math.average(numbers).toString())
  print("Max: " + math.max(numbers).toString())
  
  // Using the geometry subpackage
  print("\n=== Geometry Subpackage Demo ===")
  print("Square area (5): " + math.geometry.calculateSquareArea(5.0).toString())
  print("Triangle area (4, 6): " + math.geometry.calculateTriangleArea(4.0, 6.0).toString())
  
  // Using the stats subpackage
  print("\n=== Statistics Subpackage Demo ===")
  print("Median: " + math.stats.median(numbers).toString())
  print("Mode: " + math.stats.mode(numbers).toString())
  
  // Logging with different levels
  log.debug("Demo calculations performed")
  log.warn("Some results might be rounded")
} 