// math/geometry/shapes.mint - Geometric shape calculations
// @since Mint 0.4.0

const PI = 3.14159265359

// Calculate area of a circle
calculateCircleArea(float radius) -> float {
  return PI * radius * radius
}

// Calculate circumference of a circle
calculateCircleCircumference(float radius) -> float {
  return 2 * PI * radius
}

// Calculate area of a square
calculateSquareArea(float side) -> float {
  return side * side
}

// Calculate perimeter of a square
calculateSquarePerimeter(float side) -> float {
  return 4 * side
}

// Calculate area of a rectangle
calculateRectangleArea(float width, float height) -> float {
  return width * height
}

// Calculate perimeter of a rectangle
calculateRectanglePerimeter(float width, float height) -> float {
  return 2 * (width + height)
}

// Calculate area of a triangle
calculateTriangleArea(float base, float height) -> float {
  return 0.5 * base * height
}

// Calculate perimeter of a triangle using all sides
calculateTrianglePerimeter(float a, float b, float c) -> float {
  return a + b + c
}

// Private helper function
_validateDimension(float dimension) -> bool {
  return dimension > 0
} 