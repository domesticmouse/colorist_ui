// Copyright 2026 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/src/models/conversation_state.dart';
import 'package:colorist_ui/src/ui/widgets/chat/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatInput', () {
    testWidgets('renders input field with default hint', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatInput(
              conversationState: ConversationState.idle,
              sendMessage: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Describe a color...'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.send), findsOneWidget);
    });

    testWidgets('sends message and clears field on button press', (
      tester,
    ) async {
      String? sentMessage;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatInput(
              conversationState: ConversationState.idle,
              sendMessage: (msg) {
                sentMessage = msg;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'sky blue');
      await tester.pump();

      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      expect(sentMessage, equals('sky blue'));
      // Field should be cleared
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, isEmpty);
    });

    testWidgets('sends message and clears field on keyboard submit', (
      tester,
    ) async {
      String? sentMessage;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatInput(
              conversationState: ConversationState.idle,
              sendMessage: (msg) {
                sentMessage = msg;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'forest green');
      await tester.testTextInput.receiveAction(TextInputAction.send);
      await tester.pump();

      expect(sentMessage, equals('forest green'));
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, isEmpty);
    });

    testWidgets('shows warning snackbar when conversationState is busy', (
      tester,
    ) async {
      String? sentMessage;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatInput(
              conversationState: ConversationState.busy,
              sendMessage: (msg) {
                sentMessage = msg;
              },
            ),
          ),
        ),
      );

      expect(find.text('Waiting for response...'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'crimson red');
      await tester.testTextInput.receiveAction(TextInputAction.send);
      await tester.pump();

      expect(sentMessage, isNull);
      expect(
        find.text('Please wait for the current response to complete'),
        findsOneWidget,
      );
    });
  });
}
