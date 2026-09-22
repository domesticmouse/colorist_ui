// Copyright 2026 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/src/models/color_data.dart';
import 'package:colorist_ui/src/providers/color_state_notifier.dart';
import 'package:colorist_ui/src/ui/widgets/color/color_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorDisplay', () {
    testWidgets('renders container with current color from provider', (
      tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: ColorDisplay())),
        ),
      );

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;

      // Initial color in ColorState.initial() is white (1.0, 1.0, 1.0)
      expect(
        decoration.color,
        equals(const Color.from(alpha: 1.0, red: 1.0, green: 1.0, blue: 1.0)),
      );
    });

    testWidgets('updates when color state changes', (tester) async {
      late ProviderContainer container;

      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, ref, child) {
              container = ProviderScope.containerOf(context);
              return const MaterialApp(home: Scaffold(body: ColorDisplay()));
            },
          ),
        ),
      );

      // Update color through notifier
      container
          .read(colorStateProvider.notifier)
          .updateColor(red: 0.2, green: 0.4, blue: 0.6);
      await tester.pump();

      final containerWidget = tester.widget<Container>(find.byType(Container));
      final decoration = containerWidget.decoration as BoxDecoration;

      final expectedColor = const ColorData(
        red: 0.2,
        green: 0.4,
        blue: 0.6,
      ).color;
      expect(decoration.color, equals(expectedColor));
    });
  });
}
