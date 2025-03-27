// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/models/color_data.dart';
import 'package:colorist_ui/models/color_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorState', () {
    group('Initialization', () {
      test('initial() creates a valid state with default values', () {
        final state = ColorState.initial();

        expect(state.currentColor.red, equals(1.0));
        expect(state.currentColor.green, equals(1.0));
        expect(state.currentColor.blue, equals(1.0));
        expect(state.colorHistory.length, equals(0));
      });

      test('constructor creates a state with provided values', () {
        final colorData = ColorData(red: 0.5, green: 0.3, blue: 0.7);

        final state = ColorState(currentColor: colorData, colorHistory: []);

        expect(state.currentColor, equals(colorData));
        expect(state.colorHistory.length, equals(0));
      });
    });

    group('JSON serialization', () {
      test('toJson/fromJson roundtrip preserves data', () {
        final initialState = ColorState(
          currentColor: ColorData(red: 0.2, green: 0.4, blue: 0.8),
          colorHistory: [
            ColorData(red: 0.1, green: 0.2, blue: 0.3),
            ColorData(red: 0.4, green: 0.5, blue: 0.6),
            ColorData(red: 0.7, green: 0.8, blue: 0.9),
          ],
        );

        final json = initialState.toJson();
        final deserializedState = ColorState.fromJson(json);

        expect(
          deserializedState.currentColor.red,
          equals(initialState.currentColor.red),
        );
        expect(
          deserializedState.currentColor.green,
          equals(initialState.currentColor.green),
        );
        expect(
          deserializedState.currentColor.blue,
          equals(initialState.currentColor.blue),
        );
        expect(
          deserializedState.colorHistory,
          equals(initialState.colorHistory),
        );
      });
    });
  });

  group('ColorState Color History', () {
    test('initial state has empty color history', () {
      final state = ColorState.initial();
      expect(state.colorHistory, isEmpty);
    });

    test('addCurrentColorToHistory adds the current color to history', () {
      final initialState = ColorState.initial();

      // Set current color to something other than white
      final redColor = ColorData(red: 1.0, green: 0.0, blue: 0.0);

      final stateWithColor = initialState.copyWith(currentColor: redColor);
      final stateWithHistory = stateWithColor.addCurrentColorToHistory();

      expect(stateWithHistory.colorHistory.length, equals(1));
      expect(stateWithHistory.colorHistory.first, equals(redColor));
    });

    test('addCurrentColorToHistory prevents duplicate colors', () {
      final initialState = ColorState.initial();

      // Set current color
      final redColor = ColorData(red: 1.0, green: 0.0, blue: 0.0);

      final stateWithColor = initialState.copyWith(currentColor: redColor);
      final stateWithHistory = stateWithColor.addCurrentColorToHistory();

      // Try to add the same color again
      final stateWithDuplicateAttempt =
          stateWithHistory.addCurrentColorToHistory();

      expect(stateWithDuplicateAttempt.colorHistory.length, equals(1));
    });

    test('addCurrentColorToHistory limits history to 10 items', () {
      var state = ColorState.initial();

      // Add 10 different colors to history
      for (int i = 0; i < 11; i++) {
        final customColor = ColorData(red: i / 10, green: 0.5, blue: 1.0);

        state = state.copyWith(currentColor: customColor);
        state = state.addCurrentColorToHistory();
      }

      // Add an 11th color
      final customColor = ColorData(red: 0.25, green: 0.25, blue: 0.25);

      state = state.copyWith(currentColor: customColor);
      state = state.addCurrentColorToHistory();

      // Should keep only the 10 most recent colors
      expect(state.colorHistory.length, equals(10));

      // The most recent color should be at index 0
      expect(state.colorHistory.first.red, equals(0.25));
      expect(state.colorHistory.first.green, equals(0.25));
      expect(state.colorHistory.first.blue, equals(0.25));

      // The second added color should be at the last index
      expect(state.colorHistory.last.red, equals(0.2));
      expect(state.colorHistory.last.green, equals(0.5));
      expect(state.colorHistory.last.blue, equals(1.0));
    });

    test('selectColorFromHistory updates current color', () {
      var state = ColorState.initial();

      // Add several colors to history
      final colors = [
        ColorData(red: 1.0, green: 0.0, blue: 0.0), // Red
        ColorData(red: 0.0, green: 1.0, blue: 0.0), // Green
        ColorData(red: 0.0, green: 0.0, blue: 1.0), // Blue
      ];

      for (final color in colors) {
        state = state.copyWith(currentColor: color);
        state = state.addCurrentColorToHistory();
      }

      // Select green (index 1)
      state = state.selectColorFromHistory(1);

      expect(state.currentColor.red, equals(0.0));
      expect(state.currentColor.green, equals(1.0));
      expect(state.currentColor.blue, equals(0.0));
    });

    test('selectColorFromHistory does nothing for invalid index', () {
      var state = ColorState.initial();

      // Add a color to history
      final redColor = ColorData(red: 1.0, green: 0.0, blue: 0.0);

      state = state.copyWith(currentColor: redColor);
      state = state.addCurrentColorToHistory();

      // Set current color to something else
      final blueColor = ColorData(red: 0.0, green: 0.0, blue: 1.0);
      state = state.copyWith(currentColor: blueColor);

      // Try to select with invalid indices
      final stateWithNegativeIndex = state.selectColorFromHistory(-1);
      final stateWithTooLargeIndex = state.selectColorFromHistory(10);

      // State should remain unchanged
      expect(stateWithNegativeIndex.currentColor, equals(blueColor));
      expect(stateWithTooLargeIndex.currentColor, equals(blueColor));
    });

    test('updateColor adds current color to history and updates current', () {
      final initialState = ColorState.initial();

      // Initial color is white
      final whiteColor = initialState.currentColor;

      // Set new color to red
      final redColor = ColorData(red: 1.0, green: 0.0, blue: 0.0);
      final updatedState = initialState.updateColor(
        red: redColor.red,
        green: redColor.green,
        blue: redColor.blue,
      );

      // Current color should be red
      expect(updatedState.currentColor.red, equals(1.0));
      expect(updatedState.currentColor.green, equals(0.0));
      expect(updatedState.currentColor.blue, equals(0.0));

      // White should be in history
      expect(updatedState.colorHistory.length, equals(1));
      expect(updatedState.colorHistory.first, equals(whiteColor));

      // Now update to blue
      final blueColor = ColorData(red: 0.0, green: 0.0, blue: 1.0);
      final finalState = updatedState.updateColor(
        red: blueColor.red,
        green: blueColor.green,
        blue: blueColor.blue,
      );

      // Current color should be blue
      expect(finalState.currentColor, equals(blueColor));

      // History should contain red, then white
      expect(finalState.colorHistory.length, equals(2));
      expect(finalState.colorHistory[0], equals(redColor));
      expect(finalState.colorHistory[1], equals(whiteColor));
    });
  });
}
