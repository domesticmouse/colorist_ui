// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../models/log_entry.dart';

/// A widget that displays a single [LogEntry].
class LogEntryWidget extends StatelessWidget {
  const LogEntryWidget({required this.entry, super.key});

  final LogEntry entry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    // Determine style based on type and author.
    final backgroundColor = _getBackgroundColor(entry, colorScheme);
    final textColor = _getTextColor(entry, colorScheme);
    final prefix = _getPrefix(entry);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SelectableRegion(
        selectionControls: materialTextSelectionControls,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor.withAlpha(25),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: backgroundColor.withAlpha(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              // Header with timestamp and source
              Row(
                children: [
                  Text(
                    '${_formatTime(entry.timestamp)} - $prefix',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: textColor,
                    ),
                  ),
                ],
              ),
              // Content
              Text(
                entry.content,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'monospace',
                  color: textColor.withAlpha(230),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) =>
      '${time.hour.toString().padLeft(2, '0')}:'
      '${time.minute.toString().padLeft(2, '0')}:'
      '${time.second.toString().padLeft(2, '0')}';

  String _getPrefix(LogEntry entry) => switch (entry.author) {
    LogEntryRole.user => 'USER',
    LogEntryRole.llm => 'LLM',
    LogEntryRole.app => 'APP',
    LogEntryRole.tool => 'TOOL',
  };

  Color _getBackgroundColor(LogEntry entry, ColorScheme colorScheme) =>
      switch (entry.type) {
        LogEntryType.error => Colors.red,
        LogEntryType.warning => Colors.orange,
        LogEntryType.info => Colors.blue,
        LogEntryType.text => switch (entry.author) {
          LogEntryRole.user => colorScheme.primary,
          LogEntryRole.llm => colorScheme.tertiary,
          LogEntryRole.tool => Colors.green,
          _ => colorScheme.secondary,
        },
      };

  Color _getTextColor(LogEntry entry, ColorScheme colorScheme) =>
      switch (entry.type) {
        LogEntryType.error => Colors.red.shade800,
        LogEntryType.warning => Colors.orange.shade800,
        LogEntryType.info => Colors.blue.shade800,
        _ => colorScheme.onSurface,
      };
}
