// advanced_functions.mint - Function declarations and features
// @since Mint 0.2.8

// Basic function with type annotations
add(int a, int b) -> int {
  return a + b
}

// Function with multiple return values
divideWithRemainder(int dividend, int divisor) -> (int, int) {
  return dividend / divisor, dividend % divisor
}

// Function with named return values
calculateStats([]int numbers) -> (min: int, max: int, avg: float) {
  if numbers.isEmpty() {
    return 0, 0, 0.0
  }
  
  min := numbers[0]
  max := numbers[0]
  sum := 0
  
  for num in numbers {
    if num < min { min = num }
    if num > max { max = num }
    sum += num
  }
  
  avg := sum / numbers.length().toFloat()
  
  return min, max, avg
}

// Function with early return and condition
findIndex([]int array, int value) -> int {
  return -1 if array.isEmpty()
  
  for i, v in array {
    return i if v == value
  }
  
  return -1
}

// Anonymous function (closure)
createCounter() -> () -> int {
  mut count := 0
  
  return () -> int {
    count += 1
    return count
  }
}

// Higher-order function that takes a function as parameter
applyToEach([]int values, (int) -> int transformer) -> []int {
  result := []
  
  for value in values {
    result.append(transformer(value))
  }
  
  return result
}

// Method attached to a struct
struct Rectangle {
  float width
  float height
  
  area() -> float {
    return this.width * this.height
  }
  
  scale(float factor) -> Rectangle {
    return Rectangle{
      width: this.width * factor,
      height: this.height * factor
    }
  }
}

// Variadic function (takes variable number of arguments)
// @since Mint 0.3.0
sum(...int values) -> int {
  result := 0
  for value in values {
    result += value
  }
  return result
}

main() {
  // Basic function call
  print("5 + 3 = " + add(5, 3).toString())
  
  // Multiple return values
  quotient, remainder := divideWithRemainder(17, 5)
  print("17 ÷ 5 = " + quotient.toString() + " remainder " + remainder.toString())
  
  // Named return values
  numbers := [3, 1, 4, 1, 5, 9, 2, 6, 5]
  min, max, avg := calculateStats(numbers)
  print("Stats - Min: " + min.toString() + ", Max: " + max.toString() + ", Avg: " + avg.toString())
  
  // Early return
  index := findIndex(numbers, 9)
  print("Index of 9: " + index.toString())
  
  // Anonymous function (closure)
  counter := createCounter()
  print("Counter: " + counter().toString())  // 1
  print("Counter: " + counter().toString())  // 2
  print("Counter: " + counter().toString())  // 3
  
  // Higher-order function
  doubled := applyToEach(numbers, (n) -> int { return n * 2 })
  print("Doubled: " + doubled.toString())
  
  // Method call
  rect := Rectangle{width: 3.0, height: 4.0}
  print("Rectangle area: " + rect.area().toString())
  
  biggerRect := rect.scale(2.0)
  print("Scaled rectangle area: " + biggerRect.area().toString())
  
  // Variadic function call
  total := sum(1, 2, 3, 4, 5)
  print("Sum: " + total.toString())
} 