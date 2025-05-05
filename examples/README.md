# Mint Programming Language Examples

This directory contains a collection of examples showcasing various features of the Mint programming language. Each example is designed to demonstrate specific language features and provide practical code snippets that you can learn from and adapt for your own projects.

## Directory Structure

- **tests/** - Examples of unit testing with `.minty` test files
- **variables/** - Variable declaration, type inference, and constants
- **error_handling/** - Result types, error propagation, and custom error types
- **paths/** - Usage of the first-class path type for file operations
- **functions/** - Function declarations, parameters, closures, and higher-order functions
- **control_flow/** - Pattern matching, conditionals, and loops

## Running the Examples

To run any example, use the Mint interpreter:

```bash
# Run an example file
mint run examples/variables/basic_variables.mint

# Run tests
mint test examples/tests/math.minty
```

## Example Highlights

### Testing with `.minty` Files

The `tests/` directory showcases the test companion files that follow the one-to-one relationship with implementation files:

- `user.mint` - User module implementation
- `user.minty` - Corresponding test file for the user module
- `math.mint` - Math utility implementation
- `math.minty` - Corresponding test file for the math utilities

### Path Type Examples

The `paths/` directory shows the power of Mint's first-class path type:

- `file_operations.mint` - Demonstrates working with files and directories using the path type

### Error Handling

The `error_handling/` directory demonstrates Mint's powerful error handling capabilities:

- `result_types.mint` - Working with result types and error propagation

## Learning Path

If you're new to Mint, we recommend exploring the examples in this order:

1. Start with `variables/basic_variables.mint` to understand variable declaration and types
2. Move to `functions/advanced_functions.mint` to learn about function syntax and features
3. Explore `error_handling/result_types.mint` to understand error handling
4. Check out `paths/file_operations.mint` to see the path type in action
5. Dive into `control_flow/pattern_matching.mint` for advanced control flow techniques
6. Finally, explore the `.minty` files in `tests/` and `minty_features/` to see their capabilities

## Contributing

Feel free to submit additional examples or improvements to the existing ones. Good examples should be:

- Clear and concise
- Well-commented
- Focused on demonstrating specific features
- Runnable on their own when possible 