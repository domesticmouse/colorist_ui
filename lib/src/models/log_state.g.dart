// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LogState _$LogStateFromJson(Map<String, dynamic> json) => _LogState(
  logEntries:
      (json['logEntries'] as List<dynamic>)
          .map((e) => LogEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$LogStateToJson(_LogState instance) => <String, dynamic>{
  'logEntries': instance.logEntries.map((e) => e.toJson()).toList(),
};
