# Mint Language: Basics and Syntax

## Table of Contents

1. [Comments and Documentation](#comments-and-documentation)
2. [Basic Syntax](#basic-syntax)
3. [Variables and Constants](#variables-and-constants)
4. [Operators](#operators)

   * [Arithmetic Operators](#arithmetic-operators)
   * [Comparison Operators](#comparison-operators)
   * [Logical Operators](#logical-operators)
   * [Bitwise Operators](#bitwise-operators)
   * [Assignment Operators](#assignment-operators)
   * [Error Propagation Operator](#error-propagation-operator)
   * [Conditional (Ternary) Operator](#conditional-ternary-operator)
   * [Pipe Operators](#pipe-operators)

---

## 1. Comments and Documentation

* **Single-line comment**:

  ```mint
  // This is a comment
  ```

* **Multi-line comment**:

  ```mint
  /*
   Multi
   Line
   Comment
  */
  ```

* **Doc comments** (for documentation generation):

  ```mint
  !// single line Doc comment

  /*! 
    Multiline
    Doc comment
  */
  ```

---

## 2. Basic Syntax

* Whitespace is **not significant**.
* Indentation is optional (formatter enforces 2 spaces).
* **Statements end with a newline**. Multiple statements on one line use `;`.

```mint
int x = 10; float y = 3.14
```

### Numeric Literals

```mint
int largeNumber = 1_000_000       // Same as 1000000
float pi = 3.141_592_653          // Same as 3.141592653
int binary = 0b1010_1010          // Binary
int hex = 0xFF_AA_BB              // Hexadecimal
float scientific = 6.022_140_76e23 // Scientific notation
```

Underscores are ignored, only for readability.

---

## 3. Variables and Constants

### Variables

* Immutable by default:

  ```mint
  int x = 10
  x = 11 // ❌ Forbidden
  ```

* Mutable variables use `mut`:

  ```mint
  mut int y = 10
  y = 11 // ✅ Allowed
  ```

* Type inference with `:=`:

  ```mint
  z := 10   // int
  w := x    // type of w is int
  ```

### Constants

* Evaluated at **compile time**:

  ```mint
  const PI = 3.14159
  const MAX_USERS = 1000
  const APP_NAME = "Mint App"
  ```

* Supported types: integers, floats, booleans, chars, strings.

* Can depend on other constants:

  ```mint
  const CIRCLE_DIAMETER = 10
  const CIRCLE_RADIUS = CIRCLE_DIAMETER / 2
  const CIRCLE_AREA = PI * CIRCLE_RADIUS * CIRCLE_RADIUS
  ```

* Example with bitwise/math:

  ```mint
  const BINARY_FLAG = 1 << 4       // 16
  const HEX_VALUE = 0xFF + 0x10    // 271
  const IS_POWER_OF_TWO = (16 & (16-1)) == 0 // true
  ```

* Optional type annotation:

  ```mint
  const float GRAVITY = 9.81
  const int MAX_RETRIES = 3
  const string VERSION = "1.0.0"
  ```

* Visibility:

  ```mint
  const MAX_PUBLIC_SIZE = 1024
  const _MAX_PRIVATE_SIZE = 2048    // file scope only
  const m_MAX_MODULE_SIZE = 4096    // module private
  ```

---

## 4. Operators

### Arithmetic Operators

```mint
+   // Addition
-   // Subtraction
*   // Multiplication
/   // Division
\   // Integer division
%   // Modulus
```

Example:

```mint
int sum = 10 + 5     // 15
int product = 4 * 3  // 12
```

---

### Comparison Operators

```mint
==  // Equal to
!=  // Not equal to
>   // Greater than
<   // Less than
>=  // Greater than or equal
<=  // Less than or equal
```

---

### Logical Operators

```mint
&&  // AND
||  // OR
!   // NOT
```

---

### Bitwise Operators

```mint
&   // AND
|   // OR
~   // NOT
<<  // Left shift
>>  // Right shift
^   // XOR
```

---

### Assignment Operators

```mint
=   // Assignment
+=  // Add and assign
-=  // Subtract and assign
*=  // Multiply and assign
/=  // Divide and assign
\=  // Integer divide and assign
%=  // Modulus and assign
&=  // Bitwise AND and assign
|=  // Bitwise OR and assign
~=  // Bitwise NOT and assign
^=  // Bitwise XOR and assign
<<= // Shift left and assign
>>= // Shift right and assign
```

---

### Error Propagation Operator (`?`)

* Works with `<T, error>` or `(value, error)` returns.
* If error → return immediately.
* If success → unwrap value.

```mint
readConfig(path string) -> <Config, error> {
  []byte data = readFile(path)?        // returns early if error
  Config config = parseConfig(data)?   // unwraps result
  return config
}
```

---

### Conditional (Ternary) Operator

```mint
condition ? valueIfTrue : valueIfFalse
```

Example:

```mint
int max = a > b ? a : b
string status = isActive ? "Running" : "Stopped"
```

---

### Pipe Operators

* **Single pipe (`|>`)**: pass result as **first argument**.
* **Double pipe (`||>`)**: call **method** on result.

```mint
string processed = "hello world"
  |> trim
  |> uppercase
  |> reverse
// = reverse(uppercase(trim("hello world")))
```

Example with methods:

```mint
[]int numbers = [1, 2, 3, 4, 5]
  |> sort
  ||> isEmpty()
// = sort([1, 2, 3, 4, 5]).isEmpty()
```

Data processing:

```mint
[]int result = [2, 1, 5, 4, 3]
  |> map(square)
  |> filter((int x) -> bool { return x > 10 })
  ||> sort()
  ||> reverse()
// = filter(map([2, 1, 5, 4, 3], square), (int x) -> bool { return x > 10 }).sort().reverse()
```

Error-handling pipeline:

```mint
readFile(path)?
  |> parseJson
  ||> validate()
  ||> transform("user_data")
```

---
