// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/src/models/message.dart';
import 'package:colorist_ui/src/ui/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MessageBubble', () {
    testWidgets('should render user message correctly', (tester) async {
      final message = Message(
        id: '1',
        role: MessageRole.user,
        content: 'Hello',
        updatedAt: DateTime.now(),
        state: MessageState.complete,
      );

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: MessageBubble(message: message))),
      );

      expect(find.text('Hello'), findsOneWidget);
      expect(find.byType(MarkdownBody), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should render LLM message correctly', (tester) async {
      final message = Message(
        id: '2',
        role: MessageRole.llm,
        content: 'Hello there',
        updatedAt: DateTime.now(),
        state: MessageState.complete,
      );

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: MessageBubble(message: message))),
      );

      expect(find.text('Hello there'), findsOneWidget);
      expect(find.byType(MarkdownBody), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should render streaming message with indicator', (
      tester,
    ) async {
      final message = Message(
        id: '3',
        role: MessageRole.llm,
        content: 'Processing...',
        updatedAt: DateTime.now(),
        state: MessageState.streaming,
      );

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: MessageBubble(message: message))),
      );

      expect(find.text('Processing...'), findsOneWidget);
      expect(find.text('Thinking...'), findsOneWidget);
      expect(find.byType(MarkdownBody), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should render markdown formatting correctly', (tester) async {
      final markdownContent = '''
# Heading
**Bold text**
*Italic text*
- List item 1
- List item 2
''';

      final message = Message(
        id: '4',
        role: MessageRole.llm,
        content: markdownContent,
        updatedAt: DateTime.now(),
        state: MessageState.complete,
      );

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: MessageBubble(message: message))),
      );

      expect(find.byType(MarkdownBody), findsOneWidget);

      // Note: We don't test for rendered markdown elements directly
      // as they're handled by flutter_markdown internally
      final markdownWidget = tester.widget<MarkdownBody>(
        find.byType(MarkdownBody),
      );
      expect(markdownWidget.data, equals(markdownContent));
    });
  });
}
