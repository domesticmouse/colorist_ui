// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatStateNotifierHash() => r'77eca0bd3183f933482d16d21b5a49c915ca0d85';

/// A Riverpod provider that manages the state of a chat conversation.
/// This notifier allows adding user and LLM messages, clearing the chat,
/// appending to existing messages, and finalizing messages.
///
/// Copied from [ChatStateNotifier].
@ProviderFor(ChatStateNotifier)
final chatStateNotifierProvider =
    AutoDisposeNotifierProvider<ChatStateNotifier, ChatState>.internal(
  ChatStateNotifier.new,
  name: r'chatStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatStateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatStateNotifier = AutoDisposeNotifier<ChatState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
