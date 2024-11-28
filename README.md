# Compose Desktop Chatbot

A modern desktop chatbot application built with Kotlin and Jetpack Compose Desktop, powered by OpenAI's GPT-3.5 model.

## Features

- Clean and intuitive chat interface
- Real-time conversation with GPT-3.5
- Modern Material Design 3 UI
- Cross-platform desktop support

## Prerequisites

- JDK 17 or later
- OpenAI API key
- Gradle (optional, as the project includes a Gradle wrapper)

## Setup

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/compose-desktop-chatbot.git
cd compose-desktop-chatbot
```

2. Create a `.env` file in the project root:
```
OPENAI_API_KEY=your_api_key_here
```

3. Replace `your_api_key_here` with your actual OpenAI API key

### Gradle Setup Options

You have two options to build and run the project:

#### Option 1: Using the Gradle Wrapper (Recommended)
The project includes a Gradle Wrapper (`gradlew` for Unix-like systems and `gradlew.bat` for Windows), which automatically downloads and uses the correct Gradle version. This is the recommended approach as it ensures compatibility.

#### Option 2: Using Local Gradle Installation
If you prefer to use your own Gradle installation:
- For Windows users: You can run `setup-gradle.ps1` script to install Gradle locally
- For other users: Install Gradle manually from [gradle.org](https://gradle.org/install/)

## Running the Application

Run the application using Gradle:

```bash
./gradlew run
```

## Building

To create a distribution:

```bash
./gradlew package
```

This will create platform-specific distributions in `build/compose/binaries`.

## Tech Stack

- Kotlin
- Jetpack Compose Desktop
- OpenAI API
- Material Design 3
- Kotlin Coroutines
- Dotenv Kotlin

## License

This project is licensed under the MIT License - see the LICENSE file for details.
