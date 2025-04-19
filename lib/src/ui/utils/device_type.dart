// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// A type of device: phone or desktop.
enum DeviceType { phone, desktop }

/// Utility class for determining the device type based on screen width.
abstract final class Device {
  /// Returns the [DeviceType] based on the screen width of
  /// the provided [context].
  static DeviceType of(BuildContext context) {
    return switch (MediaQuery.sizeOf(context).width) {
      <= 600 => DeviceType.phone,
      _ => DeviceType.desktop,
    };
  }
}

/// A responsive SizedBox widget that adapts its size based on the device type.
class DeviceSizedBox extends StatelessWidget {
  /// Creates a [DeviceSizedBox] widget.
  const DeviceSizedBox({
    super.key,
    this.desktopHeight,
    this.desktopWidth,
    this.phoneHeight,
    this.phoneWidth,
  });

  /// The width of the SizedBox on phone devices.
  final double? phoneWidth;

  /// The height of the SizedBox on phone devices.
  final double? phoneHeight;

  /// The width of the SizedBox on desktop devices.
  final double? desktopWidth;

  /// The height of the SizedBox on desktop devices.
  final double? desktopHeight;

  @override
  Widget build(BuildContext context) {
    return switch (Device.of(context)) {
      DeviceType.phone => SizedBox(width: phoneWidth, height: phoneHeight),
      DeviceType.desktop => SizedBox(
          width: desktopWidth,
          height: desktopHeight,
        ),
    };
  }
}
