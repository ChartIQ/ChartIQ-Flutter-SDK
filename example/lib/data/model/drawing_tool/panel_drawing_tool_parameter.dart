import 'package:example/common/utils/parse_string_or_double_to_int.dart';
import 'package:example/data/model/drawing_tool/fib_model.dart';
import 'package:example/data/model/drawing_tool/font/font_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'line/line_type_enum.dart';

part 'panel_drawing_tool_parameter.g.dart';

@JsonSerializable()
class PanelDrawingToolParameter {
  @JsonKey(name: 'pattern')
  final LineType? lineType;
  @JsonKey(fromJson: parseStringOrDoubleToInt)
  final int? lineWidth;
  final String? fillColor, color;
  final FontModel? font;
  final List<FibModel> fibs;

  const PanelDrawingToolParameter({
    this.lineType,
    this.lineWidth,
    this.fillColor,
    this.color,
    this.font,
    required this.fibs,
  });

  factory PanelDrawingToolParameter.fromJson(Map<String, dynamic> json) =>
      _$PanelDrawingToolParameterFromJson(json);

  Map<String, dynamic> toJson() => _$PanelDrawingToolParameterToJson(this);
}
