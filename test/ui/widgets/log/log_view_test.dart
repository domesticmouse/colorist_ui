// Copyright 2026 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/src/providers/log_state_notifier.dart';
import 'package:colorist_ui/src/ui/widgets/log/log_entry_widget.dart';
import 'package:colorist_ui/src/ui/widgets/log/log_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogView', () {
    testWidgets('renders empty prompt when log is empty', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: LogView())),
        ),
      );

      expect(find.text('No log entries yet'), findsOneWidget);
      expect(find.byType(LogEntryWidget), findsNothing);
    });

    testWidgets('renders log entries when present', (tester) async {
      late ProviderContainer container;

      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, ref, child) {
              container = ProviderScope.containerOf(context);
              return const MaterialApp(home: Scaffold(body: LogView()));
            },
          ),
        ),
      );

      final notifier = container.read(logStateProvider.notifier);
      notifier.logUserText('user prompt');
      notifier.logLlmText('llm response');
      await tester.pumpAndSettle();

      expect(find.text('No log entries yet'), findsNothing);
      expect(find.byType(LogEntryWidget), findsNWidgets(2));
      expect(find.text('user prompt'), findsOneWidget);
      expect(find.text('llm response'), findsOneWidget);
    });
  });
}
