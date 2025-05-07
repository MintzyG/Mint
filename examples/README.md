# Mint Programming Language Examples

This directory contains a collection of examples showcasing various features of the Mint programming language. Each example is designed to demonstrate specific language features and provide practical code snippets that you can learn from and adapt for your own projects.

## Directory Structure

- **tests/** - Examples of unit testing with `.minty` test files
- **variables/** - Variable declaration, type inference, and constants
- **error_handling/** - Result types, error propagation, and custom error types
- **paths/** - Usage of the first-class path type for file operations
- **functions/** - Function declarations, parameters, closures, and higher-order functions
- **control_flow/** - Pattern matching, conditionals, and loops
- **packages/** - Organizing code with packages, imports, and subpackages

## Running the Examples

To run any example, use the Mint interpreter:

```bash
# Run an example file
mint run examples/variables/basic_variables.mint

# Run tests
mint test examples/tests/math.minty

# Run the packages example
mint run examples/packages/main.mint
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

### Package System

The `packages/` directory demonstrates Mint's package system:

- `main.mint` - Main program that imports and uses various packages
- `math/` - Package with mathematical operations
  - `basic.mint` - Basic math operations
  - `geometry/` - Subpackage for geometric calculations
  - `stats/` - Subpackage for statistical functions
- `utils/` - Utilities package with formatting functions
- `logger/` - Logging package with different log levels
- `imports_demo.mint` - Examples of different import syntax styles
- `auth/` - Authentication package demonstrating module organization
  - `auth.mint` - Default auth module (implicitly `module auth`)
  - `crypto.mint` - Private crypto module (`module _crypto`)
  - `storage.mint` - Private storage module (`module _storage`)
  - `oauth.mint` - Specialized public OAuth module (`module auth.oauth`)
- `modules_demo.mint` - Demonstrates module organization and visibility

This example shows how to organize code into packages, import them with different methods (block imports, selective imports, aliases), and work with subpackages. The new simplified import syntax allows for more concise and readable code organization.

The `auth/` package and `modules_demo.mint` demonstrate how to use modules for better organization within packages, including:
- Default implicit modules (same name as the package)
- Private modules (using `_` prefix) that are only accessible within the package
- Specialized public modules for grouping related functionality
- The `use` directive for importing modules within a package

## Learning Path

If you're new to Mint, we recommend exploring the examples in this order:

1. Start with `variables/basic_variables.mint` to understand variable declaration and types
2. Move to `functions/advanced_functions.mint` to learn about function syntax and features
3. Explore `error_handling/result_types.mint` to understand error handling
4. Check out `paths/file_operations.mint` to see the path type in action
5. Dive into `control_flow/pattern_matching.mint` for advanced control flow techniques
6. Explore the `packages/` directory to understand code organization
7. Finally, explore the `.minty` files in `tests/` to see their capabilities

## Contributing

Feel free to submit additional examples or improvements to the existing ones. Good examples should be:

- Clear and concise
- Well-commented
- Focused on demonstrating specific features
- Runnable on their own when possible 