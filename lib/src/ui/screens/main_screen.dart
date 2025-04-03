// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../layout/layouts.dart';
import '../utils/utils.dart';
import '../widgets/chat/chat.dart';
import '../widgets/color/color.dart';

/// The main screen of the application, adapting to different device types.
///
/// This widget acts as a responsive entry point for the main UI, dynamically
/// selecting either [_MobileMainScreen] for mobile devices or
/// [_DesktopMainScreen] for desktop devices.
class MainScreen extends StatelessWidget {
  const MainScreen({
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
    return SelectableRegion(
      selectionControls: materialTextSelectionControls,
      child: switch (Device.of(context)) {
        DeviceType.phone => _MobileMainScreen(
          conversationState: conversationState,
          notifyColorSelection: notifyColorSelection,
          sendMessage: sendMessage,
        ),
        DeviceType.desktop => _DesktopMainScreen(
          conversationState: conversationState,
          notifyColorSelection: notifyColorSelection,
          sendMessage: sendMessage,
        ),
      },
    );
  }
}

/// The main screen layout for desktop devices.
///
/// This widget arranges the [InteractionPanel] and [LogPanel] side-by-side
/// using a [Row] layout.  This provides a split-screen view, suitable for
/// larger displays, allowing users to interact with the color selection tools
/// and simultaneously monitor the application's interaction log.
class _DesktopMainScreen extends StatelessWidget {
  const _DesktopMainScreen({
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

/// The main screen layout for mobile devices.
///
/// This widget uses a [NavigationBar] at the bottom to switch between
/// the [InteractionPanel] and the [LogPanel].
class _MobileMainScreen extends StatefulWidget {
  const _MobileMainScreen({
    this.conversationState,
    this.notifyColorSelection,
    required this.sendMessage,
  });

  final ConversationState? conversationState;
  final ColorHistoryNotifyColorSelection? notifyColorSelection;
  final ChatInputSendMessage sendMessage;

  @override
  State<_MobileMainScreen> createState() => _MobileMainScreenState();
}

class _MobileMainScreenState extends State<_MobileMainScreen> {
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
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          NavigationDestination(icon: Icon(Icons.info_outline), label: 'Log'),
        ],
      ),
    );
  }
}
