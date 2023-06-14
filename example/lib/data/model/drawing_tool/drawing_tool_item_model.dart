import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:example/data/model/drawing_tool/drawing_tool_category.dart';
import 'package:example/data/model/drawing_tool/drawing_tool_section.dart';

class DrawingToolItemModel {
  final DrawingTool tool;
  final String icon, name;
  final DrawingToolCategory category;
  final DrawingToolSection section;

  DrawingToolItemModel({
    required this.tool,
    required this.icon,
    required this.category,
    required this.section,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrawingToolItemModel &&
          runtimeType == other.runtimeType &&
          tool == other.tool &&
          icon == other.icon &&
          category == other.category &&
          section == other.section &&
          name == other.name;

  @override
  int get hashCode =>
      tool.hashCode ^
      icon.hashCode ^
      section.hashCode ^
      category.hashCode ^
      name.hashCode;
}
