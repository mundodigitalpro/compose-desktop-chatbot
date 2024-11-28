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
