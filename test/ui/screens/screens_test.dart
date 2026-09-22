// Copyright 2026 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/src/ui/screens/error_screen.dart';
import 'package:colorist_ui/src/ui/screens/loading_screen.dart';
import 'package:colorist_ui/src/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Screens', () {
    testWidgets('LoadingScreen renders progress indicator and message', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoadingScreen(message: 'Initializing LLM...')),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Initializing LLM...'), findsOneWidget);
    });

    testWidgets('ErrorScreen renders error title and error content', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ErrorScreen(error: 'Failed to connect to host'),
        ),
      );

      expect(find.byIcon(Icons.error_outlined), findsOneWidget);
      expect(find.text('Error initializing app'), findsOneWidget);
      expect(find.text('Failed to connect to host'), findsOneWidget);
    });

    testWidgets(
      'MainScreen renders mobile layout with NavigationBar for <= 600px width',
      (tester) async {
        await tester.pumpWidget(
          MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: ProviderScope(
              child: MaterialApp(home: MainScreen(sendMessage: (_) {})),
            ),
          ),
        );

        expect(find.byType(NavigationBar), findsOneWidget);
        expect(find.text('Chat'), findsOneWidget);
        expect(find.text('Log'), findsOneWidget);
        expect(find.byType(VerticalDivider), findsNothing);
      },
    );

    testWidgets('MainScreen renders desktop split layout for > 600px width', (
      tester,
    ) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(1000, 800)),
          child: ProviderScope(
            child: MaterialApp(home: MainScreen(sendMessage: (_) {})),
          ),
        ),
      );

      expect(find.byType(NavigationBar), findsNothing);
      expect(find.byType(VerticalDivider), findsOneWidget);
      expect(find.text('Interaction log'), findsOneWidget);
    });
  });
}
