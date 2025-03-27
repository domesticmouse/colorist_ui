// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/models/chat_state.dart';
import 'package:colorist_ui/models/message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatState', () {
    group('Initialization', () {
      test('initial() creates a valid state with default values', () {
        final state = ChatState.initial();

        expect(state.messages, isEmpty);
      });

      test('constructor creates a state with provided values', () {
        final message = Message.userMessage('Hello');

        final state = ChatState(messages: [message]);

        expect(state.messages.length, equals(1));
        expect(state.messages.first, equals(message));
      });
    });

    group('Message handling', () {
      test('addMessage adds a message to empty messages list', () {
        final state = ChatState.initial();
        final updatedState = state.addUserMessage('Hello');

        expect(updatedState.messages.length, equals(1));
        expect(updatedState.messages.first.content, equals('Hello'));
      });

      test('addMessage adds a message to non-empty messages list', () {
        final state = ChatState.initial().addUserMessage('First message');
        final updatedState = state.addLlmMessage(
          'Second message',
          MessageState.complete,
        );

        expect(updatedState.messages.length, equals(2));
        expect(updatedState.messages.first.content, equals('First message'));
        expect(updatedState.messages.last.content, equals('Second message'));
      });

      test('appendToMessage appends content to existing message', () {
        final state = ChatState.initial().addUserMessage('Hello');
        final message = state.messages.last;
        final appendText = ', World!';
        final updatedState = state.appendToMessage(message.id, appendText);

        expect(updatedState.messages.length, equals(1));
        expect(updatedState.messages.first.content, equals('Hello, World!'));
      });

      test(
        'appendToMessage appends to specific message when multiple exist',
        () {
          final firstMessage = 'First';
          final secondMessage = 'Second';
          final thirdMessage = 'Third';

          final state = ChatState.initial()
              .addUserMessage(firstMessage)
              .addLlmMessage(secondMessage, MessageState.complete)
              .addUserMessage(thirdMessage);

          final message = state.messages[1];

          final updatedState = state.appendToMessage(message.id, ' updated');

          expect(updatedState.messages.length, equals(3));
          expect(updatedState.messages[0].content, equals('First'));
          expect(updatedState.messages[1].content, equals('Second updated'));
          expect(updatedState.messages[2].content, equals('Third'));
        },
      );

      test('clearMessages removes all messages', () {
        final state = ChatState.initial()
            .addUserMessage('First message')
            .addLlmMessage('Second message', MessageState.complete)
            .addUserMessage('Third message');

        expect(state.messages.length, equals(3));

        final updatedState = state.clearMessages();

        expect(updatedState.messages, isEmpty);
      });

      test('clearMessages maintains an empty list when already empty', () {
        final state = ChatState.initial();
        expect(state.messages, isEmpty);

        final updatedState = state.clearMessages();

        expect(updatedState.messages, isEmpty);
      });
    });

    group('JSON serialization', () {
      test('toJson/fromJson roundtrip preserves data', () {
        final initialState = ChatState(
          messages: [
            Message(
              id: 'msg1',
              content: 'Hello',
              role: MessageRole.user,
              updatedAt: DateTime.utc(2023, 5, 10, 10, 15),
              state: MessageState.complete,
            ),
            Message(
              id: 'msg2',
              content: 'Hi there',
              role: MessageRole.llm,
              updatedAt: DateTime.utc(2023, 5, 10, 10, 16),
              state: MessageState.complete,
            ),
          ],
        );

        final json = initialState.toJson();
        final deserializedState = ChatState.fromJson(json);

        expect(
          deserializedState.messages.length,
          equals(initialState.messages.length),
        );
        expect(
          deserializedState.messages[0].id,
          equals(initialState.messages[0].id),
        );
        expect(
          deserializedState.messages[0].content,
          equals(initialState.messages[0].content),
        );
        expect(
          deserializedState.messages[0].role,
          equals(initialState.messages[0].role),
        );
      });
    });
  });

  group('setMessageState', () {
    test('updates message state correctly', () {
      final initialState = ChatState.initial();

      // Add a message in streaming state
      final stateWithMessage = initialState.addLlmMessage(
        'Initial message',
        MessageState.streaming,
      );

      final messageId = stateWithMessage.messages.first.id;

      // Change the message state to complete
      final updatedState = stateWithMessage.finalizeMessage(messageId);

      expect(updatedState.messages.length, equals(1));
      expect(updatedState.messages.first.content, equals('Initial message'));
      expect(updatedState.messages.first.state, equals(MessageState.complete));
    });

    test('does nothing for non-existent message id', () {
      final initialState = ChatState.initial();

      // Add a message
      final stateWithMessage = initialState.addLlmMessage(
        'Initial message',
        MessageState.streaming,
      );

      // Try to update a non-existent message
      final updatedState = stateWithMessage.finalizeMessage('non-existent-id');

      // State should remain unchanged
      expect(updatedState, equals(stateWithMessage));
      expect(updatedState.messages.first.state, equals(MessageState.streaming));
    });
  });
}
