// Copyright 2025 Brett Morgan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:colorist_ui/src/models/log_entry.dart';
import 'package:colorist_ui/src/providers/log_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogStateNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state has white color and empty messages/logs', () {
      final state = container.read(logStateNotifierProvider);

      expect(state.logEntries, isEmpty);
    });

    group('Logging Operations', () {
      test('logUserText adds user text entry', () {
        final notifier = container.read(logStateNotifierProvider.notifier);

        notifier.logUserText('User input');

        final state = container.read(logStateNotifierProvider);
        expect(state.logEntries.length, equals(1));
        expect(state.logEntries.first.content, equals('User input'));
        expect(state.logEntries.first.author, equals(LogEntryRole.user));
        expect(state.logEntries.first.type, equals(LogEntryType.text));
      });

      test('logLlmText adds LLM text entry', () {
        final notifier = container.read(logStateNotifierProvider.notifier);

        notifier.logLlmText('LLM response');

        final state = container.read(logStateNotifierProvider);
        expect(state.logEntries.length, equals(1));
        expect(state.logEntries.first.content, equals('LLM response'));
        expect(state.logEntries.first.author, equals(LogEntryRole.llm));
        expect(state.logEntries.first.type, equals(LogEntryType.text));
      });

      test('logError adds error entry', () {
        final notifier = container.read(logStateNotifierProvider.notifier);
        final exception = Exception('Test error');

        notifier.logError(exception);

        final state = container.read(logStateNotifierProvider);
        expect(state.logEntries.length, equals(1));
        expect(state.logEntries.first.content, equals('Exception: Test error'));
        expect(state.logEntries.first.author, equals(LogEntryRole.app));
        expect(state.logEntries.first.type, equals(LogEntryType.error));
      });

      test('logWarning adds warning entry', () {
        final notifier = container.read(logStateNotifierProvider.notifier);

        notifier.logWarning('Warning message');

        final state = container.read(logStateNotifierProvider);
        expect(state.logEntries.length, equals(1));
        expect(state.logEntries.first.content, equals('Warning message'));
        expect(state.logEntries.first.author, equals(LogEntryRole.app));
        expect(state.logEntries.first.type, equals(LogEntryType.warning));
      });

      test('logInfo adds info entry', () {
        final notifier = container.read(logStateNotifierProvider.notifier);

        notifier.logInfo('Info message');

        final state = container.read(logStateNotifierProvider);
        expect(state.logEntries.length, equals(1));
        expect(state.logEntries.first.content, equals('Info message'));
        expect(state.logEntries.first.author, equals(LogEntryRole.app));
        expect(state.logEntries.first.type, equals(LogEntryType.info));
      });

      test('logFunctionCall adds a function call log entry', () {
        final notifier = container.read(logStateNotifierProvider.notifier);
        final functionName = 'set_color';
        final args = {'red': 0.5, 'green': 0.3, 'blue': 0.7};

        notifier.logFunctionCall(functionName, args);

        final state = container.read(logStateNotifierProvider);
        expect(state.logEntries.length, equals(1));
        expect(state.logEntries.first.content, contains(functionName));
        expect(state.logEntries.first.content, contains(json.encode(args)));
        expect(state.logEntries.first.author, equals(LogEntryRole.llm));
        expect(state.logEntries.first.type, equals(LogEntryType.info));
      });

      test('logFunctionResults adds a function results log entry', () {
        final notifier = container.read(logStateNotifierProvider.notifier);
        final results = {'success': true, 'color': '#336699'};

        notifier.logFunctionResults(results);

        final state = container.read(logStateNotifierProvider);
        expect(state.logEntries.length, equals(1));
        expect(state.logEntries.first.content, contains('Result:'));
        expect(state.logEntries.first.content, contains(json.encode(results)));
        expect(state.logEntries.first.author, equals(LogEntryRole.tool));
        expect(state.logEntries.first.type, equals(LogEntryType.info));
      });

      test('multiple log entries maintain chronological order', () {
        final notifier = container.read(logStateNotifierProvider.notifier);

        notifier.logUserText('First');
        notifier.logLlmText('Second');
        notifier.logInfo('Third');

        final state = container.read(logStateNotifierProvider);
        expect(state.logEntries.length, equals(3));
        expect(state.logEntries[0].content, equals('First'));
        expect(state.logEntries[1].content, equals('Second'));
        expect(state.logEntries[2].content, equals('Third'));
      });
    });

    test('state updates are immutable', () {
      final notifier = container.read(logStateNotifierProvider.notifier);
      final initialState = container.read(logStateNotifierProvider);

      notifier.logLlmText('LLM Generated Message Goes Here.');

      final updatedState = container.read(logStateNotifierProvider);
      expect(initialState, isNot(same(updatedState)));
      expect(initialState.logEntries, isNot(same(updatedState.logEntries)));
    });
  });
}
