import 'package:example/data/model/drawing_tool/font/font_family_enum.dart';
import 'package:json_annotation/json_annotation.dart';

import 'font_size_enum.dart';
import 'font_style_enum.dart';

part 'font_model.g.dart';

@JsonSerializable()
class FontModel {
  final FontStyleEnum style;
  final String weight;
  final FontSize size;
  final FontFamily family;

  const FontModel({
    required this.style,
    required this.size,
    required this.weight,
    required this.family,
  });

  factory FontModel.fromJson(Map<String, dynamic> json) =>
      _$FontModelFromJson(json);

  Map<String, dynamic> toJson() => _$FontModelToJson(this);
}
