// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../models/conversation_state.dart';
import '../utils/utils.dart';
import '../widgets/chat/chat.dart';
import '../widgets/color/color.dart';
import 'desktop_main_screen.dart';
import 'mobile_main_screen.dart';

/// The main screen of the application, adapting to different device types.
///
/// This widget acts as a responsive entry point for the main UI, dynamically
/// selecting either [MobileMainScreen] for mobile devices or
/// [DesktopMainScreen] for desktop devices.
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
    return switch (Device.of(context)) {
      DeviceType.phone => MobileMainScreen(
        conversationState: conversationState,
        notifyColorSelection: notifyColorSelection,
        sendMessage: sendMessage,
      ),
      DeviceType.desktop => DesktopMainScreen(
        conversationState: conversationState,
        notifyColorSelection: notifyColorSelection,
        sendMessage: sendMessage,
      ),
    };
  }
}
