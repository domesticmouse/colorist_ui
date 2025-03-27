// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/models/message.dart';
import 'package:colorist_ui/providers/chat_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatStateNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state has white color and empty messages/logs', () {
      final state = container.read(chatStateNotifierProvider);

      expect(state.messages, isEmpty);
    });

    group('Message Operations', () {
      test('addUserMessage adds message with correct role', () {
        final notifier = container.read(chatStateNotifierProvider.notifier);

        final message = notifier.addUserMessage('Hello');

        final state = container.read(chatStateNotifierProvider);
        expect(state.messages.length, equals(1));
        expect(state.messages.first.content, equals('Hello'));
        expect(state.messages.first.role, equals(MessageRole.user));
        expect(state.messages.first.state, equals(MessageState.complete));
        expect(message.id, equals(state.messages.first.id));
      });

      test('addLlmMessage adds message with correct role', () {
        final notifier = container.read(chatStateNotifierProvider.notifier);

        final message = notifier.addLlmMessage(
          'Hi there',
          MessageState.complete,
        );

        final state = container.read(chatStateNotifierProvider);
        expect(state.messages.length, equals(1));
        expect(state.messages.first.content, equals('Hi there'));
        expect(state.messages.first.role, equals(MessageRole.llm));
        expect(state.messages.first.state, equals(MessageState.complete));
        expect(message.id, equals(state.messages.first.id));
      });

      test('clearMessages removes all messages', () {
        final notifier = container.read(chatStateNotifierProvider.notifier);

        notifier.addUserMessage('Hello');
        notifier.addLlmMessage('Hi there', MessageState.complete);
        expect(
          container.read(chatStateNotifierProvider).messages.length,
          equals(2),
        );

        notifier.clearMessages();

        final state = container.read(chatStateNotifierProvider);
        expect(state.messages, isEmpty);
      });

      test('appendToMessage appends content to existing message', () {
        final notifier = container.read(chatStateNotifierProvider.notifier);

        final message = notifier.addLlmMessage(
          'Initial',
          MessageState.complete,
        );
        notifier.appendToMessage(message.id, ' Update');

        final state = container.read(chatStateNotifierProvider);
        expect(state.messages.length, equals(1));
        expect(state.messages.first.content, equals('Initial Update'));
      });

      test('appendToMessage does nothing for non-existent message id', () {
        final notifier = container.read(chatStateNotifierProvider.notifier);

        notifier.addLlmMessage('Initial', MessageState.complete);
        notifier.appendToMessage('non-existent-id', ' Update');

        final state = container.read(chatStateNotifierProvider);
        expect(state.messages.first.content, equals('Initial'));
      });

      test('multiple messages maintain order', () {
        final notifier = container.read(chatStateNotifierProvider.notifier);

        notifier.addUserMessage('First');
        notifier.addLlmMessage('Second', MessageState.complete);
        notifier.addUserMessage('Third');

        final state = container.read(chatStateNotifierProvider);
        expect(state.messages.length, equals(3));
        expect(state.messages[0].content, equals('First'));
        expect(state.messages[1].content, equals('Second'));
        expect(state.messages[2].content, equals('Third'));
      });
    });

    test('state updates are immutable', () {
      final notifier = container.read(chatStateNotifierProvider.notifier);
      final initialState = container.read(chatStateNotifierProvider);

      notifier.addUserMessage('Hello from UserLand!');

      final updatedState = container.read(chatStateNotifierProvider);
      expect(initialState, isNot(same(updatedState)));
      expect(initialState.messages, isNot(same(updatedState.messages)));
    });
  });

  test('setMessageState delegates to state method correctly', () {
    final container = ProviderContainer();
    final notifier = container.read(chatStateNotifierProvider.notifier);

    // Add a message in streaming state
    final streamingMessage = notifier.addLlmMessage(
      'Streaming message',
      MessageState.streaming,
    );

    // Initial state has message in streaming state
    expect(
      container.read(chatStateNotifierProvider).messages.first.state,
      equals(MessageState.streaming),
    );

    // Update the message state to complete
    notifier.finalizeMessage(streamingMessage.id);

    // Check that the state was updated correctly
    expect(
      container.read(chatStateNotifierProvider).messages.first.state,
      equals(MessageState.complete),
    );

    container.dispose();
  });
}
