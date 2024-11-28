# Compose Desktop Chatbot

A modern desktop chatbot application built with Kotlin and Jetpack Compose Desktop, powered by OpenAI's GPT-3.5 model.

## Features

- Clean and intuitive chat interface
- Real-time conversation with GPT-3.5
- Modern Material Design 3 UI
- Built for Windows desktop

## Prerequisites

- Windows OS
- PowerShell (comes with Windows)
- OpenAI API key

The setup script will automatically install:
- JDK 17 (Eclipse Temurin)
- Gradle 8.3 (if needed)

## Setup

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/compose-desktop-chatbot.git
cd compose-desktop-chatbot
```

2. Run the setup script:
```powershell
.\setup-dev-env.ps1
```
This script will:
- Check for and install Java 17 if needed
- Configure JAVA_HOME and PATH
- Install Gradle 8.3 if needed
- Configure GRADLE_HOME and PATH

3. Create a `.env` file in the project root:
```
OPENAI_API_KEY=your_api_key_here
```

4. Replace `your_api_key_here` with your actual OpenAI API key

5. Restart your terminal for environment changes to take effect

## Running the Application

Run the application using the Gradle wrapper:

```powershell
.\gradlew run
```

## Building

To create a distribution:

```powershell
.\gradlew package
```

This will create platform-specific distributions in `build/compose/binaries`.

## Manual Setup

If you prefer to set up the environment manually:

1. Install JDK 17 or later from [Eclipse Temurin](https://adoptium.net/)
2. Install Gradle 8.3 from [gradle.org](https://gradle.org/install/)
3. Configure JAVA_HOME and GRADLE_HOME environment variables
4. Follow steps 3-4 from the Setup section above

## Tech Stack

- Kotlin
- Jetpack Compose Desktop
- OpenAI API
- Material Design 3
- Kotlin Coroutines
- Dotenv Kotlin

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Future Plans

While the application is currently focused on Windows, we plan to add support for other operating systems in future releases.
