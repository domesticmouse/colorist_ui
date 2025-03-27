// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/color_state_notifier.dart';

/// Displays a colored box representing the currently selected color.
class ColorDisplay extends ConsumerWidget {
  const ColorDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorData = ref.watch(
      colorStateNotifierProvider.select((state) => state.currentColor),
    );

    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: colorData.color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
    );
  }
}
