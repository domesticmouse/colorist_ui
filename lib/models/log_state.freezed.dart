// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
