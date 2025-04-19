// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LogEntry _$LogEntryFromJson(Map<String, dynamic> json) => _LogEntry(
      id: json['id'] as String,
      content: json['content'] as String,
      author: $enumDecode(_$LogEntryRoleEnumMap, json['author']),
      type: $enumDecode(_$LogEntryTypeEnumMap, json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$LogEntryToJson(_LogEntry instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'author': _$LogEntryRoleEnumMap[instance.author]!,
      'type': _$LogEntryTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp.toIso8601String(),
    };

const _$LogEntryRoleEnumMap = {
  LogEntryRole.user: 'user',
  LogEntryRole.llm: 'llm',
  LogEntryRole.app: 'app',
  LogEntryRole.tool: 'tool',
};

const _$LogEntryTypeEnumMap = {
  LogEntryType.text: 'text',
  LogEntryType.error: 'error',
  LogEntryType.warning: 'warning',
  LogEntryType.info: 'info',
};
