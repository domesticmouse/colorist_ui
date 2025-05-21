// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../models/conversation_state.dart';
import '../../utils/utils.dart';

/// A callback function for sending messages in a chat interface.
typedef ChatInputSendMessage = void Function(String content);

/// A text input field for sending messages in a chat interface.
class ChatInput extends StatefulWidget {
  const ChatInput({
    super.key,
    required this.conversationState,
    required this.sendMessage,
  });

  /// The current state of the conversation.
  final ConversationState conversationState;

  /// A callback function for sending messages.
  final ChatInputSendMessage sendMessage;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isComposing = false;

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    if (widget.conversationState == ConversationState.busy) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please wait for the current response to complete'),
          duration: Duration(seconds: 2),
        ),
      );
      _focusNode.requestFocus();
      return;
    }

    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    if (text.trim().isEmpty) return;

    widget.sendMessage(text);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    }, debugLabel: 'Request focus on TextField');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final isProcessing = widget.conversationState == ConversationState.busy;

    return Container(
      margin: EdgeInsets.only(
        top: 8,
        bottom: switch (Device.of(context)) {
          DeviceType.phone => MediaQuery.paddingOf(context).bottom,
          DeviceType.desktop => 0,
        },
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outline.withAlpha(128)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: isProcessing
                    ? 'Waiting for response...'
                    : 'Describe a color...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: switch (Device.of(context)) {
                    DeviceType.phone => 14,
                    DeviceType.desktop => 12,
                  },
                ),
              ),
              textInputAction: TextInputAction.send,
              onChanged: (text) {
                setState(() {
                  _isComposing = text.trim().isNotEmpty;
                });
              },
              onSubmitted: _handleSubmitted,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            padding: EdgeInsets.all(switch (Device.of(context)) {
              DeviceType.phone => 12,
              DeviceType.desktop => 8,
            }),
            color: _isComposing && !isProcessing
                ? colorScheme.primary
                : colorScheme.outline.withAlpha(128),
            onPressed: _isComposing && !isProcessing
                ? () => _handleSubmitted(_textController.text)
                : null,
          ),
        ],
      ),
    );
  }
}
