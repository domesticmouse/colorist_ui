// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$logStateNotifierHash() => r'9f17e243a57f73934641b582be4190b4e9ffc7a3';

/// A Riverpod provider that manages the application's log state.  This notifier
/// provides methods to add various types of log entries, such as user input,
/// LLM output, function calls, results, errors, warnings, and informational
/// messages.  It uses the `LogState` model to maintain the log entries.
///
/// Copied from [LogStateNotifier].
@ProviderFor(LogStateNotifier)
final logStateNotifierProvider =
    AutoDisposeNotifierProvider<LogStateNotifier, LogState>.internal(
      LogStateNotifier.new,
      name: r'logStateNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$logStateNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LogStateNotifier = AutoDisposeNotifier<LogState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
