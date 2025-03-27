// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/message.dart';
import '../../../providers/chat_state_notifier.dart';
import '../../utils/utils.dart';
import 'chat.dart';

/// A scrollable list displaying chat messages.
///
/// The list of messages is animated to the bottom (the newest message) whenever
/// the message list changes. This is done to keep the messages coming from the
/// LLM in frame as they stream in. If no messages are present, it displays a
/// prompt encouraging the user to start a conversation.
class MessagesList extends ConsumerStatefulWidget {
  const MessagesList({super.key});

  @override
  ConsumerState<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends ConsumerState<MessagesList> {
  final _scrollController = ScrollController();
  List<Message>? _previousMessages;

  @override
  void dispose() {
    _scrollController.dispose();
    _previousMessages = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(
      chatStateNotifierProvider.select((state) => state.messages),
    );

    if (messages.isEmpty) {
      return Center(
        child: Text(
          'Describe a color to get started',
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      );
    }

    if (_previousMessages != null && _previousMessages != messages) {
      _scrollController.scrollToBottomAfterFrame();
    }
    _previousMessages = messages;

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(vertical: 16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return MessageBubble(message: messages[index]);
      },
    );
  }
}
