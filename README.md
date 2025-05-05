# Mint Programming Language

<p align="center">
  <img src="https://via.placeholder.com/200x200?text=Mint" alt="Mint Logo" width="200" height="200">
</p>

## What is Mint?

Mint is a weird (in a good way!) mid-level programming language that I'm developing as a hobby project. It's designed to look feel and behave like a high-level language while giving you the power to go as low-level as you want. The syntax is clean and easy to type, but don't let that fool you - underneath that approachable exterior lies a powerful beast.

**The philosophy is simple**: Start writing code that feels comfortable and familiar, then dial in the performance by going deeper when you need to. Yes, the code might start to look a bit scary when you venture into the low-level features, but that's the beauty of it - you choose your level of engagement.

## Why Mint?

- **Flexible abstraction levels**: Write high-level code when you want convenience, drop down to lower levels when you need performance
- **Modern syntax**: Designed to be easy to read, write and understand
- **Pragmatic features**: Takes the best ideas from many languages while maintaining consistency
- **Multiple execution paths**: Interpreter for rapid development, compiler for production, and transpilers for integration

## Feature Highlights

- **First-class path type**: Native filesystem path handling without string manipulation
- **Pipe operators** (`|>` and `||>`) for elegant function composition and method chaining
- **Error handling** with Result types and the `?` propagation operator
- **Pattern matching** with exhaustive checking and destructuring
- **Immutable by default** with opt-in mutability
- **Early returns with conditions** using the `return if` syntax
- **Flexible memory management**: Automatic or manual, your choice
- **Structural typing** alongside nominal typing
- **Anonymous functions** with proper closures
- **Numeric literals with underscores** for readability
- **Module system** with clean imports and exports

...and many more features in development!

## Code Showcases

### Basic Syntax and Type Inference

```mint
// Variables are immutable by default
count := 5               // Type inference
mut total := 0           // Mutable variable

// Functions are concise but explicit
calculateArea(float width, float height) -> float {
  return width * height
}

// Pattern matching
match status {
  200 -> process(status)
  404 -> retry()
  500 -> log(status.msg)
  _ -> handleUnknown(status)
}
```

### Error Handling with Pipe Operators

```mint
processHTMLTemplate(FILE file, Body data) -> <string, error> {
  return os.Open(file)?         // Return early if there's an error
    |> ParseTemplate?           // Each step can short-circuit on error
    ||> ExecuteTemplate(data)?  // Methods can also use error propagation
    ||> Minify()                // Final transformation
}
```

### Path Type and Operations

```mint
// Native path type (no string manipulation needed)
path projectRoot = /home/user/projects
path sourceFile = projectRoot + /src/main.mint

// Finding specific files with predicates
[]path largeFiles = projectRoot.FindWhere((File file) -> bool { 
  return file.size > 1_000_000 && 
         file.extension == ".mint" && 
         file.modifiedTime > Time.yesterday()
})
```

### Low-Level Control When You Need It

```mint
@unsafe
directMemoryAccess(address uintptr, size int) -> []byte {
  byte *buffer = (byte*)malloc(size)
  if buffer == nil {
    return nil
  }
  
  // Manual memory manipulation
  for i := 0; i < size; i++ {
    buffer[i] = *(address + i)
  }
  
  return buffer
}
```

## Multiple Implementation Paths

Mint gives you options for how to run your code:

- **Interpreter** (`mint run`): Quick development and experimentation without compilation
- **Compiler** (`mint build`): Native code generation via LLVM for maximum performance
- **C Transpiler** (`mint transpile-c`): Generate C code for maximum portability
- **JS/TS Transpiler** (`mint transpile-js`): Deploy Mint code to the browser or Node.js
- **Minifier** (`mint minify`): Compress Mint code for smaller distributions
- **Mini-Mint**: An experimental compiler/interpreter that runs Mint in the browser as a JS alternative

## Examples

The project includes a comprehensive examples directory demonstrating various Mint language features:

- **Unit testing** with `.minty` files
- **Variable declaration and type inference**
- **Error handling** with result types
- **Path operations** for file and directory management
- **Advanced function** features like closures and higher-order functions
- **Pattern matching** for elegant control flow

Each example is fully commented and designed to showcase practical usage of language features. Check out the [`examples/`](examples/) directory to explore these samples.

## Testing and Configuration with .minty Files

Mint uses the `.minty` extension for specialized companion files that enhance your main `.mint` code:

### Unit Testing

For every module in your codebase, you can create a corresponding `.minty` test file. This creates a clean one-to-one relationship between implementation and tests:

```
src/
  ├── user.mint        # Implementation
  ├── user.minty       # Tests for user.mint
  ├── payment.mint     # Implementation
  └── payment.minty    # Tests for payment.mint
```

Test files use a simple, declarative syntax:

```minty
// Test file for user.mint
@test
module UserTests {
  @test
  testValidUser() {
    validUser := User {
      name: "John Doe",
      email: "john@example.com",
      age: 30
    }
    
    isValid, errors := validateUser(validUser)
    
    assert(isValid)
    assert(errors.len() == 0)
  }
  
  @test
  testInvalidEmail() {
    invalidUser := User {
      name: "Jane Doe",
      email: "invalid-email",  // Missing @
      age: 30
    }
    
    isValid, errors := validateUser(invalidUser)
    
    assert(!isValid)
    assert(errors[0].contains("email"))
  }
}
```

Run tests with a simple command:

```bash
$ mint test user.minty   # Test a specific file
$ mint test              # Run all tests
```

## Project Status

This is a hobby project I'm building for fun to explore language design and implementation. I'm just seeing what I can create, learning as I go, and enjoying the journey. Who knows? Maybe it'll become something real someday!

The language is under active development with frequent additions and changes. Check out the version information in the documentation to see what's implemented so far.

## Documentation

The language documentation is split into multiple files:

1. **1_Basics.mintdoc** - Basic syntax, variables, operators
2. **2_DataTypes.mintdoc** - Primitive types, collections, structs, enums
3. **3_ControlFlow.mintdoc** - Conditionals, loops, pattern matching
4. **4_Functions.mintdoc** - Function declarations, parameters, methods
5. **5_ErrorHandling.mintdoc** - Error types, result types, errorspaces
6. **6_AdvancedFeatures.mintdoc** - Modules, macros, concurrency, reflection
7. **7_Annotations.mintdoc** - Annotations and struct tags
8. **MintSpecial/** - Special documentation for specific types and features

## Get Involved

Want to join the fun? I'd love to have collaborators who are passionate about language design and implementation! Here's how you can help:

- **Contribute to the documentation**: Help clarify concepts or add examples
- **Suggest new features**: Have a cool idea? Let me know!
- **Implementation help**: If you're into compilers, interpreters, or language design
- **Testing and feedback**: Try out Mint and let me know what works and what doesn't

## License

The Mint language and its documentation are licensed under the MIT License. Feel free to explore, modify, and share!

---

<p align="center">
  <i>Because programming should be both powerful and enjoyable.</i>
</p>
