# Mint Package and Module System Examples

This directory contains examples that demonstrate how to use Mint's package and module system for organizing code.

## Package System Overview

Mint uses a folder-based package system where each directory represents a package, and all files in a directory are part of the same package. Packages can have subpackages (subdirectories), and all public code in a package is automatically exported when the package is imported.

## Module System Overview

Modules provide an additional layer of organization within packages. Every file in a package implicitly belongs to a module with the same package name, but files can explicitly declare they belong to a different module. This allows for finer-grained control over code visibility and organization.

## Example Structure

- `main.mint` - Main program demonstrating basic package imports and usage
- `imports_demo.mint` - Examples of different import syntax styles
- `modules_demo.mint` - Demonstrates module organization and visibility

### Packages

- `math/` - Package with mathematical operations
  - `basic.mint` - Basic math operations
  - `geometry/shapes.mint` - Geometric calculations
  - `stats/analysis.mint` - Statistical functions

- `utils/` - Utilities package
  - `formatting.mint` - String formatting utilities

- `logger/` - Logging utilities
  - `log.mint` - Logging with different levels

- `auth/` - Authentication package demonstrating module organization
  - `auth.mint` - Default auth module (implicitly `module auth`)
  - `crypto.mint` - Private crypto module (`module _crypto`)
  - `storage.mint` - Private storage module (`module _storage`)
  - `oauth.mint` - Specialized public OAuth module (`module auth.oauth`)

## Import Syntax Examples

The examples demonstrate different ways to import packages:

```mint
// Single imports
import math
import time as t
import strings { toUpper, toLower }

// Block imports
import (
  math
  strings
  time as t
)

// Mixed imports with aliases and selective imports
import (
  math as m { add, subtract }
  strings
  time as t
)
```

## Module Organization Examples

The `auth/` package demonstrates module organization patterns:

1. **Default Module** - Files without explicit module declarations belong to a module with the same name as the package.
   ```mint
   // auth/auth.mint - Implicitly "module auth"
   ```

2. **Private Modules** - Modules with a leading underscore are only accessible within the package.
   ```mint
   // auth/crypto.mint
   module _crypto
   ```

3. **Specialized Public Modules** - Named modules for organizing related functionality.
   ```mint
   // auth/oauth.mint
   module auth.oauth
   ```

4. **Module Usage** - Using the `use` directive to import modules within a package.
   ```mint
   // Inside auth/auth.mint
   use _crypto { hashPassword, verifyPassword }
   ```

## Running the Examples

```bash
# Run the main package example
mint run examples/packages/main.mint

# Run the modules demo
mint run examples/packages/modules_demo.mint

# Explore the import syntax demo
mint run examples/packages/imports_demo.mint
``` 