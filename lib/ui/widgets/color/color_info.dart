// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/color_state_notifier.dart';

/// Displays the RGB values and hexadecimal code of the currently selected color.
class ColorInfo extends ConsumerWidget {
  const ColorInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentColor = ref.watch(
      colorStateNotifierProvider.select((state) => state.currentColor),
    );
    final red = (currentColor.red * 255).round();
    final green = (currentColor.green * 255).round();
    final blue = (currentColor.blue * 255).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ColorValueChip(label: 'R', value: red, color: Colors.red),
            SizedBox(width: 8),
            _ColorValueChip(label: 'G', value: green, color: Colors.green),
            SizedBox(width: 8),
            _ColorValueChip(label: 'B', value: blue, color: Colors.blue),
          ],
        ),
        Center(
          child: SelectableText(
            currentColor.hexCode,
            style: TextStyle(fontFamily: 'monospace', fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class _ColorValueChip extends StatelessWidget {
  const _ColorValueChip({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withAlpha(50),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withAlpha(128)),
    ),
    child: Text(
      '$label: $value',
      style: TextStyle(fontFamily: 'monospace', color: color.withAlpha(200)),
    ),
  );
}
