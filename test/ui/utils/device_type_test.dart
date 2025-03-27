// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/ui/utils/device_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Device', () {
    testWidgets('returns phone for width <= 600', (tester) async {
      // Build a widget with a specific size
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(600, 800)),
          child: Builder(
            builder: (context) {
              // Capture the device type directly in the test
              final deviceType = Device.of(context);
              // Return a Text widget with the device type
              return MaterialApp(home: Text(deviceType.toString()));
            },
          ),
        ),
      );

      // Verify that Device.of() returned DeviceType.phone
      expect(find.text('DeviceType.phone'), findsOneWidget);
    });

    testWidgets('returns desktop for width > 600', (tester) async {
      // Build a widget with a specific size
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(601, 800)),
          child: Builder(
            builder: (context) {
              // Capture the device type directly in the test
              final deviceType = Device.of(context);
              // Return a Text widget with the device type
              return MaterialApp(home: Text(deviceType.toString()));
            },
          ),
        ),
      );

      // Verify that Device.of() returned DeviceType.desktop
      expect(find.text('DeviceType.desktop'), findsOneWidget);
    });

    testWidgets('returns desktop for large phone/tablet sizes', (tester) async {
      // Build a widget with a specific size
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(800, 1200)),
          child: Builder(
            builder: (context) {
              // Capture the device type directly in the test
              final deviceType = Device.of(context);
              // Return a Text widget with the device type
              return MaterialApp(home: Text(deviceType.toString()));
            },
          ),
        ),
      );

      // Verify that Device.of() returned DeviceType.desktop
      expect(find.text('DeviceType.desktop'), findsOneWidget);
    });
  });

  group('DeviceSizedBox', () {
    testWidgets('sets correct size for phone', (tester) async {
      // Build a widget with phone size
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(600, 800)),
          child: MaterialApp(
            home: Center(
              child: DeviceSizedBox(
                phoneWidth: 100,
                phoneHeight: 200,
                desktopWidth: 300,
                desktopHeight: 400,
              ),
            ),
          ),
        ),
      );

      // Find the SizedBox and verify its dimensions
      final SizedBox sizedBox = tester.widget(find.byType(SizedBox));
      expect(sizedBox.width, 100);
      expect(sizedBox.height, 200);
    });

    testWidgets('sets correct size for desktop', (tester) async {
      // Build a widget with desktop size
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(800, 1200)),
          child: MaterialApp(
            home: Center(
              child: DeviceSizedBox(
                phoneWidth: 100,
                phoneHeight: 200,
                desktopWidth: 300,
                desktopHeight: 400,
              ),
            ),
          ),
        ),
      );

      // Find the SizedBox and verify its dimensions
      final SizedBox sizedBox = tester.widget(find.byType(SizedBox));
      expect(sizedBox.width, 300);
      expect(sizedBox.height, 400);
    });

    testWidgets('handles null values correctly', (tester) async {
      // Build a widget with only some dimensions specified
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(600, 800)),
          child: MaterialApp(
            home: Center(
              child: DeviceSizedBox(phoneHeight: 200, desktopWidth: 300),
            ),
          ),
        ),
      );

      // Find the SizedBox and verify its dimensions
      final SizedBox sizedBox = tester.widget(find.byType(SizedBox));
      expect(sizedBox.width, null);
      expect(sizedBox.height, 200);
    });
  });
}
