// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../models/conversation_state.dart';
import '../layout/interaction_panel.dart';
import '../layout/log_panel.dart';
import '../widgets/chat/chat.dart';
import '../widgets/color/color.dart';

/// The main screen layout for desktop devices.
///
/// This widget arranges the [InteractionPanel] and [LogPanel] side-by-side
/// using a [Row] layout.  This provides a split-screen view, suitable for
/// larger displays, allowing users to interact with the color selection tools
/// and simultaneously monitor the application's interaction log.
class DesktopMainScreen extends StatelessWidget {
  const DesktopMainScreen({
    super.key,
    this.conversationState,
    this.notifyColorSelection,
    required this.sendMessage,
  });

  final ConversationState? conversationState;
  final ColorHistoryNotifyColorSelection? notifyColorSelection;
  final ChatInputSendMessage sendMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: InteractionPanel(
              conversationState: conversationState,
              notifyColorSelection: notifyColorSelection,
              sendMessage: sendMessage,
            ),
          ),
          const VerticalDivider(width: 1, thickness: 1),
          const Expanded(child: LogPanel()),
        ],
      ),
    );
  }
}
