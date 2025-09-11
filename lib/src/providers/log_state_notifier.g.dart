// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A Riverpod provider that manages the application's log state.  This notifier
/// provides methods to add various types of log entries, such as user input,
/// LLM output, function calls, results, errors, warnings, and informational
/// messages.  It uses the `LogState` model to maintain the log entries.

@ProviderFor(LogStateNotifier)
const logStateProvider = LogStateNotifierProvider._();

/// A Riverpod provider that manages the application's log state.  This notifier
/// provides methods to add various types of log entries, such as user input,
/// LLM output, function calls, results, errors, warnings, and informational
/// messages.  It uses the `LogState` model to maintain the log entries.
final class LogStateNotifierProvider
    extends $NotifierProvider<LogStateNotifier, LogState> {
  /// A Riverpod provider that manages the application's log state.  This notifier
  /// provides methods to add various types of log entries, such as user input,
  /// LLM output, function calls, results, errors, warnings, and informational
  /// messages.  It uses the `LogState` model to maintain the log entries.
  const LogStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logStateNotifierHash();

  @$internal
  @override
  LogStateNotifier create() => LogStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LogState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LogState>(value),
    );
  }
}

String _$logStateNotifierHash() => r'9f17e243a57f73934641b582be4190b4e9ffc7a3';

/// A Riverpod provider that manages the application's log state.  This notifier
/// provides methods to add various types of log entries, such as user input,
/// LLM output, function calls, results, errors, warnings, and informational
/// messages.  It uses the `LogState` model to maintain the log entries.

abstract class _$LogStateNotifier extends $Notifier<LogState> {
  LogState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<LogState, LogState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LogState, LogState>,
              LogState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
