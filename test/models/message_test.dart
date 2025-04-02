// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorist_ui/models/message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Message', () {
    test('should create a valid Message instance', () {
      final now = DateTime.now();
      final message = Message(
        id: 'test-id',
        content: 'Hello world',
        role: MessageRole.user,
        updatedAt: now,
        state: MessageState.complete,
      );

      expect(message.id, 'test-id');
      expect(message.content, 'Hello world');
      expect(message.role, MessageRole.user);
      expect(message.updatedAt, now);
    });

    test('should create a user message with generated ID', () {
      final message = Message.userMessage('Hello from user');

      expect(message.id, isNotEmpty);
      expect(message.content, 'Hello from user');
      expect(message.role, MessageRole.user);
      expect(message.updatedAt, isNotNull);
    });

    test('should create an LLM message with generated ID', () {
      final message = Message.llmMessage(
        'Hello from LLM',
        MessageState.complete,
      );

      expect(message.id, isNotEmpty);
      expect(message.content, 'Hello from LLM');
      expect(message.role, MessageRole.llm);
      expect(message.updatedAt, isNotNull);
    });

    test('should update message content and timestamp', () {
      final originalTime = DateTime.now().subtract(const Duration(hours: 1));
      final originalMessage = Message(
        id: 'update-test',
        content: 'Initial content',
        role: MessageRole.user,
        updatedAt: originalTime,
        state: MessageState.streaming,
      );

      final updatedMessage = originalMessage.updateMessage(
        ' with appended text',
        MessageState.complete,
      );

      expect(updatedMessage.id, 'update-test');
      expect(originalMessage.content, 'Initial content');
      expect(updatedMessage.content, 'Initial content with appended text');
      expect(updatedMessage.role, MessageRole.user);
      expect(updatedMessage.updatedAt, isNot(equals(originalTime)));
      expect(updatedMessage.updatedAt.isAfter(originalTime), isTrue);
      expect(originalMessage.state, equals(MessageState.streaming));
      expect(updatedMessage.state, equals(MessageState.complete));
    });

    test('should serialize to JSON correctly', () {
      final now = DateTime.now();
      final message = Message(
        id: 'json-test',
        content: 'JSON test content',
        role: MessageRole.llm,
        updatedAt: now,
        state: MessageState.complete,
      );

      final json = message.toJson();

      expect(json['id'], 'json-test');
      expect(json['content'], 'JSON test content');
      expect(json['role'], 'llm');
      expect(json['updatedAt'], now.toIso8601String());
      expect(json['state'], 'complete');
    });

    test('should deserialize from JSON correctly', () {
      final now = DateTime.now();
      final json = {
        'id': 'json-test',
        'content': 'JSON test content',
        'role': 'llm',
        'updatedAt': now.toIso8601String(),
        'state': 'complete',
      };

      final message = Message.fromJson(json);

      expect(message.id, 'json-test');
      expect(message.content, 'JSON test content');
      expect(message.role, MessageRole.llm);
      expect(message.updatedAt.toIso8601String(), now.toIso8601String());
      expect(message.state, equals(MessageState.complete));
    });

    test('should implement copyWith correctly', () {
      final now = DateTime.now();
      final message = Message(
        id: 'copy-test',
        content: 'Original content',
        role: MessageRole.user,
        updatedAt: now,
        state: MessageState.complete,
      );

      final later = now.add(const Duration(minutes: 5));
      final copied = message.copyWith(
        content: 'Updated content',
        updatedAt: later,
      );

      expect(copied.id, 'copy-test');
      expect(copied.content, 'Updated content');
      expect(copied.role, MessageRole.user);
      expect(copied.updatedAt, later);
    });

    test('should test equality correctly', () {
      final now = DateTime.now();
      final message1 = Message(
        id: 'eq-test',
        content: 'Test content',
        role: MessageRole.user,
        updatedAt: now,
        state: MessageState.complete,
      );

      final message2 = Message(
        id: 'eq-test',
        content: 'Test content',
        role: MessageRole.user,
        updatedAt: now,
        state: MessageState.complete,
      );

      final message3 = Message(
        id: 'different-id',
        content: 'Test content',
        role: MessageRole.user,
        updatedAt: now,
        state: MessageState.complete,
      );

      expect(message1, equals(message2));
      expect(message1, isNot(equals(message3)));
      expect(message1.hashCode, equals(message2.hashCode));
      expect(message1.hashCode, isNot(equals(message3.hashCode)));
    });

    test('should generate unique IDs for factory constructors', () {
      final user1 = Message.userMessage('User message 1');
      final user2 = Message.userMessage('User message 2');
      final llm1 = Message.llmMessage('LLM message 1', MessageState.complete);
      final llm2 = Message.llmMessage('LLM message 2', MessageState.complete);

      expect(user1.id, isNot(equals(user2.id)));
      expect(llm1.id, isNot(equals(llm2.id)));
      expect(user1.id, isNot(equals(llm1.id)));
    });

    test('MessageRole enum should have the expected values', () {
      expect(MessageRole.values.length, 2);
      expect(MessageRole.user.name, 'user');
      expect(MessageRole.llm.name, 'llm');
    });
  });
}
