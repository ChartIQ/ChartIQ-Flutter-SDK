// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panel_drawing_tool_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PanelDrawingToolParameter _$PanelDrawingToolParameterFromJson(
        Map<String, dynamic> json) =>
    PanelDrawingToolParameter(
      lineType: $enumDecodeNullable(_$LineTypeEnumMap, json['pattern']),
      lineWidth: parseStringOrDoubleToInt(json['lineWidth']),
      fillColor: json['fillColor'] as String?,
      color: json['color'] as String?,
      font: json['font'] == null
          ? null
          : FontModel.fromJson(json['font'] as Map<String, dynamic>),
      fibs: (json['fibs'] as List<dynamic>)
          .map((e) => FibModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PanelDrawingToolParameterToJson(
        PanelDrawingToolParameter instance) =>
    <String, dynamic>{
      'pattern': _$LineTypeEnumMap[instance.lineType],
      'lineWidth': instance.lineWidth,
      'fillColor': instance.fillColor,
      'color': instance.color,
      'font': instance.font,
      'fibs': instance.fibs,
    };

const _$LineTypeEnumMap = {
  LineType.solid: 'solid',
  LineType.dotted: 'dotted',
  LineType.dashed: 'dashed',
};
