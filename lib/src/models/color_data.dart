// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'color_data.freezed.dart';
part 'color_data.g.dart';

/// Represents color data using red, green, and blue components.
@freezed
abstract class ColorData with _$ColorData {
  const ColorData._();

  /// Creates a [ColorData] object from [red], [green], and [blue] values.
  /// Assertions ensure that red, green, and blue values are within the valid
  /// range `0.0` to `1.0`.
  @Assert('red >= 0.0 && red <= 1.0')
  @Assert('green >= 0.0 && green <= 1.0')
  @Assert('blue >= 0.0 && blue <= 1.0')
  const factory ColorData({
    required double red,
    required double green,
    required double blue,
  }) = _ColorData;

  /// Creates a [ColorData] object from [red], [green], and [blue] int values (0-255).
  ///
  /// This factory constructor normalizes the input values to the `0.0` to `1.0` range.
  factory ColorData.fromRGB({
    required int red,
    required int green,
    required int blue,
  }) => ColorData(
    red: red.toDouble() / 255,
    green: green.toDouble() / 255,
    blue: blue.toDouble() / 255,
  );

  /// Creates a [ColorData] object from a Flutter [Color] object.
  factory ColorData.fromColor(Color color) =>
      ColorData(red: color.r, green: color.g, blue: color.b);

  /// Creates a [ColorData] object from a JSON map.
  factory ColorData.fromJson(Map<String, Object?> json) =>
      _$ColorDataFromJson(json);

  /// Returns the hex code representation of the color (#RRGGBB).
  String get hexCode =>
      '#${(red * 255).round().toRadixString(16).padLeft(2, '0')}'
      '${(green * 255).round().toRadixString(16).padLeft(2, '0')}'
      '${(blue * 255).round().toRadixString(16).padLeft(2, '0')}';

  /// Returns a Flutter [Color] object representing this color data.
  Color get color => Color.from(alpha: 1.0, red: red, green: green, blue: blue);

  /// Returns a map suitable for use in LLM (Large Language Model) contexts.
  /// Includes red, green, blue components and the hex code.
  Map<String, Object?> toLLMContextMap() => {
    'red': red,
    'green': green,
    'blue': blue,
    'hexCode': hexCode,
  };
}
