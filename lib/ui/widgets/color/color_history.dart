// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/color_data.dart';
import '../../../providers/color_state_notifier.dart';
import '../../utils/utils.dart';

typedef ColorHistoryNotifyColorSelection = void Function(ColorData color);

/// Displays a horizontal scrollable list of previously selected colors.
///
/// This widget shows a history of colors selected by the user, providing
/// quick access to previously used colors. Each color is displayed as a
/// small, clickable thumbnail.  Tapping a thumbnail reselects that color
/// and notifies the Gemini chat service of the selection.
class ColorHistory extends ConsumerWidget {
  const ColorHistory({super.key, required this.notifyColorSelection});

  final ColorHistoryNotifyColorSelection notifyColorSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorHistory = ref.watch(
      colorStateNotifierProvider.select((state) => state.colorHistory),
    );

    final thumbnailSize = switch (Device.of(context)) {
      DeviceType.phone => 48.0,
      DeviceType.desktop => 40.0,
    };
    final containerHeight = switch (Device.of(context)) {
      DeviceType.phone => 60.0,
      DeviceType.desktop => 50.0,
    };

    if (colorHistory.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          'No color history yet',
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      );
    }

    return SizedBox(
      height: containerHeight,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final (index, color) in colorHistory.indexed)
                GestureDetector(
                  onTap: () {
                    ref
                        .read(colorStateNotifierProvider.notifier)
                        .selectColorFromHistory(index);

                    // Notify the LLM about the manual selection
                    notifyColorSelection(color);
                  },
                  child: Container(
                    width: thumbnailSize,
                    height: thumbnailSize,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: color.color,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(20),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
