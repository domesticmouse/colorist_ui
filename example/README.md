# Colorist - Example usage

A usage example for the `colorist_ui` that demonstrates the basic architecture and UI components without requiring LLM integration. This example "echoes" user messages back, allowing you to test the UI functionality independently from any external API.

## Overview

The Echo Example serves as a basic usage example for the Colorist UI library.

## Features

- **Full UI Implementation**: Uses the UI components from the `colorist_ui` library
- **Simple Echo Logic**: Responds to user messages by echoing them back
- **No External Dependencies**: Doesn't require Firebase or any AI service setup
- **Responsive Design**: Supports both desktop and mobile layouts

## How It Works

This example implements a simple echo service instead of LLM integration:

1. User enters a message in the chat input
2. The message is sent to a simple handler function
3. The handler function returns the same message as a response
4. The UI updates to display both messages
5. Color display and history aren't used

## Running the Example

```bash
# Navigate to the example directory
cd example

# Get dependencies
flutter pub get

# Run the example
flutter run -d macos  # Or another device
```

## Code Overview

The main implementation is in `main.dart` and consists of:

```dart
void sendMessage(String message, WidgetRef ref) {
  final chatStateNotifier = ref.read(chatStateNotifierProvider.notifier);
  final logStateNotifier = ref.read(logStateNotifierProvider.notifier);

  chatStateNotifier.addUserMessage(message);
  logStateNotifier.logUserText(message);
  chatStateNotifier.addLlmMessage(message, MessageState.complete);
  logStateNotifier.logLlmText(message);
}
```

This simple function:
1. Adds the user's message to the chat
2. Logs the user's message
3. Adds the same message as an LLM response
4. Logs the response

## Dependencies

- Flutter
- Colorist UI library (local path dependency)
- `flutter_riverpod`
- `logging`

See `pubspec.yaml` for the full list of dependencies.
