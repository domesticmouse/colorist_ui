// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import '../utils/utils.dart';
import '../widgets/log/log.dart';

/// A panel displaying an interaction log for the application.
///
/// This widget presents a log of application events, adapting its layout
/// based on the device type (phone or desktop).  It uses a [LogView] widget
/// to display the log entries and adjusts the title's alignment accordingly.
class LogPanel extends StatelessWidget {
  const LogPanel({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: switch (Device.of(context)) {
      DeviceType.phone => const EdgeInsets.all(12),
      DeviceType.desktop => const EdgeInsets.all(16),
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        Text(
          'Interaction log',
          style: TextTheme.of(context).titleLarge,
          textAlign: switch (Device.of(context)) {
            DeviceType.phone => TextAlign.center,
            DeviceType.desktop => TextAlign.start,
          },
        ),
        const Expanded(child: LogView()),
      ],
    ),
  );
}
