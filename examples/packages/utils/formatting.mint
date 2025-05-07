// utils/formatting.mint - String formatting utilities
// @since Mint 0.4.0

// Format a string with variables
format(string template, ...any args) -> string {
  mut result := template
  
  for i, arg in args {
    string placeholder = "{" + i.toString() + "}"
    string value = arg.toString()
    result = result.replace(placeholder, value)
  }
  
  return result
}

// Format a number with thousands separators
formatNumber(int number) -> string {
  string numStr = number.toString()
  mut result := ""
  
  for i := 0; i < numStr.length(); i++ {
    if i > 0 && (numStr.length() - i) % 3 == 0 {
      result += ","
    }
    result += numStr[i]
  }
  
  return result
}

// Format a float with specified precision
formatFloat(float value, int precision) -> string {
  // Convert to string with fixed precision
  string str = value.toString(precision)
  
  // Handle the case where there might not be a decimal point
  if !str.contains(".") && precision > 0 {
    str += "."
    for i := 0; i < precision; i++ {
      str += "0"
    }
  }
  
  return str
}

// Format a currency value
formatCurrency(float amount, string currency = "$") -> string {
  return currency + formatFloat(amount, 2)
}

// Format a percentage
formatPercent(float value) -> string {
  return formatFloat(value * 100, 2) + "%"
}

// Get current timestamp as formatted string
timestamp() -> string {
  Time now = Time.now()
  return format("{0}-{1}-{2} {3}:{4}:{5}", 
    now.year,
    _padZero(now.month, 2),
    _padZero(now.day, 2),
    _padZero(now.hour, 2),
    _padZero(now.minute, 2),
    _padZero(now.second, 2)
  )
}

// Private helper function to pad numbers with leading zeros
_padZero(int num, int width) -> string {
  string result = num.toString()
  
  while result.length() < width {
    result = "0" + result
  }
  
  return result
} 