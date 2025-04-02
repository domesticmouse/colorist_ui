// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../models/conversation_state.dart';
import '../layout/interaction_panel.dart';
import '../layout/log_panel.dart';
import '../widgets/chat/chat.dart';
import '../widgets/color/color.dart';

/// The main screen layout for mobile devices.
///
/// This widget uses a [NavigationBar] at the bottom to switch between
/// the [InteractionPanel] and the [LogPanel].
class MobileMainScreen extends StatefulWidget {
  const MobileMainScreen({
    super.key,
    this.conversationState,
    this.notifyColorSelection,
    required this.sendMessage,
  });

  final ConversationState? conversationState;
  final ColorHistoryNotifyColorSelection? notifyColorSelection;
  final ChatInputSendMessage sendMessage;

  @override
  State<MobileMainScreen> createState() => _MobileMainScreenState();
}

class _MobileMainScreenState extends State<MobileMainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          SafeArea(
            child: InteractionPanel(
              conversationState: widget.conversationState,
              notifyColorSelection: widget.notifyColorSelection,
              sendMessage: widget.sendMessage,
            ),
          ),
          const SafeArea(child: LogPanel()),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          const NavigationDestination(icon: Icon(Icons.info_outline), label: 'Log'),
        ],
      ),
    );
  }
}
