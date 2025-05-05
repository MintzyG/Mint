// loops.mint - Examples of different loop types in Mint
// @since Mint 0.2.3

main() {
  // Basic for loop with counter
  print("Basic for loop with counter:")
  for i := 0; i < 5; i++ {
    print("  Index: " + i.toString())
  }
  
  // For loop with collection iteration
  print("\nFor loop with collection iteration:")
  numbers := [10, 20, 30, 40, 50]
  for num in numbers {
    print("  Value: " + num.toString())
  }
  
  // For loop with index and value
  print("\nFor loop with index and value:")
  words := ["apple", "banana", "cherry", "date"]
  for index, word in words {
    print("  " + index.toString() + ": " + word)
  }
  
  // While loop
  print("\nWhile loop:")
  mut counter := 0
  while counter < 5 {
    print("  Counter: " + counter.toString())
    counter += 1
  }
  
  // While loop with break
  print("\nWhile loop with break:")
  mut i := 0
  while true {
    if i >= 5 {
      break  // Exit the loop
    }
    print("  Value: " + i.toString())
    i += 1
  }
  
  // While loop with continue
  print("\nWhile loop with continue (skip even numbers):")
  mut j := 0
  while j < 10 {
    j += 1
    if j % 2 == 0 {
      continue  // Skip the rest of this iteration
    }
    print("  Odd number: " + j.toString())
  }
  
  // Loop labels
  print("\nNested loops with labels:")
  outer: for i := 0; i < 3; i++ {
    inner: for j := 0; j < 3; j++ {
      if i == 1 && j == 1 {
        print("  Breaking inner loop at i=" + i.toString() + ", j=" + j.toString())
        break inner
      }
      
      if i == 2 && j == 0 {
        print("  Breaking outer loop at i=" + i.toString() + ", j=" + j.toString())
        break outer
      }
      
      print("  i=" + i.toString() + ", j=" + j.toString())
    }
  }
  
  // Iterating over a map
  print("\nIterating over a map:")
  ages := Map<string, int>{
    "Alice": 30,
    "Bob": 25,
    "Carol": 35
  }
  
  for name, age in ages {
    print("  " + name + " is " + age.toString() + " years old")
  }
  
  // Iterating over a range
  print("\nIterating over a range:")
  for i in 1..5 {
    print("  Range value: " + i.toString())
  }
  
  // While loop with collection iteration
  // @since Mint 0.3.0
  print("\nWhile loop with collection iteration:")
  mut iterator := numbers.iterator()
  while value := iterator.next() {
    print("  Iterator value: " + value.toString())
  }
} 