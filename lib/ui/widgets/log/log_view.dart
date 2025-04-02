// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/log_entry.dart';
import '../../../providers/log_state_notifier.dart';
import '../../utils/utils.dart';
import 'log.dart';

/// A view that displays a scrollable list of log entries.  It automatically
/// scrolls to the bottom when new entries are added.
class LogView extends ConsumerStatefulWidget {
  const LogView({super.key});

  @override
  ConsumerState<LogView> createState() => _LogViewState();
}

class _LogViewState extends ConsumerState<LogView> {
  final _scrollController = ScrollController();
  List<LogEntry>? _previousLogEntries;

  @override
  void dispose() {
    _scrollController.dispose();
    _previousLogEntries = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logEntries = ref.watch(
      logStateNotifierProvider.select((state) => state.logEntries),
    );

    if (logEntries.isEmpty) {
      return const Center(
        child: Text(
          'No log entries yet',
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      );
    }

    if (_previousLogEntries != null && _previousLogEntries != logEntries) {
      _scrollController.scrollToBottomAfterFrame();
    }
    _previousLogEntries = logEntries;

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: logEntries.length,
      itemBuilder: (context, index) {
        return LogEntryWidget(entry: logEntries[index]);
      },
    );
  }
}
