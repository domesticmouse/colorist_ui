// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

import 'message.dart';

part 'chat_state.freezed.dart';
part 'chat_state.g.dart';

/// Represents the state of a chat, as the list of messages.
@freezed
abstract class ChatState with _$ChatState {
  /// Private constructor for internal use.
  const ChatState._();

  /// Creates a new [ChatState] with the given list of messages.
  const factory ChatState({required List<Message> messages}) = _ChatState;

  /// Creates an initial [ChatState] with an empty list of messages.
  factory ChatState.initial() => ChatState(messages: []);

  /// Adds a new user message to the chat, with [content] being the text.
  ChatState addUserMessage(String content) =>
      copyWith(messages: [...messages, Message.userMessage(content)]);

  /// Adds a new LLM (Language Model) message to the chat, with [content] as
  /// the text of the LLM's message, and [state] the current state of the
  /// message.
  ChatState addLlmMessage(String content, MessageState state) =>
      copyWith(messages: [...messages, Message.llmMessage(content, state)]);

  /// Appends additional content, as [addContent], to an existing
  /// message identified by [id]. If no message with the given [id]
  /// is found, the current [ChatState] is returned unchanged.
  ChatState appendToMessage(String id, String addContent) {
    final splitIndex = messages.indexWhere((message) => message.id == id);
    if (splitIndex == -1) {
      return this;
    }
    final before = messages.sublist(0, splitIndex);
    final message = messages[splitIndex];
    final updatedMessage = message.copyWith(
      content: message.content + addContent,
    );
    final after = messages.sublist(splitIndex + 1);
    return copyWith(messages: [...before, updatedMessage, ...after]);
  }

  /// Finalizes a message in the chat, identified by [id], marking it as
  /// complete. If no message with the given [id] is found, the current
  /// [ChatState] is returned unchanged.
  ChatState finalizeMessage(String id) {
    final splitIndex = messages.indexWhere((message) => message.id == id);
    if (splitIndex == -1) {
      return this;
    }
    final before = messages.sublist(0, splitIndex);
    final message = messages[splitIndex];
    final updatedMessage = message.copyWith(
      state: MessageState.complete,
      content: message.content.trimRight(),
    );
    final after = messages.sublist(splitIndex + 1);
    return copyWith(messages: [...before, updatedMessage, ...after]);
  }

  /// Clears all messages from the chat.
  ChatState clearMessages() => copyWith(messages: []);

  /// Creates a [ChatState] instance from a JSON map.
  factory ChatState.fromJson(Map<String, dynamic> json) =>
      _$ChatStateFromJson(json);
}
