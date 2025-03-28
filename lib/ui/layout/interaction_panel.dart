// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../models/conversation_state.dart';
import '../utils/utils.dart';
import '../widgets/chat/chat.dart';
import '../widgets/color/color.dart';

final _log = Logger('InteractionPanel');

/// A panel displaying interaction elements for a color selection application.
///
/// This widget arranges a [ColorDisplay], [ColorInfo], [ColorHistory],
/// a chat message list ([MessagesList]), and a chat input field ([ChatInput])
/// in a column.  The layout adapts to different screen sizes (phone vs. desktop)
/// using the [Device] utility.
class InteractionPanel extends StatelessWidget {
  const InteractionPanel({
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
    final padding = switch (Device.of(context)) {
      DeviceType.phone => EdgeInsets.all(12.0),
      DeviceType.desktop => EdgeInsets.all(16.0),
    };

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          switch (Device.of(context)) {
            DeviceType.phone => Center(child: ColorDisplay()),
            DeviceType.desktop => ColorDisplay(),
          },

          DeviceSizedBox(phoneHeight: 12, desktopHeight: 16),
          ColorInfo(),
          DeviceSizedBox(phoneHeight: 12, desktopHeight: 16),
          ColorHistory(
            notifyColorSelection:
                notifyColorSelection ??
                (color) {
                  _log.info(
                    'User selected color from history: '
                    '${json.encode(color.toLLMContextMap())}',
                  );
                },
          ),

          // Chat section
          Expanded(child: MessagesList()),

          // Input section
          ChatInput(
            conversationState: conversationState ?? ConversationState.idle,
            sendMessage: sendMessage,
          ),
        ],
      ),
    );
  }
}
