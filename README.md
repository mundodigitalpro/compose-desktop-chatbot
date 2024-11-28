# Compose Desktop Chatbot

A modern desktop chatbot application built with Kotlin and Jetpack Compose Desktop, powered by OpenAI's GPT-3.5 model.

## Features

- Clean and intuitive chat interface
- Real-time conversation with GPT-3.5
- Modern Material Design 3 UI
- Cross-platform desktop support (Windows, Linux, macOS)

## Prerequisites

- OpenAI API key

### For Windows
- Windows OS
- PowerShell (comes with Windows)

### For Linux
- Any modern Linux distribution
- Bash shell (comes with most Linux distributions)

The setup scripts will help you install or verify:
- JDK 17 (Eclipse Temurin/OpenJDK)
- Gradle 8.3 (optional, as the project includes Gradle wrapper)

## Setup

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/compose-desktop-chatbot.git
cd compose-desktop-chatbot
```

2. Run the appropriate setup script for your OS:

### Windows:
```powershell
.\setup-dev-env.ps1
```
This script will:
- Check for and install Java 17 if needed
- Configure JAVA_HOME and PATH
- Install Gradle 8.3 if needed
- Configure GRADLE_HOME and PATH

### Linux:
```bash
# Make the script executable
chmod +x setup-dev-env.sh
# Run the script
./setup-dev-env.sh
```
This script will:
- Check for Java 17 installation
- Provide instructions to install Java if needed
- Verify Gradle wrapper availability
- Guide you through any necessary setup

3. Create a `.env` file in the project root:
```
OPENAI_API_KEY=your_api_key_here
```

4. Replace `your_api_key_here` with your actual OpenAI API key

5. Restart your terminal for environment changes to take effect

## Running the Application

Run the application using the Gradle wrapper:

```bash
# On Linux/macOS
./gradlew run

# On Windows
.\gradlew run
```

## Building

To create a distribution:

```bash
# On Linux/macOS
./gradlew package

# On Windows
.\gradlew package
```

This will create platform-specific distributions in `build/compose/binaries`.

## Manual Setup

If you prefer manual setup:

### Linux/macOS
1. Install JDK 17 or later:
   - Using SDKMAN: `sdk install java 17-tem`
   - Using package manager:
     - Ubuntu/Debian: `sudo apt install openjdk-17-jdk`
     - Fedora: `sudo dnf install java-17-openjdk-devel`
     - Arch: `sudo pacman -S jdk17-openjdk`

### Windows
1. Install JDK 17 or later from [Eclipse Temurin](https://adoptium.net/)
2. Install Gradle 8.3 from [gradle.org](https://gradle.org/install/)
3. Configure JAVA_HOME and GRADLE_HOME environment variables

After manual setup, follow steps 3-4 from the Setup section above.

## Tech Stack

- Kotlin
- Jetpack Compose Desktop
- OpenAI API
- Material Design 3
- Kotlin Coroutines
- Dotenv Kotlin

## License

This project is licensed under the MIT License - see the LICENSE file for details.
