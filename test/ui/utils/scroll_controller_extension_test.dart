// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/ui/utils/scroll_controller_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ScrollControllerExtension', () {
    late ScrollController scrollController;

    setUp(() {
      scrollController = ScrollController();
    });

    tearDown(() {
      scrollController.dispose();
    });

    testWidgets('scrollToBottomAfterFrame does not throw when no clients', (
      tester,
    ) async {
      // Create a ScrollController without attaching it to any Scrollable
      final unattachedController = ScrollController();

      // Call the extension method (this should not throw)
      unattachedController.scrollToBottomAfterFrame();

      // Process the frame
      await tester.pump();

      // No assertion needed - we're just verifying it doesn't throw

      // Clean up
      unattachedController.dispose();
    });
  });
}
