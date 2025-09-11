// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A Riverpod provider that manages the state of a chat conversation.
/// This notifier allows adding user and LLM messages, clearing the chat,
/// appending to existing messages, and finalizing messages.

@ProviderFor(ChatStateNotifier)
const chatStateProvider = ChatStateNotifierProvider._();

/// A Riverpod provider that manages the state of a chat conversation.
/// This notifier allows adding user and LLM messages, clearing the chat,
/// appending to existing messages, and finalizing messages.
final class ChatStateNotifierProvider
    extends $NotifierProvider<ChatStateNotifier, ChatState> {
  /// A Riverpod provider that manages the state of a chat conversation.
  /// This notifier allows adding user and LLM messages, clearing the chat,
  /// appending to existing messages, and finalizing messages.
  const ChatStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatStateNotifierHash();

  @$internal
  @override
  ChatStateNotifier create() => ChatStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatState>(value),
    );
  }
}

String _$chatStateNotifierHash() => r'77eca0bd3183f933482d16d21b5a49c915ca0d85';

/// A Riverpod provider that manages the state of a chat conversation.
/// This notifier allows adding user and LLM messages, clearing the chat,
/// appending to existing messages, and finalizing messages.

abstract class _$ChatStateNotifier extends $Notifier<ChatState> {
  ChatState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ChatState, ChatState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ChatState, ChatState>,
              ChatState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
