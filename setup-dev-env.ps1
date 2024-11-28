# Development Environment Setup Script for Compose Desktop Chatbot
# This script will set up both Java and Gradle environments

$gradleVersion = "8.3"
$javaVersion = "17.0.13.11"
$javaHome = "C:\Program Files\Eclipse Adoptium\jdk-$javaVersion-hotspot"
$gradleHome = "C:\gradle"
$downloadUrl = "https://services.gradle.org/distributions/gradle-$gradleVersion-bin.zip"
$zipFile = "$gradleHome\gradle-$gradleVersion-bin.zip"

function Write-Status {
    param(
        [string]$Message,
        [string]$Type = "Info" # Info, Success, Error, Warning
    )
    
    $color = switch ($Type) {
        "Success" { "Green" }
        "Error" { "Red" }
        "Warning" { "Yellow" }
        default { "Cyan" }
    }
    
    Write-Host $Message -ForegroundColor $color
}

# Function to check Java version
function Test-JavaInstallation {
    try {
        # Check if JAVA_HOME is set and valid
        $javaHome = [System.Environment]::GetEnvironmentVariable("JAVA_HOME", "User")
        if ($javaHome -and (Test-Path "$javaHome\bin\java.exe")) {
            $javaCmd = "$javaHome\bin\java.exe"
        } else {
            $javaCmd = "java"
        }

        # Capture java version output and redirect stderr to stdout to avoid error messages
        $javaOutput = & $javaCmd -version 2>&1 | Out-String
        
        # Clean up the output
        $javaOutput = $javaOutput.Trim()
        Write-Verbose "Java Version Output: $javaOutput"
        
        if ($javaOutput -match 'version "(\d+)') {
            $majorVersion = $matches[1]
            Write-Verbose "Detected Major Version: $majorVersion"
            return $majorVersion
        }
    }
    catch {
        Write-Warning "Error checking Java version: $($_.Exception.Message)"
        return $null
    }
    Write-Warning "Could not detect Java version from output: $javaOutput"
    return $null
}

# Function to check Gradle installation
function Test-GradleInstallation {
    try {
        $gradleOutput = gradle -v 2>&1
        if ($gradleOutput -match "Gradle (\d+\.\d+)") {
            return $matches[1]
        }
    }
    catch {
        return $null
    }
    return $null
}

# Function to set up Java environment
function Install-Java {
    Write-Status "Setting up Java environment..." "Info"
    
    # Set JAVA_HOME for the current process
    $env:JAVA_HOME = $javaHome

    # Set JAVA_HOME permanently for the user
    [System.Environment]::SetEnvironmentVariable(
        'JAVA_HOME',
        $javaHome,
        [System.EnvironmentVariableTarget]::User
    )

    # Add Java to PATH for the current process
    $env:Path = "$javaHome\bin;$env:Path"

    # Add Java to PATH permanently for the user
    $userPath = [System.Environment]::GetEnvironmentVariable(
        'Path',
        [System.EnvironmentVariableTarget]::User
    )
    if ($userPath -notlike "*$javaHome\bin*") {
        [System.Environment]::SetEnvironmentVariable(
            'Path',
            "$javaHome\bin;$userPath",
            [System.EnvironmentVariableTarget]::User
        )
    }

    Write-Status "Java environment variables have been set:" "Success"
    Write-Status "JAVA_HOME: $env:JAVA_HOME" "Success"
    
    # Verify Java installation
    $javaVersion = Test-JavaInstallation
    if ($javaVersion -eq "17") {
        Write-Status "Java $javaVersion installation verified successfully" "Success"
        return $true
    }
    else {
        Write-Status "Java installation verification failed. Please install Java 17 manually." "Error"
        return $false
    }
}

# Function to set up Gradle environment
function Install-Gradle {
    Write-Status "Setting up Gradle environment..." "Info"
    
    # Create gradle directory if it doesn't exist
    if (-not (Test-Path $gradleHome)) {
        New-Item -ItemType Directory -Force -Path $gradleHome | Out-Null
        Write-Status "Created Gradle directory at $gradleHome" "Info"
    }

    # Download Gradle if not already present
    if (-not (Test-Path "$gradleHome\gradle-$gradleVersion")) {
        Write-Status "Downloading Gradle $gradleVersion..." "Info"
        try {
            Invoke-WebRequest -Uri $downloadUrl -OutFile $zipFile
            Write-Status "Extracting Gradle..." "Info"
            Expand-Archive -Path $zipFile -DestinationPath $gradleHome -Force
            Remove-Item $zipFile
        }
        catch {
            Write-Status "Failed to download or extract Gradle: $_" "Error"
            return $false
        }
    }

    # Add Gradle to PATH
    $gradleBinPath = "$gradleHome\gradle-$gradleVersion\bin"
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")

    if ($userPath -notlike "*$gradleBinPath*") {
        [Environment]::SetEnvironmentVariable("Path", "$userPath;$gradleBinPath", "User")
        [Environment]::SetEnvironmentVariable("GRADLE_HOME", "$gradleHome\gradle-$gradleVersion", "User")
        Write-Status "Added Gradle to PATH" "Success"
    }

    Write-Status "Gradle $gradleVersion has been set up successfully" "Success"
    return $true
}

# Main setup process
Write-Status "Starting development environment setup..." "Info"
Write-Status "This script will set up Java and Gradle for your project" "Info"

# Check and setup Java
Write-Status "Checking Java installation..." "Info"
$javaVersion = Test-JavaInstallation
if ($null -eq $javaVersion -or [int]$javaVersion -lt 17) {
    Write-Status "Java 17 or higher is required" "Warning"
    if (-not (Install-Java)) {
        Write-Status "Failed to set up Java environment" "Error"
        exit 1
    }
}
else {
    Write-Status "Found compatible Java version: $javaVersion" "Success"
}

# Check and setup Gradle
Write-Status "Checking Gradle installation..." "Info"
$existingGradleVersion = Test-GradleInstallation
if ($null -eq $existingGradleVersion) {
    Write-Status "Gradle not found. Installing..." "Warning"
    if (-not (Install-Gradle)) {
        Write-Status "Failed to set up Gradle environment" "Error"
        exit 1
    }
}
elseif ($existingGradleVersion -ne $gradleVersion) {
    Write-Status "Found Gradle $existingGradleVersion, but version $gradleVersion is required" "Warning"
    if (-not (Install-Gradle)) {
        Write-Status "Failed to set up Gradle environment" "Error"
        exit 1
    }
}
else {
    Write-Status "Found compatible Gradle version: $existingGradleVersion" "Success"
}

Write-Status "Development environment setup completed successfully!" "Success"
Write-Status "Please restart your terminal for all changes to take effect" "Warning"
