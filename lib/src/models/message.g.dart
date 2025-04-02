// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
  id: json['id'] as String,
  content: json['content'] as String,
  role: $enumDecode(_$MessageRoleEnumMap, json['role']),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  state: $enumDecode(_$MessageStateEnumMap, json['state']),
);

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'role': _$MessageRoleEnumMap[instance.role]!,
  'updatedAt': instance.updatedAt.toIso8601String(),
  'state': _$MessageStateEnumMap[instance.state]!,
};

const _$MessageRoleEnumMap = {MessageRole.user: 'user', MessageRole.llm: 'llm'};

const _$MessageStateEnumMap = {
  MessageState.complete: 'complete',
  MessageState.streaming: 'streaming',
};
