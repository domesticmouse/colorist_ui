// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:colorist_ui/src/models/log_entry.dart';
import 'package:colorist_ui/src/models/log_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogState', () {
    group('Initialization', () {
      test('initial() creates a valid state with default values', () {
        final state = LogState.initial();

        expect(state.logEntries, isEmpty);
      });

      test('constructor creates a state with provided values', () {
        final logEntry = LogEntry.userText('User input');

        final state = LogState(logEntries: [logEntry]);

        expect(state.logEntries.length, equals(1));
        expect(state.logEntries.first, equals(logEntry));
      });
    });

    group('Log entry handling', () {
      test('logUserText adds a log entry to empty logEntries list', () {
        final state = LogState.initial();
        final updatedState = state.logUserText('User text');

        expect(updatedState.logEntries.length, equals(1));
        expect(updatedState.logEntries.first.content, equals('User text'));
        expect(updatedState.logEntries.first.type, equals(LogEntryType.text));
        expect(updatedState.logEntries.first.author, equals(LogEntryRole.user));
      });

      test('logLlmText adds a log entry to non-empty logEntries list', () {
        final state = LogState.initial().logUserText('First entry');
        final updatedState = state.logLlmText('Second entry');

        expect(updatedState.logEntries.length, equals(2));
        expect(updatedState.logEntries.first.content, equals('First entry'));
        expect(updatedState.logEntries.first.author, equals(LogEntryRole.user));
        expect(updatedState.logEntries.first.type, equals(LogEntryType.text));
        expect(updatedState.logEntries.last.content, equals('Second entry'));
        expect(updatedState.logEntries.last.author, equals(LogEntryRole.llm));
        expect(updatedState.logEntries.last.type, equals(LogEntryType.text));
      });

      test('logUserText preserves existing state', () {
        final initialState = const LogState(logEntries: []);

        final updatedState = initialState.logUserText('User text');

        expect(updatedState.logEntries.length, equals(1));
        expect(updatedState.logEntries.first.content, equals('User text'));
      });

      test('logError adds an error log entry', () {
        final state = LogState.initial();
        final error = Exception('Something went wrong');
        final updatedState = state.logError(error);

        expect(updatedState.logEntries.length, equals(1));
        expect(updatedState.logEntries.first.content, equals(error.toString()));
        expect(updatedState.logEntries.first.type, equals(LogEntryType.error));
        expect(updatedState.logEntries.first.author, equals(LogEntryRole.app));
      });

      test('logWarning adds a warning log entry', () {
        final state = LogState.initial();
        final warning = 'This is a warning message';
        final updatedState = state.logWarning(warning);

        expect(updatedState.logEntries.length, equals(1));
        expect(updatedState.logEntries.first.content, equals(warning));
        expect(
          updatedState.logEntries.first.type,
          equals(LogEntryType.warning),
        );
        expect(updatedState.logEntries.first.author, equals(LogEntryRole.app));
      });

      test('logInfo adds an info log entry', () {
        final state = LogState.initial();
        final info = 'This is an info message';
        final updatedState = state.logInfo(info);

        expect(updatedState.logEntries.length, equals(1));
        expect(updatedState.logEntries.first.content, equals(info));
        expect(updatedState.logEntries.first.type, equals(LogEntryType.info));
        expect(updatedState.logEntries.first.author, equals(LogEntryRole.app));
      });

      test('logFunctionCall adds a function call log entry', () {
        final state = LogState.initial();
        final functionName = 'set_color';
        final args = {'red': 0.5, 'green': 0.3, 'blue': 0.7};

        final updatedState = state.logFunctionCall(functionName, args);

        expect(updatedState.logEntries.length, equals(1));
        expect(updatedState.logEntries.first.content, contains(functionName));
        expect(
          updatedState.logEntries.first.content,
          contains(json.encode(args)),
        );
        expect(updatedState.logEntries.first.author, equals(LogEntryRole.llm));
        expect(updatedState.logEntries.first.type, equals(LogEntryType.info));
      });

      test('logFunctionResults adds a function results log entry', () {
        final state = LogState.initial();
        final results = {'success': true, 'color': '#336699'};

        final updatedState = state.logFunctionResults(results);

        expect(updatedState.logEntries.length, equals(1));
        expect(updatedState.logEntries.first.content, contains('Result:'));
        expect(
          updatedState.logEntries.first.content,
          contains(json.encode(results)),
        );
        expect(updatedState.logEntries.first.author, equals(LogEntryRole.tool));
        expect(updatedState.logEntries.first.type, equals(LogEntryType.info));
      });

      test('multiple log entries maintain correct order', () {
        final state = LogState.initial();

        final updatedState = state
            .logUserText('User text')
            .logError(Exception('Error message'))
            .logWarning('Warning message')
            .logInfo('Info message')
            .logLlmText('LLM text');

        expect(updatedState.logEntries.length, equals(5));

        expect(updatedState.logEntries[0].type, equals(LogEntryType.text));
        expect(updatedState.logEntries[0].author, equals(LogEntryRole.user));

        expect(updatedState.logEntries[1].type, equals(LogEntryType.error));
        expect(updatedState.logEntries[1].author, equals(LogEntryRole.app));

        expect(updatedState.logEntries[2].type, equals(LogEntryType.warning));
        expect(updatedState.logEntries[2].author, equals(LogEntryRole.app));

        expect(updatedState.logEntries[3].type, equals(LogEntryType.info));
        expect(updatedState.logEntries[3].author, equals(LogEntryRole.app));

        expect(updatedState.logEntries[4].type, equals(LogEntryType.text));
        expect(updatedState.logEntries[4].author, equals(LogEntryRole.llm));
      });
    });

    group('JSON serialization', () {
      test('toJson/fromJson roundtrip preserves data', () {
        final initialState = LogState(
          logEntries: [
            LogEntry(
              id: 'log1',
              content: 'User input',
              author: LogEntryRole.user,
              type: LogEntryType.text,
              timestamp: DateTime.utc(2023, 5, 10, 10, 15),
            ),
          ],
        );

        final json = initialState.toJson();
        final deserializedState = LogState.fromJson(json);

        expect(
          deserializedState.logEntries.length,
          equals(initialState.logEntries.length),
        );
        expect(
          deserializedState.logEntries[0].id,
          equals(initialState.logEntries[0].id),
        );
        expect(
          deserializedState.logEntries[0].content,
          equals(initialState.logEntries[0].content),
        );
        expect(
          deserializedState.logEntries[0].author,
          equals(initialState.logEntries[0].author),
        );
        expect(
          deserializedState.logEntries[0].type,
          equals(initialState.logEntries[0].type),
        );
      });
    });
  });
}
