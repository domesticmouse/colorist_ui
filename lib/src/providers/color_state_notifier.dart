// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/color_data.dart';
import '../models/color_state.dart';

part 'color_state_notifier.g.dart';

/// A Riverpod provider that manages the state of the color picker.
/// This notifier allows selecting colors from the history and updating
/// the current color.
@riverpod
class ColorStateNotifier extends _$ColorStateNotifier {
  /// Initializes the color picker state with the initial color set to white
  /// and an empty history.
  @override
  ColorState build() => ColorState.initial();

  /// Selects a color from the color history and updates the current color.
  /// Selects the color at [index] in the color history. If the index is out of
  /// bounds, the state remains unchanged. The currently selected color is
  /// added to the history before the selection.
  void selectColorFromHistory(int index) {
    state = state.selectColorFromHistory(index);
  }

  /// Updates the current color with new [red], [green], and [blue] values.
  /// The parameters must be in the range `0.0` to `1.0`.  The current color is
  /// added to the history before the update. Returns the updated [ColorData]
  /// object.
  ColorData updateColor({
    required double red,
    required double green,
    required double blue,
  }) {
    state = state.updateColor(red: red, green: green, blue: blue);
    return state.currentColor;
  }

  /// Reset state.
  void reset() {
    state = ColorState.initial();
  }
}
