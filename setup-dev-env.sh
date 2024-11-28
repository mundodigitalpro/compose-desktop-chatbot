#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Versions
GRADLE_VERSION="8.3"
JAVA_VERSION="17"

# Print colored message
print_message() {
    local message=$1
    local type=$2

    case $type in
        "error")
            echo -e "${RED}$message${NC}"
            ;;
        "success")
            echo -e "${GREEN}$message${NC}"
            ;;
        "warning")
            echo -e "${YELLOW}$message${NC}"
            ;;
        *)
            echo -e "${CYAN}$message${NC}"
            ;;
    esac
}

# Check Java installation
check_java() {
    if command -v java &> /dev/null; then
        local version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | awk -F. '{print $1}')
        if [ "$version" -ge $JAVA_VERSION ]; then
            print_message "Found compatible Java version: $version" "success"
            return 0
        else
            print_message "Java $version found, but version $JAVA_VERSION or higher is required" "error"
            return 1
        fi
    else
        print_message "Java not found" "error"
        return 1
    fi
}

# Check Gradle installation
check_gradle() {
    if command -v gradle &> /dev/null; then
        local version=$(gradle -v | grep "Gradle " | awk '{print $2}')
        if [ "$version" = "$GRADLE_VERSION" ]; then
            print_message "Found compatible Gradle version: $version" "success"
            return 0
        else
            print_message "Gradle $version found, but version $GRADLE_VERSION is required" "warning"
            return 1
        fi
    else
        print_message "Gradle not found" "error"
        return 1
    fi
}

# Main setup process
print_message "Starting development environment setup..." "info"
print_message "This script will check your Java and Gradle installation" "info"

# Check Java
print_message "Checking Java installation..." "info"
if ! check_java; then
    print_message "Please install Java $JAVA_VERSION or higher. You can:" "warning"
    print_message "1. Use SDKMAN: curl -s 'https://get.sdkman.io' | bash" "info"
    print_message "   Then: source '$HOME/.sdkman/bin/sdkman-init.sh'" "info"
    print_message "   Finally: sdk install java $JAVA_VERSION-tem" "info"
    print_message "2. Or use your distribution's package manager:" "info"
    print_message "   Ubuntu/Debian: sudo apt install openjdk-${JAVA_VERSION}-jdk" "info"
    print_message "   Fedora: sudo dnf install java-${JAVA_VERSION}-openjdk-devel" "info"
    print_message "   Arch: sudo pacman -S jdk${JAVA_VERSION}-openjdk" "info"
    exit 1
fi

# Check Gradle
print_message "Checking Gradle installation..." "info"
if ! check_gradle; then
    print_message "Gradle $GRADLE_VERSION not found, but that's okay!" "info"
    print_message "The project includes Gradle Wrapper (./gradlew) which will download and use the correct version automatically" "success"
fi

print_message "Environment check completed!" "success"
print_message "To run the project:" "info"
print_message "1. Create .env file with your OpenAI API key" "info"
print_message "2. Run: ./gradlew run" "info"
