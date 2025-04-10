// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../models/models.dart';
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
    return Padding(
      padding: switch (Device.of(context)) {
        DeviceType.phone => const EdgeInsets.all(12),
        DeviceType.desktop => const EdgeInsets.all(16),
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          switch (Device.of(context)) {
            DeviceType.phone => const Center(child: ColorDisplay()),
            DeviceType.desktop => const ColorDisplay(),
          },

          const DeviceSizedBox(phoneHeight: 12, desktopHeight: 16),
          const ColorInfo(),
          const DeviceSizedBox(phoneHeight: 12, desktopHeight: 16),
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
          const Expanded(child: MessagesList()),

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
