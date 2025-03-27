// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$colorStateNotifierHash() =>
    r'85c576b0f8fd079c79f3483f6659dd0ed6a5877a';

/// A Riverpod provider that manages the state of the color picker.
/// This notifier allows selecting colors from the history and updating
/// the current color.
///
/// Copied from [ColorStateNotifier].
@ProviderFor(ColorStateNotifier)
final colorStateNotifierProvider =
    AutoDisposeNotifierProvider<ColorStateNotifier, ColorState>.internal(
      ColorStateNotifier.new,
      name: r'colorStateNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$colorStateNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ColorStateNotifier = AutoDisposeNotifier<ColorState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
