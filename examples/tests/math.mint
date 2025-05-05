// math.mint - Math utility functions
// @since Mint 0.2.7

// Basic math operations with validation
module MathUtils {
  // Returns the square root of a number
  sqrt(float x) -> <float;error> {
    if x < 0 {
      return error("Cannot calculate square root of negative number")
    }
    
    // Simple implementation for demo purposes
    // In a real implementation, would use a native function or algorithm
    return x ** 0.5
  }
  
  // Safely divides two numbers, handling division by zero
  safeDivide(float numerator, float denominator) -> <float;error> {
    if denominator == 0 {
      return error("Division by zero")
    }
    
    return numerator / denominator
  }
  
  // Calculates the factors of a number
  factors(int n) -> []int {
    if n <= 0 {
      return []
    }
    
    result := []
    
    for i := 1; i <= n; i++ {
      if n % i == 0 {
        result.append(i)
      }
    }
    
    return result
  }
  
  // Checks if a number is prime
  isPrime(int n) -> bool {
    if n <= 1 {
      return false
    }
    
    if n <= 3 {
      return true
    }
    
    if n % 2 == 0 || n % 3 == 0 {
      return false
    }
    
    i := 5
    while i * i <= n {
      if n % i == 0 || n % (i + 2) == 0 {
        return false
      }
      i += 6
    }
    
    return true
  }
  
  // Performs exponentiation, handling errors for negative bases with fractional exponents
  power(float base, float exponent) -> <float;error> {
    if base < 0 && !exponent.isInteger() {
      return error("Cannot raise negative number to a fractional power")
    }
    
    return base ** exponent
  }
  
  // Calculates the greatest common divisor of two integers
  gcd(int a, int b) -> int {
    a = a.abs()
    b = b.abs()
    
    while b != 0 {
      temp := b
      b = a % b
      a = temp
    }
    
    return a
  }
} 