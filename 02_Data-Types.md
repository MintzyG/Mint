# Mint Language: Data Types

## Table of Contents

1. [Primitive Types](#1-primitive-types)
2. [Type Aliases](#2-type-aliases)
3. [Collections](#3-collections)

   * [Slices](#slices)
   * [Tuples](#tuples)
   * [Maps](#maps)
   * [Sets](#sets)
4. [Structs](#4-structs)
5. [Enums](#5-enums)
6. [Result Types](#6-result-types)
7. [Visibility Modifiers (Experimental)](#7-visibility-modifiers-experimental)

---

## 1. Primitive Types

Mint provides several built-in primitive data types:

### Integers

```mint
int              // Default integer type (i32)
i8, i16, i32, i64, i128   // Signed integers
u8, u16, u32, u64, u128   // Unsigned integers
```

### Floating Point

```mint
float   // Default floating type (f32)
f32, f64
```

### Boolean

```mint
bool    // true or false
```

### Character

```mint
char    // UTF-8 character
```

### String

```mint
string  // UTF-8 text
```

### Path

```mint
path homePath = /home/user
path configFile = /etc/config.json
path relativePath = ./src/main.mint
```

Path operations:

```mint
path projectRoot = /home/user/projects
path sourceFile = projectRoot + /src/main.mint
bool exists = homePath.exists()
```

---

## 2. Type Aliases

```mint
type UserID int
type EmailAddress string

UserID id = 42
EmailAddress email = "user@example.com"
```

---

## 3. Collections

### Slices

Dynamic arrays that grow or shrink.

```mint
[]int numbers = [1, 2, 3, 4, 5]
[]string names = ["Alice", "Bob"]
[]int empty = []

[]int subset = numbers[1:3]
[]int copy = numbers[:]
```

Static arrays:

```mint
static []int fixed = [1, 2, 3]
```

Slice operations:

```mint
numbers.append(6)
numbers.insert(0, 0)
numbers.remove(2)
int last = numbers.pop()
int len = numbers.len()
```

### Tuples

```mint
(int, string) pair = (42, "answer")
(int, int, bool) triple = (1, 2, true)

int first = pair[0]
string second = pair[1]

int x, string text = pair
int a, _, bool flag = triple
int a = triple // implicit drop, will throw a warning
```

Functions returning tuples:

```mint
func(int a, int b) -> (int, int) {
  return a + b, a * b
}

int sum, product = func(1, 2)
sum, _ := func(1, 2)
sum := func(1, 2) // implicit drop, will throw a warning
```

### Maps

```mint
map[string]int scores = {"Alice": 95, "Bob": 87}
map[int]string ids = {1: "A001", 2: "B002"}

scores["Charlie"] = 90
scores["Bob"] = 92

int score, bool exists = scores["Dave"]
int score = scores["Alice"]   // implicit drop, will throw a warning
score, _ := scores["Alice"]

scores.delete("Bob")
int count = scores.len()
```

### Sets

```mint
set[int] numbers = {1, 2, 3, 4, 5}
set[string] fruits = {"apple", "banana"}

fruits.add("grape")
fruits.remove("banana")
bool has = fruits.contains("apple")
set[int] union = numbers.union({4, 5, 6})
set[int] intersection = numbers.intersection({3, 4, 5})
int count = fruits.len()
```

---

## 4. Structs

```mint
struct User {
  string name
  int age
  bool active
}

User user1 = {"Alice", 30, true}
User user2 = {name: "Bob", age: 25, active: false}

string name = user1.name
user2.active = true
```

Nested structs:

```mint
struct Address {
  string street
  string city
  string country
}

struct Contact {
  string name
  Address address
}

Contact contact = {
  "Alice",
  {"123 Main St", "Anytown", "Exampleland"}
}

string city = contact.address.city
```

---

## 5. Enums

```mint
enum Color {
  Red
  Green
  Blue
  Yellow
}

enum HttpStatus {
  OK = 200
  Created = 201
  NotFound = 404
  ServerError = 500
}

Color primaryColor = Color.Red
HttpStatus success = HttpStatus.OK
int statusCode = HttpStatus.NotFound

match primaryColor {
  Color.Red -> print("Stop")
  Color.Green -> print("Go")
  Color.Yellow -> print("Caution")
  _ -> print("Unknown")
}

HttpStatus status = HttpStatus.fromInt(200)
```

---

## 6. Result Types

Results use `<...T;E>` where `T` are values, `E` is error type.

```mint
<int;error> singleResult
<int,string;error> multiResult
<string,int,bool;error> tripleResult
```

Functions:

```mint
getValue() -> <int;error> {
  if someCondition {
    return 42
  } else {
    return error("Failed")
  }
}

getCoordinates() -> <int,int;error> {
  if validLocation {
    return 10, 20
  } else {
    return error("Invalid")
  }
}
```

Working with results:

```mint
<int;error> result = getValue()
if result is ok {
  print(result.value)
} else {
  print(result.error)
}

<int,int;error> coords = getCoordinates()
if coords is ok {
  print(coords.value1, coords.value2)
}
```

Pattern matching:

```mint
match result {
  ok value -> print(value)
  err msg -> print(msg)
}
```

Error propagation with `?`:

```mint
processData() -> <string;error> {
  int value = getValue()?
  int x, int y = getCoordinates()?
  return "Processed: " + x.toString() + ", " + y.toString()
}
```

---

## 7. Visibility Modifiers (Experimental)

Mint uses naming conventions:

* **Public**: no prefix
* **Private**: leading `_`
* **Module-private**: prefix `m_`

Example:

```mint
struct Person {
  string name      // public
  int Age          // public
  bool _active     // private
  string m_notes   // module-private
}

Person p = {"Alice", 30, true, "Some notes"}
string n = p.name
bool act = p._active    // ERROR
```

Functions:

```mint
square(int x) -> int {
  return x * x
}

_calculateTax(float amount) -> float {
  return amount * 0.2
}

m_ProcessData(int[] data) -> int[] {
  // impl
}
```

Global variables:

```mint
int publicVar = 0
int _counter = 0
int _ModuleVar = 0
```

This applies to all declarations: functions, struct fields, globals, types, constants.

