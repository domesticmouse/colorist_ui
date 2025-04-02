// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// Displays an error message to the user.
///
/// This screen is shown when an error occurs during application initialization.
class ErrorScreen extends StatelessWidget {
  /// Creates an [ErrorScreen] widget with the [error] object to be displayed.
  const ErrorScreen({required this.error, super.key});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectableRegion(
        selectionControls: materialTextSelectionControls,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outlined, size: 48, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Error Initializing App',
                style: TextTheme.of(context).headlineMedium,
              ),
              SizedBox(height: 8),
              Text('$error'),
            ],
          ),
        ),
      ),
    );
  }
}
