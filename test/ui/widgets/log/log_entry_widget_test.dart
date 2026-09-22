// Copyright 2026 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/src/models/log_entry.dart';
import 'package:colorist_ui/src/ui/widgets/log/log_entry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogEntryWidget', () {
    testWidgets('renders user log entry with prefix and content', (
      tester,
    ) async {
      final entry = LogEntry(
        id: '1',
        content: 'hello log',
        author: LogEntryRole.user,
        type: LogEntryType.text,
        timestamp: DateTime(2026, 1, 1, 14, 30, 45),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: LogEntryWidget(entry: entry)),
        ),
      );

      expect(find.text('14:30:45 - USER'), findsOneWidget);
      expect(find.text('hello log'), findsOneWidget);
    });

    testWidgets('renders LLM log entry with LLM prefix', (tester) async {
      final entry = LogEntry(
        id: '2',
        content: 'llm response text',
        author: LogEntryRole.llm,
        type: LogEntryType.text,
        timestamp: DateTime(2026, 1, 1, 14, 31, 0),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: LogEntryWidget(entry: entry)),
        ),
      );

      expect(find.text('14:31:00 - LLM'), findsOneWidget);
      expect(find.text('llm response text'), findsOneWidget);
    });

    testWidgets(
      'renders error and warning entries with corresponding prefixes',
      (tester) async {
        final errorEntry = LogEntry(
          id: '3',
          content: 'Something went wrong',
          author: LogEntryRole.app,
          type: LogEntryType.error,
          timestamp: DateTime(2026, 1, 1, 14, 32, 10),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: LogEntryWidget(entry: errorEntry)),
          ),
        );

        expect(find.text('14:32:10 - APP'), findsOneWidget);
        expect(find.text('Something went wrong'), findsOneWidget);
      },
    );

    testWidgets('renders tool log entry with TOOL prefix', (tester) async {
      final toolEntry = LogEntry(
        id: '4',
        content: 'Result: {"success": true}',
        author: LogEntryRole.tool,
        type: LogEntryType.info,
        timestamp: DateTime(2026, 1, 1, 14, 33, 15),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: LogEntryWidget(entry: toolEntry)),
        ),
      );

      expect(find.text('14:33:15 - TOOL'), findsOneWidget);
      expect(find.text('Result: {"success": true}'), findsOneWidget);
    });
  });
}
