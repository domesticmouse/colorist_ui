// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/models/color_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorData', () {
    test('should create a valid ColorData instance', () {
      final colorData = ColorData(red: 0.5, green: 0.3, blue: 0.7);

      expect(colorData.red, 0.5);
      expect(colorData.green, 0.3);
      expect(colorData.blue, 0.7);
    });

    test(
      'should throw assertion error for RGB values outside 0.0-1.0 range',
      () {
        expect(
          () => ColorData(red: -0.1, green: 0.5, blue: 0.5),
          throwsA(isA<AssertionError>()),
        );

        expect(
          () => ColorData(red: 0.5, green: 1.1, blue: 0.5),
          throwsA(isA<AssertionError>()),
        );

        expect(
          () => ColorData(red: 0.5, green: 0.5, blue: 2.0),
          throwsA(isA<AssertionError>()),
        );
      },
    );

    test('should correctly generate hex code', () {
      final colorData = ColorData(red: 1.0, green: 0.0, blue: 0.5);

      expect(colorData.hexCode, '#ff0080');

      final colorData2 = ColorData(red: 0.0, green: 1.0, blue: 0.0);

      expect(colorData2.hexCode, '#00ff00');

      final colorData3 = ColorData(red: 0.2, green: 0.4, blue: 0.6);

      // 0.2 * 255 = 51 (33 in hex)
      // 0.4 * 255 = 102 (66 in hex)
      // 0.6 * 255 = 153 (99 in hex)
      expect(colorData3.hexCode, '#336699');
    });

    test('should correctly convert to Flutter Color', () {
      final colorData = ColorData(red: 0.6, green: 0.3, blue: 0.8);

      final color = colorData.color;
      expect(color, isA<Color>());
      expect(color.r, equals(0.6));
      expect(color.g, equals(0.3));
      expect(color.b, equals(0.8));
      expect(color.a, equals(1.0));
    });

    test(
      'should correctly create from Flutter Color using fromColor factory',
      () {
        // Create a Flutter Color
        final flutterColor = Color.fromRGBO(102, 153, 204, 1.0);

        // Create ColorData from the Flutter Color
        final colorData = ColorData.fromColor(flutterColor);

        // RGB values in Flutter Color are normalized between 0.0 and 1.0
        expect(colorData.red, equals(flutterColor.r));
        expect(colorData.green, equals(flutterColor.g));
        expect(colorData.blue, equals(flutterColor.b));
      },
    );

    test('should correctly generate LLM context map', () {
      final colorData = ColorData(red: 0.4, green: 0.5, blue: 0.6);

      final contextMap = colorData.toLLMContextMap();

      expect(contextMap, isA<Map<String, dynamic>>());
      expect(contextMap['red'], equals(0.4));
      expect(contextMap['green'], equals(0.5));
      expect(contextMap['blue'], equals(0.6));
      expect(contextMap['hexCode'], equals('#668099'));
    });

    test('should handle null values correctly in LLM context map', () {
      final colorData = ColorData(red: 0.1, green: 0.2, blue: 0.3);

      final contextMap = colorData.toLLMContextMap();

      expect(contextMap['name'], isNull);
      expect(contextMap['description'], isNull);
    });

    test('should correctly serialize to JSON', () {
      final colorData = ColorData(red: 0.1, green: 0.2, blue: 0.3);

      final json = colorData.toJson();

      expect(json['red'], 0.1);
      expect(json['green'], 0.2);
      expect(json['blue'], 0.3);
    });

    test('should correctly deserialize from JSON', () {
      final json = {
        'red': 0.1,
        'green': 0.2,
        'blue': 0.3,
        'name': 'Test Color',
        'description': 'A test color',
      };

      final colorData = ColorData.fromJson(json);

      expect(colorData.red, 0.1);
      expect(colorData.green, 0.2);
      expect(colorData.blue, 0.3);
    });

    test('should implement copyWith correctly', () {
      final colorData = ColorData(red: 0.1, green: 0.2, blue: 0.3);

      final copied = colorData.copyWith(red: 0.4);

      expect(copied.red, 0.4);
      expect(copied.green, 0.2);
      expect(copied.blue, 0.3);
    });

    test('should correctly implement equality', () {
      final color1 = ColorData(red: 0.1, green: 0.2, blue: 0.3);

      final color2 = ColorData(red: 0.1, green: 0.2, blue: 0.3);

      final color3 = ColorData(red: 0.4, green: 0.2, blue: 0.3);

      expect(color1, equals(color2));
      expect(color1, isNot(equals(color3)));

      expect(color1.hashCode, equals(color2.hashCode));
      expect(color1.hashCode, isNot(equals(color3.hashCode)));
    });
  });
}
