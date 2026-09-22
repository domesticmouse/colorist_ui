// Copyright 2026 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/src/providers/color_state_notifier.dart';
import 'package:colorist_ui/src/ui/widgets/color/color_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorInfo', () {
    testWidgets('renders RGB chips and hex code for initial color', (
      tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: ColorInfo())),
        ),
      );

      // Initial color is white: R: 255, G: 255, B: 255, #ffffff
      expect(find.text('R: 255'), findsOneWidget);
      expect(find.text('G: 255'), findsOneWidget);
      expect(find.text('B: 255'), findsOneWidget);
      expect(find.text('#ffffff'), findsOneWidget);
    });

    testWidgets('updates RGB chips and hex code when color changes', (
      tester,
    ) async {
      late ProviderContainer container;

      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, ref, child) {
              container = ProviderScope.containerOf(context);
              return const MaterialApp(home: Scaffold(body: ColorInfo()));
            },
          ),
        ),
      );

      // Change to Red (1.0, 0.0, 0.0)
      container
          .read(colorStateProvider.notifier)
          .updateColor(red: 1.0, green: 0.0, blue: 0.0);
      await tester.pump();

      expect(find.text('R: 255'), findsOneWidget);
      expect(find.text('G: 0'), findsOneWidget);
      expect(find.text('B: 0'), findsOneWidget);
      expect(find.text('#ff0000'), findsOneWidget);
    });
  });
}
