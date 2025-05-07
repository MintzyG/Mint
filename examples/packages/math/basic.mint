// math/basic.mint - Basic mathematical operations
// @since Mint 0.4.0

// Add two numbers
add(int a, int b) -> int {
  return a + b
}

// Subtract second number from first
subtract(int a, int b) -> int {
  return a - b
}

// Multiply two numbers
multiply(int a, int b) -> int {
  return a * b
}

// Divide first number by second with error handling
divide(int a, int b) -> <float;error> {
  if b == 0 {
    return error("Division by zero")
  }
  return a / b
}

// Sum of all elements in an array
sum([]int numbers) -> int {
  mut total := 0
  for n in numbers {
    total += n
  }
  return total
}

// Average of all elements in an array
average([]int numbers) -> float {
  if numbers.isEmpty() {
    return 0.0
  }
  return sum(numbers) / numbers.length()
}

// Maximum value in an array
max([]int numbers) -> int {
  if numbers.isEmpty() {
    return 0
  }
  
  mut maxValue := numbers[0]
  for n in numbers {
    if n > maxValue {
      maxValue = n
    }
  }
  return maxValue
}

// Minimum value in an array
min([]int numbers) -> int {
  if numbers.isEmpty() {
    return 0
  }
  
  mut minValue := numbers[0]
  for n in numbers {
    if n < minValue {
      minValue = n
    }
  }
  return minValue
}

// Private validation function - only visible within the math package
_isValidNumber(int n) -> bool {
  // Example validation logic
  return n != int.MIN_VALUE
} 