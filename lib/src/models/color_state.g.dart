// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ColorState _$ColorStateFromJson(Map<String, dynamic> json) => _ColorState(
      currentColor:
          ColorData.fromJson(json['currentColor'] as Map<String, dynamic>),
      colorHistory: (json['colorHistory'] as List<dynamic>)
          .map((e) => ColorData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ColorStateToJson(_ColorState instance) =>
    <String, dynamic>{
      'currentColor': instance.currentColor.toJson(),
      'colorHistory': instance.colorHistory.map((e) => e.toJson()).toList(),
    };
