// Copyright 2026 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/src/models/message.dart';
import 'package:colorist_ui/src/providers/chat_state_notifier.dart';
import 'package:colorist_ui/src/ui/widgets/chat/message_bubble.dart';
import 'package:colorist_ui/src/ui/widgets/chat/messages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MessagesList', () {
    testWidgets('renders empty prompt when there are no messages', (
      tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: MessagesList())),
        ),
      );

      expect(find.text('Describe a color to get started'), findsOneWidget);
      expect(find.byType(MessageBubble), findsNothing);
    });

    testWidgets('renders list of message bubbles when messages exist', (
      tester,
    ) async {
      late ProviderContainer container;

      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, ref, child) {
              container = ProviderScope.containerOf(context);
              return const MaterialApp(home: Scaffold(body: MessagesList()));
            },
          ),
        ),
      );

      final notifier = container.read(chatStateProvider.notifier);
      notifier.addUserMessage('sunset orange');
      notifier.addLlmMessage('Here is sunset orange.', MessageState.complete);
      await tester.pumpAndSettle();

      expect(find.text('Describe a color to get started'), findsNothing);
      expect(find.byType(MessageBubble), findsNWidgets(2));
      expect(find.text('sunset orange'), findsOneWidget);
      expect(find.text('Here is sunset orange.'), findsOneWidget);
    });
  });
}
