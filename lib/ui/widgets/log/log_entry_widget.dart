// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../models/log_entry.dart';

/// A widget that displays a single [LogEntry].
class LogEntryWidget extends StatelessWidget {
  final LogEntry entry;

  const LogEntryWidget({required this.entry, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine style based on type and author
    final Color backgroundColor = _getBackgroundColor(entry, theme);
    final Color textColor = _getTextColor(entry, theme);
    final String prefix = _getPrefix(entry);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SelectableRegion(
        selectionControls: materialTextSelectionControls,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor.withAlpha(25),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: backgroundColor.withAlpha(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: 4),
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

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
  }

  String _getPrefix(LogEntry entry) {
    switch (entry.author) {
      case LogEntryRole.user:
        return 'USER';
      case LogEntryRole.llm:
        return 'LLM';
      case LogEntryRole.app:
        return 'APP';
      case LogEntryRole.tool:
        return 'TOOL';
    }
  }

  Color _getBackgroundColor(LogEntry entry, ThemeData theme) {
    switch (entry.type) {
      case LogEntryType.error:
        return Colors.red;
      case LogEntryType.warning:
        return Colors.orange;
      case LogEntryType.info:
        return Colors.blue;
      case LogEntryType.text:
        switch (entry.author) {
          case LogEntryRole.user:
            return theme.colorScheme.primary;
          case LogEntryRole.llm:
            return theme.colorScheme.tertiary;
          case LogEntryRole.tool:
            return Colors.green;
          default:
            return theme.colorScheme.secondary;
        }
    }
  }

  Color _getTextColor(LogEntry entry, ThemeData theme) {
    switch (entry.type) {
      case LogEntryType.error:
        return Colors.red.shade800;
      case LogEntryType.warning:
        return Colors.orange.shade800;
      case LogEntryType.info:
        return Colors.blue.shade800;
      default:
        return theme.colorScheme.onSurface;
    }
  }
}
