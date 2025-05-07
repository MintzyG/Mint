// math/stats/analysis.mint - Statistical calculations
// @since Mint 0.4.0

// Import the basic math functions to use them
import ..basic { sum, average, max, min }

// Calculate median of an array of integers
median([]int numbers) -> float {
  if numbers.isEmpty() {
    return 0.0
  }
  
  // Create a sorted copy of the array
  []int sorted = numbers.copy()
  sorted.sort()
  
  int length = sorted.length()
  
  if length % 2 == 1 {
    // Odd number of elements - return the middle one
    return sorted[length / 2]
  } else {
    // Even number of elements - return average of the two middle ones
    int middle1 = sorted[(length / 2) - 1]
    int middle2 = sorted[length / 2]
    return (middle1 + middle2) / 2.0
  }
}

// Calculate mode (most frequent value) of an array
mode([]int numbers) -> int {
  if numbers.isEmpty() {
    return 0
  }
  
  // Count occurrences of each number
  Map<int, int> counts = {}
  for n in numbers {
    if counts.has(n) {
      counts[n] += 1
    } else {
      counts[n] = 1
    }
  }
  
  // Find the number with the highest count
  mut maxCount := 0
  mut modeValue := numbers[0]
  
  for n, count in counts {
    if count > maxCount {
      maxCount = count
      modeValue = n
    }
  }
  
  return modeValue
}

// Calculate variance of an array
variance([]int numbers) -> float {
  if numbers.isEmpty() || numbers.length() == 1 {
    return 0.0
  }
  
  // Calculate mean
  float mean = average(numbers)
  
  // Calculate sum of squared differences from the mean
  float sumSquaredDiff = 0.0
  for n in numbers {
    float diff = n - mean
    sumSquaredDiff += diff * diff
  }
  
  // Return the variance
  return sumSquaredDiff / numbers.length()
}

// Calculate standard deviation of an array
standardDeviation([]int numbers) -> float {
  return variance(numbers) ** 0.5  // Square root of variance
}

// Calculate range (max - min) of an array
range([]int numbers) -> int {
  if numbers.isEmpty() {
    return 0
  }
  
  return max(numbers) - min(numbers)
} 