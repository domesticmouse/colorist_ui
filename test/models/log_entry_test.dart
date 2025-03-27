// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:colorist_ui/models/log_entry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogEntry', () {
    test('should create a valid LogEntry instance', () {
      final now = DateTime.now();
      final logEntry = LogEntry(
        id: 'test-id',
        content: 'Test message',
        author: LogEntryRole.user,
        type: LogEntryType.text,
        timestamp: now,
      );

      expect(logEntry.id, 'test-id');
      expect(logEntry.content, 'Test message');
      expect(logEntry.author, LogEntryRole.user);
      expect(logEntry.type, LogEntryType.text);
      expect(logEntry.timestamp, now);
    });

    test('should create a user text log entry with factory constructor', () {
      final logEntry = LogEntry.userText('User message');

      expect(logEntry.id, isNotEmpty);
      expect(logEntry.content, 'User message');
      expect(logEntry.author, LogEntryRole.user);
      expect(logEntry.type, LogEntryType.text);
      expect(logEntry.timestamp, isNotNull);
    });

    test('should create an LLM text log entry with factory constructor', () {
      final logEntry = LogEntry.llmText('LLM message');

      expect(logEntry.id, isNotEmpty);
      expect(logEntry.content, 'LLM message');
      expect(logEntry.author, LogEntryRole.llm);
      expect(logEntry.type, LogEntryType.text);
      expect(logEntry.timestamp, isNotNull);
    });

    test('should create an error log entry with factory constructor', () {
      final error = Exception('Test error');
      final logEntry = LogEntry.error(error);

      expect(logEntry.id, isNotEmpty);
      expect(logEntry.content, contains('Exception'));
      expect(logEntry.content, contains('Test error'));
      expect(logEntry.author, LogEntryRole.app);
      expect(logEntry.type, LogEntryType.error);
      expect(logEntry.timestamp, isNotNull);
    });

    test('should create a warning log entry with factory constructor', () {
      final logEntry = LogEntry.warning('Warning message');

      expect(logEntry.id, isNotEmpty);
      expect(logEntry.content, 'Warning message');
      expect(logEntry.author, LogEntryRole.app);
      expect(logEntry.type, LogEntryType.warning);
      expect(logEntry.timestamp, isNotNull);
    });

    test('should create an info log entry with factory constructor', () {
      final logEntry = LogEntry.info('Info message');

      expect(logEntry.id, isNotEmpty);
      expect(logEntry.content, 'Info message');
      expect(logEntry.author, LogEntryRole.app);
      expect(logEntry.type, LogEntryType.info);
      expect(logEntry.timestamp, isNotNull);
    });

    test('should serialize to JSON correctly', () {
      final now = DateTime.now();
      final logEntry = LogEntry(
        id: 'json-test',
        content: 'JSON test content',
        author: LogEntryRole.user,
        type: LogEntryType.text,
        timestamp: now,
      );

      final json = logEntry.toJson();

      expect(json['id'], 'json-test');
      expect(json['content'], 'JSON test content');
      expect(json['author'], 'user');
      expect(json['type'], 'text');
      expect(json['timestamp'], now.toIso8601String());
    });

    test('should deserialize from JSON correctly', () {
      final now = DateTime.now();
      final json = {
        'id': 'json-test',
        'content': 'JSON test content',
        'author': 'llm',
        'type': 'warning',
        'timestamp': now.toIso8601String(),
      };

      final logEntry = LogEntry.fromJson(json);

      expect(logEntry.id, 'json-test');
      expect(logEntry.content, 'JSON test content');
      expect(logEntry.author, LogEntryRole.llm);
      expect(logEntry.type, LogEntryType.warning);
      expect(logEntry.timestamp.toIso8601String(), now.toIso8601String());
    });

    test('should implement copyWith correctly', () {
      final now = DateTime.now();
      final logEntry = LogEntry(
        id: 'copy-test',
        content: 'Original content',
        author: LogEntryRole.user,
        type: LogEntryType.text,
        timestamp: now,
      );

      final later = now.add(Duration(minutes: 5));
      final copied = logEntry.copyWith(
        content: 'Updated content',
        type: LogEntryType.warning,
        timestamp: later,
      );

      expect(copied.id, 'copy-test');
      expect(copied.content, 'Updated content');
      expect(copied.author, LogEntryRole.user);
      expect(copied.type, LogEntryType.warning);
      expect(copied.timestamp, later);
    });

    test('should test equality correctly', () {
      final now = DateTime.now();
      final logEntry1 = LogEntry(
        id: 'eq-test',
        content: 'Test content',
        author: LogEntryRole.user,
        type: LogEntryType.text,
        timestamp: now,
      );

      final logEntry2 = LogEntry(
        id: 'eq-test',
        content: 'Test content',
        author: LogEntryRole.user,
        type: LogEntryType.text,
        timestamp: now,
      );

      final logEntry3 = LogEntry(
        id: 'different-id',
        content: 'Test content',
        author: LogEntryRole.user,
        type: LogEntryType.text,
        timestamp: now,
      );

      expect(logEntry1, equals(logEntry2));
      expect(logEntry1, isNot(equals(logEntry3)));
      expect(logEntry1.hashCode, equals(logEntry2.hashCode));
      expect(logEntry1.hashCode, isNot(equals(logEntry3.hashCode)));
    });

    test('should generate unique IDs for factory constructors', () {
      final userText = LogEntry.userText('User message');
      final llmText = LogEntry.llmText('LLM message');
      final warning = LogEntry.warning('Warning message');
      final info = LogEntry.info('Info message');
      final error = LogEntry.error(Exception('Test exception'));

      final idSet = {userText.id, llmText.id, warning.id, info.id, error.id};
      expect(idSet.length, 5, reason: 'All IDs should be unique');
    });

    test('should clip content in userText when exceeding 50 characters', () {
      final longContent =
          'This is a very long string that should be clipped because it exceeds 50 characters';
      final logEntry = LogEntry.userText(longContent);

      expect(logEntry.content.endsWith('...'), isTrue);
      expect(logEntry.content.length < longContent.length, isTrue);
    });

    test('should clip content in llmText when exceeding 50 characters', () {
      final longContent =
          'This is a very long string that should be clipped because it exceeds 50 characters';
      final logEntry = LogEntry.llmText(longContent);

      expect(logEntry.content.endsWith('...'), isTrue);
      expect(logEntry.content.length < longContent.length, isTrue);
    });

    test(
      'should create a function call log entry with factory constructor',
      () {
        final functionName = 'set_color';
        final args = {'red': 0.5, 'green': 0.3, 'blue': 0.7};

        final logEntry = LogEntry.functionCall(functionName, args);

        expect(logEntry.id, isNotEmpty);
        expect(logEntry.content, contains('set_color'));
        expect(logEntry.content, contains(json.encode(args)));
        expect(logEntry.author, LogEntryRole.llm);
        expect(logEntry.type, LogEntryType.info);
        expect(logEntry.timestamp, isNotNull);
      },
    );

    test(
      'should create a function results log entry with factory constructor',
      () {
        final results = {'success': true, 'color': '#336699'};

        final logEntry = LogEntry.functionResults(results);

        expect(logEntry.id, isNotEmpty);
        expect(logEntry.content, contains('Result:'));
        expect(logEntry.content, contains(json.encode(results)));
        expect(logEntry.author, LogEntryRole.tool);
        expect(logEntry.type, LogEntryType.info);
        expect(logEntry.timestamp, isNotNull);
      },
    );
  });

  test('LogEntryType enum should have the expected values', () {
    expect(LogEntryType.values.length, 4);
    expect(LogEntryType.text.name, 'text');
    expect(LogEntryType.error.name, 'error');
    expect(LogEntryType.warning.name, 'warning');
    expect(LogEntryType.info.name, 'info');
  });
}
