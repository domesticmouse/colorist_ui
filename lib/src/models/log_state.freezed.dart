// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LogState {

 List<LogEntry> get logEntries;
/// Create a copy of LogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogStateCopyWith<LogState> get copyWith => _$LogStateCopyWithImpl<LogState>(this as LogState, _$identity);

  /// Serializes this LogState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogState&&const DeepCollectionEquality().equals(other.logEntries, logEntries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(logEntries));

@override
String toString() {
  return 'LogState(logEntries: $logEntries)';
}


}

/// @nodoc
abstract mixin class $LogStateCopyWith<$Res>  {
  factory $LogStateCopyWith(LogState value, $Res Function(LogState) _then) = _$LogStateCopyWithImpl;
@useResult
$Res call({
 List<LogEntry> logEntries
});




}
/// @nodoc
class _$LogStateCopyWithImpl<$Res>
    implements $LogStateCopyWith<$Res> {
  _$LogStateCopyWithImpl(this._self, this._then);

  final LogState _self;
  final $Res Function(LogState) _then;

/// Create a copy of LogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? logEntries = null,}) {
  return _then(_self.copyWith(
logEntries: null == logEntries ? _self.logEntries : logEntries // ignore: cast_nullable_to_non_nullable
as List<LogEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [LogState].
extension LogStatePatterns on LogState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LogState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LogState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LogState value)  $default,){
final _that = this;
switch (_that) {
case _LogState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LogState value)?  $default,){
final _that = this;
switch (_that) {
case _LogState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LogEntry> logEntries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LogState() when $default != null:
return $default(_that.logEntries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LogEntry> logEntries)  $default,) {final _that = this;
switch (_that) {
case _LogState():
return $default(_that.logEntries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LogEntry> logEntries)?  $default,) {final _that = this;
switch (_that) {
case _LogState() when $default != null:
return $default(_that.logEntries);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LogState extends LogState {
  const _LogState({required final  List<LogEntry> logEntries}): _logEntries = logEntries,super._();
  factory _LogState.fromJson(Map<String, dynamic> json) => _$LogStateFromJson(json);

 final  List<LogEntry> _logEntries;
@override List<LogEntry> get logEntries {
  if (_logEntries is EqualUnmodifiableListView) return _logEntries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logEntries);
}


/// Create a copy of LogState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LogStateCopyWith<_LogState> get copyWith => __$LogStateCopyWithImpl<_LogState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LogStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogState&&const DeepCollectionEquality().equals(other._logEntries, _logEntries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_logEntries));

@override
String toString() {
  return 'LogState(logEntries: $logEntries)';
}


}

/// @nodoc
abstract mixin class _$LogStateCopyWith<$Res> implements $LogStateCopyWith<$Res> {
  factory _$LogStateCopyWith(_LogState value, $Res Function(_LogState) _then) = __$LogStateCopyWithImpl;
@override @useResult
$Res call({
 List<LogEntry> logEntries
});




}
/// @nodoc
class __$LogStateCopyWithImpl<$Res>
    implements _$LogStateCopyWith<$Res> {
  __$LogStateCopyWithImpl(this._self, this._then);

  final _LogState _self;
  final $Res Function(_LogState) _then;

/// Create a copy of LogState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? logEntries = null,}) {
  return _then(_LogState(
logEntries: null == logEntries ? _self._logEntries : logEntries // ignore: cast_nullable_to_non_nullable
as List<LogEntry>,
  ));
}


}

// dart format on
