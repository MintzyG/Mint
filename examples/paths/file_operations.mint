// file_operations.mint - Path type and file operations
// @since Mint 0.3.1

// Import the OS module for file operations
import "os"

main() {
  // Create paths using the path type (no string manipulation required)
  path projectRoot = /home/user/projects/myapp
  path configFile = projectRoot + /config/settings.json
  
  // Get path components
  print("Base name: " + configFile.basename)     // settings.json
  print("Directory: " + configFile.dirname)      // /home/user/projects/myapp/config
  print("Extension: " + configFile.extension)    // .json
  
  // Path operations
  path relativePath = configFile.relativeTo(projectRoot)  // config/settings.json
  path absolute = relativePath.absoluteFrom(projectRoot)  // /home/user/projects/myapp/config/settings.json
  
  // File existence check
  if !configFile.exists() {
    // Create directories recursively
    configFile.dirname.mkdir(recursive: true)?
    
    // Create and write to the file
    configFile.writeText("""
    {
      "appName": "MyApp",
      "version": "1.0.0",
      "debug": true
    }
    """)?
    
    print("Created config file")
  }
  
  // Reading file content
  string content = configFile.readText()?
  print("Config content: " + content)
  
  // Working with directory contents
  []path sourceFiles = (projectRoot + /src).glob("**/*.mint")
  print("Found " + sourceFiles.length().toString() + " source files:")
  
  // Get file information
  for path file in sourceFiles {
    fileInfo := file.stat()?
    
    print("  " + file.relativeTo(projectRoot) + 
          " (" + fileInfo.size.toString() + " bytes, " +
          "modified: " + fileInfo.modifiedTime.format("%Y-%m-%d") + ")")
  }
  
  // Find files that match specific criteria
  []path largeFiles = projectRoot.findWhere((fileInfo) -> bool {
    return fileInfo.size > 1_000_000 && 
           fileInfo.extension == ".mint" && 
           fileInfo.modifiedTime > Time.daysAgo(7)
  })
  
  // Moving and copying files
  path backupDir = projectRoot + /backups/
  backupDir.mkdir(recursive: true)?
  
  path backupFile = backupDir + configFile.basename
  configFile.copy(backupFile)?
  
  print("Backup created at: " + backupFile)
} 