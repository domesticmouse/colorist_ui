// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

import 'color_data.dart';

part 'color_state.freezed.dart';
part 'color_state.g.dart';

/// Maximum number of colors to keep in history.
const int _maxColorHistory = 10;

/// Represents the state of the color picker, including the current color
/// and color history.
@freezed
abstract class ColorState with _$ColorState {
  const ColorState._();

  /// Creates a [ColorState] object.
  ///
  /// This method takes the [currentColor] and a list of previously selected
  /// colors as [colorHistory].
  const factory ColorState({
    /// The currently selected color.
    required ColorData currentColor,

    /// A list of previously selected colors (maximum [_maxColorHistory] entries).
    required List<ColorData> colorHistory,
  }) = _ColorState;

  /// Creates an initial [ColorState] with
  /// white as the current color and an empty history.
  factory ColorState.initial() => const ColorState(
        currentColor: ColorData(red: 1.0, green: 1.0, blue: 1.0),
        colorHistory: [],
      );

  /// Adds the current color to the color history, limiting the history to
  /// [_maxColorHistory] entries. Returns a new [ColorState] with the updated
  /// color history.  If the current color is already in the history, the state
  /// remains unchanged.
  ColorState addCurrentColorToHistory() {
    if (colorHistory.contains(currentColor)) {
      return this;
    }
    final newHistory = [currentColor, ...colorHistory];
    final limitedHistory = newHistory.length > _maxColorHistory
        ? newHistory.sublist(0, _maxColorHistory)
        : newHistory;

    return copyWith(colorHistory: limitedHistory);
  }

  /// Selects a color from the color history.
  ///
  /// Takes the [index] of the color to select in the color history and returns
  /// a new [ColorState] with the selected color as the current color. If the
  /// index is out of bounds, the state remains unchanged. The current color
  /// is added to the history before selection.
  ColorState selectColorFromHistory(int index) {
    if (index < 0 || index >= colorHistory.length) {
      return this;
    }

    final withHistory = addCurrentColorToHistory();
    return withHistory.copyWith(currentColor: colorHistory[index]);
  }

  /// Updates the current color with new [red], [green], and [blue] values.
  ///
  /// All components must be in the range `0.0` to `1.0`.
  /// Returns a new [ColorState] with the updated current color.
  /// The current color is added to the history before the update.
  ColorState updateColor({
    required double red,
    required double green,
    required double blue,
  }) {
    final withHistory = addCurrentColorToHistory();
    return withHistory.copyWith(
      currentColor: ColorData(red: red, green: green, blue: blue),
    );
  }

  /// Creates a [ColorState] object from a JSON map.
  factory ColorState.fromJson(Map<String, Object?> json) =>
      _$ColorStateFromJson(json);
}
