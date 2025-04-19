// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'color_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ColorData {
  double get red;
  double get green;
  double get blue;

  /// Create a copy of ColorData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ColorDataCopyWith<ColorData> get copyWith =>
      _$ColorDataCopyWithImpl<ColorData>(this as ColorData, _$identity);

  /// Serializes this ColorData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ColorData &&
            (identical(other.red, red) || other.red == red) &&
            (identical(other.green, green) || other.green == green) &&
            (identical(other.blue, blue) || other.blue == blue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, red, green, blue);

  @override
  String toString() {
    return 'ColorData(red: $red, green: $green, blue: $blue)';
  }
}

/// @nodoc
abstract mixin class $ColorDataCopyWith<$Res> {
  factory $ColorDataCopyWith(ColorData value, $Res Function(ColorData) _then) =
      _$ColorDataCopyWithImpl;
  @useResult
  $Res call({double red, double green, double blue});
}

/// @nodoc
class _$ColorDataCopyWithImpl<$Res> implements $ColorDataCopyWith<$Res> {
  _$ColorDataCopyWithImpl(this._self, this._then);

  final ColorData _self;
  final $Res Function(ColorData) _then;

  /// Create a copy of ColorData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? red = null,
    Object? green = null,
    Object? blue = null,
  }) {
    return _then(_self.copyWith(
      red: null == red
          ? _self.red
          : red // ignore: cast_nullable_to_non_nullable
              as double,
      green: null == green
          ? _self.green
          : green // ignore: cast_nullable_to_non_nullable
              as double,
      blue: null == blue
          ? _self.blue
          : blue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ColorData extends ColorData {
  const _ColorData({required this.red, required this.green, required this.blue})
      : assert(red >= 0.0 && red <= 1.0),
        assert(green >= 0.0 && green <= 1.0),
        assert(blue >= 0.0 && blue <= 1.0),
        super._();
  factory _ColorData.fromJson(Map<String, dynamic> json) =>
      _$ColorDataFromJson(json);

  @override
  final double red;
  @override
  final double green;
  @override
  final double blue;

  /// Create a copy of ColorData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ColorDataCopyWith<_ColorData> get copyWith =>
      __$ColorDataCopyWithImpl<_ColorData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ColorDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ColorData &&
            (identical(other.red, red) || other.red == red) &&
            (identical(other.green, green) || other.green == green) &&
            (identical(other.blue, blue) || other.blue == blue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, red, green, blue);

  @override
  String toString() {
    return 'ColorData(red: $red, green: $green, blue: $blue)';
  }
}

/// @nodoc
abstract mixin class _$ColorDataCopyWith<$Res>
    implements $ColorDataCopyWith<$Res> {
  factory _$ColorDataCopyWith(
          _ColorData value, $Res Function(_ColorData) _then) =
      __$ColorDataCopyWithImpl;
  @override
  @useResult
  $Res call({double red, double green, double blue});
}

/// @nodoc
class __$ColorDataCopyWithImpl<$Res> implements _$ColorDataCopyWith<$Res> {
  __$ColorDataCopyWithImpl(this._self, this._then);

  final _ColorData _self;
  final $Res Function(_ColorData) _then;

  /// Create a copy of ColorData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? red = null,
    Object? green = null,
    Object? blue = null,
  }) {
    return _then(_ColorData(
      red: null == red
          ? _self.red
          : red // ignore: cast_nullable_to_non_nullable
              as double,
      green: null == green
          ? _self.green
          : green // ignore: cast_nullable_to_non_nullable
              as double,
      blue: null == blue
          ? _self.blue
          : blue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
