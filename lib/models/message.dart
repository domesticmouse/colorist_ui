// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'message.freezed.dart';
part 'message.g.dart';

/// A UUID generator for creating unique message IDs.
final _uuid = const Uuid();

/// Represents the role of a message sender (user or LLM).
enum MessageRole { user, llm }

/// Represents the state of a message (complete or streaming).
enum MessageState { complete, streaming }

/// Represents a single message in a chat.
@freezed
abstract class Message with _$Message {
  /// Private constructor for internal use by Freezed.
  const Message._();

  /// Creates a new [Message] object.
  ///
  /// * [id]: A unique identifier for this message.
  /// * [content]: The text content of the message.
  /// * [role]: The role of the sender (user or llm).
  /// * [updatedAt]: The timestamp indicating the last update to the message.
  /// * [state]: The current state of the message (complete or streaming).
  const factory Message({
    required String id,
    required String content,
    required MessageRole role,
    required DateTime updatedAt,
    required MessageState state,
  }) = _Message;

  /// Creates a [Message] instance from a JSON map.
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  /// Creates a user message with the given [content].  The message is marked
  /// as complete.
  factory Message.userMessage(String content) => Message(
    id: _uuid.v4(),
    content: content,
    role: MessageRole.user,
    updatedAt: DateTime.now().toUtc(),
    state: MessageState.complete,
  );

  /// Creates an LLM message with the given [content] and [state].
  factory Message.llmMessage(String content, MessageState state) => Message(
    id: _uuid.v4(),
    content: content,
    role: MessageRole.llm,
    updatedAt: DateTime.now().toUtc(),
    state: state,
  );

  /// Updates an existing message with additional content and a new state.
  /// Takes the content to add as [addContent] and the new [state] of
  /// the message.
  Message updateMessage(String addContent, MessageState state) => copyWith(
    content: content + addContent,
    updatedAt: DateTime.now().toUtc(),
    state: state,
  );
}
