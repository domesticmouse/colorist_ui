// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/chat_state.dart';
import '../models/message.dart';

part 'chat_state_notifier.g.dart';

/// A Riverpod provider that manages the state of a chat conversation.
/// This notifier allows adding user and LLM messages, clearing the chat,
/// appending to existing messages, and finalizing messages.
@riverpod
class ChatStateNotifier extends _$ChatStateNotifier {
  /// Initializes the chat state with an empty message list.
  @override
  ChatState build() => ChatState.initial();

  /// Adds a new user message to the chat and returns the newly added message.
  /// The [content] parameter is the text content of the user's message.
  Message addUserMessage(String content) {
    state = state.addUserMessage(content);
    return state.messages.last;
  }

  /// Adds a new LLM (Large Language Model) message to the chat and returns
  /// the newly added message. The [content] parameter is the text content of
  /// the LLM's message and the [messageState] parameter indicates the current
  /// state of the message (e.g., complete, streaming).
  Message addLlmMessage(String content, MessageState messageState) {
    state = state.addLlmMessage(content, messageState);
    return state.messages.last;
  }

  /// Clears all messages from the chat.
  void clearMessages() {
    state = state.clearMessages();
  }

  /// Appends additional content to an existing message in the chat.
  /// Takes the [id] of the message to append to, and the text to append as
  /// [addContent].
  void appendToMessage(String id, String addContent) {
    state = state.appendToMessage(id, addContent);
  }

  /// Finalizes a message in the chat, marking it as complete and trimming
  /// trailing whitespace. The call takes the [id] of the message to finalize.
  void finalizeMessage(String id) {
    state = state.finalizeMessage(id);
  }
}
