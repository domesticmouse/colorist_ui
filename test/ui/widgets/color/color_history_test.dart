// Copyright 2026 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/src/models/color_data.dart';
import 'package:colorist_ui/src/providers/color_state_notifier.dart';
import 'package:colorist_ui/src/ui/widgets/color/color_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorHistory', () {
    testWidgets('renders empty placeholder when history is empty', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: ColorHistory(notifyColorSelection: (_) {})),
          ),
        ),
      );

      expect(find.text('No color history yet'), findsOneWidget);
    });

    testWidgets('renders thumbnails and triggers selection on tap', (
      tester,
    ) async {
      late ProviderContainer container;
      ColorData? selectedColor;

      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, ref, child) {
              container = ProviderScope.containerOf(context);
              return MaterialApp(
                home: Scaffold(
                  body: ColorHistory(
                    notifyColorSelection: (color) {
                      selectedColor = color;
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );

      // Add a couple colors so history is populated
      final notifier = container.read(colorStateProvider.notifier);
      notifier.updateColor(
        red: 1.0,
        green: 0.0,
        blue: 0.0,
      ); // Adds white to history
      notifier.updateColor(
        red: 0.0,
        green: 1.0,
        blue: 0.0,
      ); // Adds red to history
      await tester.pump();

      // "No color history yet" should now be gone
      expect(find.text('No color history yet'), findsNothing);

      // History should have 2 thumbnails (red and white)
      final gestureFinders = find.byType(GestureDetector);
      expect(gestureFinders, findsNWidgets(2));

      // Tap the first thumbnail (red)
      await tester.tap(gestureFinders.first);
      await tester.pump();

      expect(selectedColor, isNotNull);
      expect(selectedColor!.red, equals(1.0));
      expect(selectedColor!.green, equals(0.0));
      expect(selectedColor!.blue, equals(0.0));

      // Current color should now be updated to red
      final state = container.read(colorStateProvider);
      expect(state.currentColor.red, equals(1.0));
      expect(state.currentColor.green, equals(0.0));
      expect(state.currentColor.blue, equals(0.0));
    });
  });
}
