# Colorist UI

A Flutter UI library that enables exploring LLM tooling interfaces by allowing
users to describe colors in natural language.

## Project Overview

Colorist UI serves as a practical testbed for exploring how LLMs use tools.
This package is the base onto which a full LLM powered application can be built
with the following features:

- **Natural Language Color Input**: Describe colors using everyday language
- **Color Visualization**: A rectangle that updates to display the interpreted color
- **LLM Tool Integration**: Process natural language with specialized color tool calls
- **Color Information Display**: Technical details (RGB values, hex code) of the generated color
- **History Feature**: Last 10 colors generated as clickable thumbnails
- **Visual Logging**: Display raw streaming text from LLM with tool calls/responses
- **Context Management**: Update LLM context when user interacts with color history
- **Streaming State Visualization**: Visual indicators for streaming vs. complete messages

## Architecture

The is a library with an example implementation:

- **Core UI Library**: The base directory contains reusable UI components and models
- **Example Application**: Simple implementation that echoes user input

## Platform Support

The application is designed to work across platforms:

- **Desktop**: macOS, Windows, and Linux
- **Mobile**: iOS and Android
- **Web**: desktop and mobile layouts

## Technology Stack

- **Framework**: Flutter/Dart
- **State Management**: Riverpod with state held in various notifier providers
- **Data Modeling**: freezed for immutable data classes with pattern matching
- **Firebase Configuration**: FlutterFire CLI
- **Responsive Design**: Adaptive layouts for cross-platform support

## User Interface

The application features platform-optimized layouts:

### Desktop Layout (Split-Screen)

- **Left Side (Interaction Area)**:
  - Color display rectangle
  - RGB value and hex code labels
  - History strip of thumbnails for the last 10 colors
  - Chat interface with message streaming state indicators
  - Text input field for color descriptions
  - Submit button

- **Right Side (Log/Trace Area)**:
  - Real-time display of LLM interactions
  - Tool calls and responses visualization
  - Formatted log entries for debugging

### Mobile Layout (Tabbed)

- **Chat Tab**:
  - Color display rectangle (sized proportionally)
  - RGB value and hex code information
  - Horizontal scrolling history strip
  - Chat interface with message streaming state indicators
  - Text input optimized for mobile input

- **Log Tab**:
  - Full-screen scrollable log
  - Optimized typography for mobile reading

## Intended User Flows

### Primary Flow (Text Input)

1. User enters a color description (e.g., "the blue of a tropical ocean")
2. App sends description to LLM
3. LLM processes the description and returns tool calls to set the color
4. App updates the chat interface to show message as "streaming" with visual indicator
5. App displays content as it streams from the LLM in real-time
6. App updates the color rectangle with the new color as tools are called
7. Technical color information is updated
8. Raw LLM interaction is displayed in real-time
9. New color is added to the history thumbnails

### Alternative Flow (History Selection)

1. User clicks on a color thumbnail from the history strip
2. The selected color is displayed in the main color rectangle
3. RGB values are updated
4. LLM is informed of the manual color selection via context update
5. LLM acknowledges the selection and maintains this context

## Project Structure

```console
lib/
├── main.dart
├── models/
│   ├── chat_state.dart         # State management for chat messages
│   ├── color_data.dart         # Color representation with RGB values
│   ├── color_state.dart        # Color state with history tracking
│   ├── conversation_state.dart # Tracks if conversation is idle/busy
│   ├── log_entry.dart          # Entries for the interaction log
│   ├── log_state.dart          # State management for log entries
│   └── message.dart            # Chat message with streaming state
├── providers/
│   ├── chat_state_notifier.dart    # Provider for chat state
│   ├── color_state_notifier.dart   # Provider for color state
│   ├── log_state_notifier.dart     # Provider for log state
├── ui/
│   ├── layout/
│   │   ├── interaction_panel.dart  # Left panel with color and chat
│   │   └── log_panel.dart          # Right panel with log entries
│   ├── screens/
│   │   ├── desktop_main_screen.dart # Desktop-specific layout
│   │   ├── error_screen.dart        # Error handling screen
│   │   ├── loading_screen.dart      # Loading indicator screen
│   │   ├── main_screen.dart         # Main responsive screen
│   │   └── mobile_main_screen.dart  # Mobile-specific layout
│   ├── utils/
│   │   ├── device_type.dart           # Device type detection
│   │   └── scroll_controller_extension.dart # Scrolling utilities
│   └── widgets/
│       ├── chat/
│       │   ├── chat_input.dart       # Text input component
│       │   ├── message_bubble.dart   # Message display with state
│       │   └── messages_list.dart    # Scrollable message list
│       ├── color/
│       │   ├── color_display.dart    # Color rectangle display
│       │   ├── color_history.dart    # Thumbnail history strip
│       │   └── color_info.dart       # RGB and hex information
│       └── log/
│           ├── log_entry_widget.dart # Individual log entry
│           └── log_view.dart         # Scrollable log view
└── utils/

example/
└── lib/
    └── main.dart                     # Simple echo implementation
```

## Development Commands

- Format code: `dart format lib test`
- Generate code: `dart run build_runner build --delete-conflicting-outputs`
- Watch and generate: `dart run build_runner watch --delete-conflicting-outputs`
- Analyze code: `flutter analyze`
- Run tests: `flutter test`
- Run tests with coverage: `flutter test --coverage`
- Generate coverage report: `genhtml coverage/lcov.info -o coverage/html`
- View coverage: `open coverage/html/index.html`

## Quality Assurance Workflow

- Run `flutter analyze` after every code change to catch issues early
- Fix all analyzer warnings and errors before committing code
- Run `flutter test` to ensure all tests pass after making changes
- Run `dart format lib test` after tests pass to ensure consistent code
  formatting
- Ensure code generation is run after modifying `freezed` models and `riverpod`
  providers
