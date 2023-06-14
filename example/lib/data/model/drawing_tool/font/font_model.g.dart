// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'font_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FontModel _$FontModelFromJson(Map<String, dynamic> json) => FontModel(
      style: $enumDecode(_$FontStyleEnumEnumMap, json['style']),
      size: $enumDecode(_$FontSizeEnumMap, json['size']),
      weight: json['weight'] as String,
      family: $enumDecode(_$FontFamilyEnumMap, json['family']),
    );

Map<String, dynamic> _$FontModelToJson(FontModel instance) => <String, dynamic>{
      'style': _$FontStyleEnumEnumMap[instance.style]!,
      'weight': instance.weight,
      'size': _$FontSizeEnumMap[instance.size]!,
      'family': _$FontFamilyEnumMap[instance.family]!,
    };

const _$FontStyleEnumEnumMap = {
  FontStyleEnum.bold: 'bold',
  FontStyleEnum.italic: 'italic',
  FontStyleEnum.normal: 'normal',
};

const _$FontSizeEnumMap = {
  FontSize.size8: '8px',
  FontSize.size10: '10px',
  FontSize.size12: '12px',
  FontSize.size13: '13px',
  FontSize.size14: '14px',
  FontSize.size16: '16px',
  FontSize.size20: '20px',
  FontSize.size28: '28px',
  FontSize.size36: '36px',
  FontSize.size48: '48px',
  FontSize.size64: '64px',
};

const _$FontFamilyEnumMap = {
  FontFamily.defaultFont: 'Default',
  FontFamily.helvetica: 'Helvetica',
  FontFamily.courier: 'Courier',
  FontFamily.garamond: 'Garamond',
  FontFamily.palatino: 'Palatino',
  FontFamily.timesNewRoman: 'Times New Roman',
};
