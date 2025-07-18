// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'color_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ColorState {

/// The currently selected color.
 ColorData get currentColor;/// A list of previously selected colors (maximum [_maxColorHistory] entries).
 List<ColorData> get colorHistory;
/// Create a copy of ColorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ColorStateCopyWith<ColorState> get copyWith => _$ColorStateCopyWithImpl<ColorState>(this as ColorState, _$identity);

  /// Serializes this ColorState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ColorState&&(identical(other.currentColor, currentColor) || other.currentColor == currentColor)&&const DeepCollectionEquality().equals(other.colorHistory, colorHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentColor,const DeepCollectionEquality().hash(colorHistory));

@override
String toString() {
  return 'ColorState(currentColor: $currentColor, colorHistory: $colorHistory)';
}


}

/// @nodoc
abstract mixin class $ColorStateCopyWith<$Res>  {
  factory $ColorStateCopyWith(ColorState value, $Res Function(ColorState) _then) = _$ColorStateCopyWithImpl;
@useResult
$Res call({
 ColorData currentColor, List<ColorData> colorHistory
});


$ColorDataCopyWith<$Res> get currentColor;

}
/// @nodoc
class _$ColorStateCopyWithImpl<$Res>
    implements $ColorStateCopyWith<$Res> {
  _$ColorStateCopyWithImpl(this._self, this._then);

  final ColorState _self;
  final $Res Function(ColorState) _then;

/// Create a copy of ColorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentColor = null,Object? colorHistory = null,}) {
  return _then(_self.copyWith(
currentColor: null == currentColor ? _self.currentColor : currentColor // ignore: cast_nullable_to_non_nullable
as ColorData,colorHistory: null == colorHistory ? _self.colorHistory : colorHistory // ignore: cast_nullable_to_non_nullable
as List<ColorData>,
  ));
}
/// Create a copy of ColorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ColorDataCopyWith<$Res> get currentColor {
  
  return $ColorDataCopyWith<$Res>(_self.currentColor, (value) {
    return _then(_self.copyWith(currentColor: value));
  });
}
}


/// Adds pattern-matching-related methods to [ColorState].
extension ColorStatePatterns on ColorState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ColorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ColorState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ColorState value)  $default,){
final _that = this;
switch (_that) {
case _ColorState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ColorState value)?  $default,){
final _that = this;
switch (_that) {
case _ColorState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ColorData currentColor,  List<ColorData> colorHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ColorState() when $default != null:
return $default(_that.currentColor,_that.colorHistory);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ColorData currentColor,  List<ColorData> colorHistory)  $default,) {final _that = this;
switch (_that) {
case _ColorState():
return $default(_that.currentColor,_that.colorHistory);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ColorData currentColor,  List<ColorData> colorHistory)?  $default,) {final _that = this;
switch (_that) {
case _ColorState() when $default != null:
return $default(_that.currentColor,_that.colorHistory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ColorState extends ColorState {
  const _ColorState({required this.currentColor, required final  List<ColorData> colorHistory}): _colorHistory = colorHistory,super._();
  factory _ColorState.fromJson(Map<String, dynamic> json) => _$ColorStateFromJson(json);

/// The currently selected color.
@override final  ColorData currentColor;
/// A list of previously selected colors (maximum [_maxColorHistory] entries).
 final  List<ColorData> _colorHistory;
/// A list of previously selected colors (maximum [_maxColorHistory] entries).
@override List<ColorData> get colorHistory {
  if (_colorHistory is EqualUnmodifiableListView) return _colorHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_colorHistory);
}


/// Create a copy of ColorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ColorStateCopyWith<_ColorState> get copyWith => __$ColorStateCopyWithImpl<_ColorState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ColorStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ColorState&&(identical(other.currentColor, currentColor) || other.currentColor == currentColor)&&const DeepCollectionEquality().equals(other._colorHistory, _colorHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentColor,const DeepCollectionEquality().hash(_colorHistory));

@override
String toString() {
  return 'ColorState(currentColor: $currentColor, colorHistory: $colorHistory)';
}


}

/// @nodoc
abstract mixin class _$ColorStateCopyWith<$Res> implements $ColorStateCopyWith<$Res> {
  factory _$ColorStateCopyWith(_ColorState value, $Res Function(_ColorState) _then) = __$ColorStateCopyWithImpl;
@override @useResult
$Res call({
 ColorData currentColor, List<ColorData> colorHistory
});


@override $ColorDataCopyWith<$Res> get currentColor;

}
/// @nodoc
class __$ColorStateCopyWithImpl<$Res>
    implements _$ColorStateCopyWith<$Res> {
  __$ColorStateCopyWithImpl(this._self, this._then);

  final _ColorState _self;
  final $Res Function(_ColorState) _then;

/// Create a copy of ColorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentColor = null,Object? colorHistory = null,}) {
  return _then(_ColorState(
currentColor: null == currentColor ? _self.currentColor : currentColor // ignore: cast_nullable_to_non_nullable
as ColorData,colorHistory: null == colorHistory ? _self._colorHistory : colorHistory // ignore: cast_nullable_to_non_nullable
as List<ColorData>,
  ));
}

/// Create a copy of ColorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ColorDataCopyWith<$Res> get currentColor {
  
  return $ColorDataCopyWith<$Res>(_self.currentColor, (value) {
    return _then(_self.copyWith(currentColor: value));
  });
}
}

// dart format on
