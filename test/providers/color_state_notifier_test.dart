// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/models/color_data.dart';
import 'package:colorist_ui/providers/color_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorStateNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state has white color and empty messages/logs', () {
      final state = container.read(colorStateNotifierProvider);

      expect(state.currentColor.red, equals(1.0));
      expect(state.currentColor.green, equals(1.0));
      expect(state.currentColor.blue, equals(1.0));
      expect(state.colorHistory, isEmpty);
    });

    group('Color Operations', () {
      test('addCurrentColorToHistory adds current color to history', () {
        final notifier = container.read(colorStateNotifierProvider.notifier);
        final initialState = container.read(colorStateNotifierProvider);

        // Initial state is color is white, color history is empty.
        expect(initialState.currentColor.red, equals(1.0));
        expect(initialState.currentColor.green, equals(1.0));
        expect(initialState.currentColor.blue, equals(1.0));
        expect(initialState.colorHistory, isEmpty);

        // Change current color to red
        notifier.updateColor(red: 1.0, green: 0.0, blue: 0.0);

        // Updated state is current color is red, history is just white
        final updatedState = container.read(colorStateNotifierProvider);
        expect(updatedState.currentColor.red, equals(1.0));
        expect(updatedState.currentColor.green, equals(0.0));
        expect(updatedState.currentColor.blue, equals(0.0));
        expect(updatedState.colorHistory.length, equals(1));
        expect(updatedState.colorHistory.first.red, equals(1.0));
        expect(updatedState.colorHistory.first.green, equals(1.0));
        expect(updatedState.colorHistory.first.blue, equals(1.0));
      });

      test('addCurrentColorToHistory prevents duplicate entries', () {
        final notifier = container.read(colorStateNotifierProvider.notifier);

        // Change current color
        notifier.updateColor(red: 0.8, green: 0.2, blue: 0.3);

        // And again
        notifier.updateColor(red: 0.8, green: 0.2, blue: 0.3);

        // And again
        notifier.updateColor(red: 0.8, green: 0.2, blue: 0.3);

        final state = container.read(colorStateNotifierProvider);
        // History should be two colors, white, and whatever (0.8, 0.2, 0.3) is.
        expect(state.colorHistory.length, equals(2));
        expect(state.colorHistory.first.red, equals(0.8));
        expect(state.colorHistory.first.green, equals(0.2));
        expect(state.colorHistory.first.blue, equals(0.3));
        expect(state.colorHistory.last.red, equals(1.0));
        expect(state.colorHistory.last.green, equals(1.0));
        expect(state.colorHistory.last.blue, equals(1.0));
      });

      test('selectColorFromHistory updates current color', () {
        final notifier = container.read(colorStateNotifierProvider.notifier);

        // Add a red color to history
        notifier.updateColor(red: 1.0, green: 0.0, blue: 0.0);

        // Change current color to blue
        notifier.updateColor(red: 0.0, green: 0.0, blue: 1.0);

        // Change current color to green
        notifier.updateColor(red: 0.0, green: 1.0, blue: 0.0);

        // Select red color from history (index 1)
        notifier.selectColorFromHistory(1);

        final state = container.read(colorStateNotifierProvider);
        expect(state.currentColor.red, equals(1.0));
        expect(state.currentColor.green, equals(0.0));
        expect(state.currentColor.blue, equals(0.0));
      });

      test('selectColorFromHistory does nothing with invalid index', () {
        final notifier = container.read(colorStateNotifierProvider.notifier);

        // Add a color to history
        notifier.updateColor(red: 1.0, green: 0.0, blue: 0.0);

        // Change current color
        notifier.updateColor(red: 0.0, green: 0.0, blue: 1.0);

        // Try to select with invalid index
        notifier.selectColorFromHistory(99);

        final state = container.read(colorStateNotifierProvider);
        // Current color should remain unchanged
        expect(state.currentColor.red, equals(0.0));
        expect(state.currentColor.green, equals(0.0));
        expect(state.currentColor.blue, equals(1.0));
      });

      test(
        'updateColor updates current color and adds old color to history',
        () {
          final notifier = container.read(colorStateNotifierProvider.notifier);

          // Capture initial color (white)
          final initialState = container.read(colorStateNotifierProvider);
          final initialColor = initialState.currentColor;

          // Create a new color and set it
          final newColor = ColorData(red: 0.5, green: 0.7, blue: 0.9);

          notifier.updateColor(
            red: newColor.red,
            green: newColor.green,
            blue: newColor.blue,
          );

          final state = container.read(colorStateNotifierProvider);

          // Current color should be updated to new color
          expect(state.currentColor, equals(newColor));

          // Initial color should be in history
          expect(state.colorHistory.length, equals(1));
          expect(state.colorHistory.first, equals(initialColor));
        },
      );

      test('updateColor maintains history limit of 10 colors', () {
        final notifier = container.read(colorStateNotifierProvider.notifier);

        // Add 10 different colors using updateColor
        for (int i = 0; i < 11; i++) {
          final customColor = ColorData(red: i / 10, green: 0.5, blue: 1.0);

          notifier.updateColor(
            red: customColor.red,
            green: customColor.green,
            blue: customColor.blue,
          );
        }

        // Add an 11th color
        final customColor = ColorData(red: 0.25, green: 0.25, blue: 0.25);

        notifier.updateColor(
          red: customColor.red,
          green: customColor.green,
          blue: customColor.blue,
        );

        final state = container.read(colorStateNotifierProvider);

        // Should have 10 colors in history
        expect(state.colorHistory.length, equals(10));

        // Current color should be the last one we set
        expect(state.currentColor.red, equals(0.25));
        expect(state.currentColor.green, equals(0.25));
        expect(state.currentColor.blue, equals(0.25));

        // First history item should be the second-to-last color we set
        expect(state.colorHistory.first.red, equals(1.0)); // 9/10
        // Last history item should be the first color we set
        expect(state.colorHistory.last.red, equals(0.1)); // 9/10
      });
    });

    test('state updates are immutable', () {
      final notifier = container.read(colorStateNotifierProvider.notifier);
      final initialState = container.read(colorStateNotifierProvider);

      notifier.updateColor(red: 0.5, green: 0.5, blue: 0.5);

      final updatedState = container.read(colorStateNotifierProvider);
      expect(initialState, isNot(same(updatedState)));
      expect(initialState.currentColor, isNot(same(updatedState.currentColor)));
    });
  });
}
