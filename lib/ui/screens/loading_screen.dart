// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// Displays a loading indicator to the user.
///
/// This screen shows a circular progress indicator and a message while the
/// application is loading.
class LoadingScreen extends StatelessWidget {
  /// Creates a [LoadingScreen] widget that displays the [message] to the user
  /// while the application is loading.
  const LoadingScreen({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(message),
          ],
        ),
      ),
    );
  }
}
