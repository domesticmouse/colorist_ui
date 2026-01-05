// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A Riverpod provider that manages the state of the color picker.
/// This notifier allows selecting colors from the history and updating
/// the current color.

@ProviderFor(ColorStateNotifier)
final colorStateProvider = ColorStateNotifierProvider._();

/// A Riverpod provider that manages the state of the color picker.
/// This notifier allows selecting colors from the history and updating
/// the current color.
final class ColorStateNotifierProvider
    extends $NotifierProvider<ColorStateNotifier, ColorState> {
  /// A Riverpod provider that manages the state of the color picker.
  /// This notifier allows selecting colors from the history and updating
  /// the current color.
  ColorStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'colorStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$colorStateNotifierHash();

  @$internal
  @override
  ColorStateNotifier create() => ColorStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ColorState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ColorState>(value),
    );
  }
}

String _$colorStateNotifierHash() =>
    r'244cb2d7a9c863c11cd59de570bf4a7ad4fbf3ff';

/// A Riverpod provider that manages the state of the color picker.
/// This notifier allows selecting colors from the history and updating
/// the current color.

abstract class _$ColorStateNotifier extends $Notifier<ColorState> {
  ColorState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ColorState, ColorState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ColorState, ColorState>,
              ColorState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
