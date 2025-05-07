// imports_demo.mint - Examples of different import styles
// @since Mint 0.4.0

// Single imports
// --------------

// Basic single import
import math

// Single import with alias
import time as t

// Single import with selective items
import strings { toUpper, toLower }

// Single import with alias and selective items
import utils.formatting as fmt { format, timestamp }

// Multiple imports
// ---------------

// Basic multiple imports
import (
  math
  strings
  time
)

// Multiple imports with aliases
import (
  math as m
  strings as str
  time as t
)

// Multiple imports with selective items
import (
  math { add, subtract, multiply }
  strings { toUpper, toLower, trim }
)

// Mixed import styles
import (
  math as m { add, subtract }
  strings
  time as t
  logger
)

// Complex import example
import (
  math {
    add, 
    subtract,
    multiply as mul,
    divide
  }
  strings as str {
    toUpper, 
    toLower as lower,
    trim
  }
  time as t
  os
)

// Relative imports for subpackages
// Using relative path with '..' to go up one level
import ..parent_module

// Using full package path
import my.package.subpackage

// Import standard library packages
import (
  io
  fmt
  os { path }
)

main() {
  // This file only demonstrates different ways to write imports
  // It's not meant to be executed
  print("Import syntax demo")
} 