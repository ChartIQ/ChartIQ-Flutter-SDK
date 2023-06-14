import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:example/data/model/drawing_tool/line/line_types_enum.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/data/model/option_item_model.dart';

class DrawingToolSettingsItem {
  DrawingToolSettingsItem._();

  factory DrawingToolSettingsItem.color({
    required String title,
    required PickerColor color,
    required DrawingParameterType param,
  }) = DrawingToolSettingsItemColor;

  factory DrawingToolSettingsItem.line({
    required String title,
    required LineTypes line,
    DrawingParameterType lineTypeParam,
    DrawingParameterType lineWidthParam,
  }) = DrawingToolSettingsItemLine;

  factory DrawingToolSettingsItem.chooseValue({
    required String title,
    String? secondaryText,
    required DrawingParameterType param,
    required List<OptionItemModel> options,
    bool isMultipleSelection,
    bool hasCustomValueSupport,
    bool hasNegativeValueSupport,
  }) = DrawingToolSettingsItemChooseValue;

  factory DrawingToolSettingsItem.style({
    required String title,
    required bool isBold,
    required bool isItalic,
    DrawingParameterType weightParam,
    DrawingParameterType styleParam,
  }) = DrawingToolSettingsItemStyle;

  factory DrawingToolSettingsItem.switchValue({
    required String title,
    required bool isChecked,
    required DrawingParameterType param,
  }) = DrawingToolSettingsItemSwitch;

  factory DrawingToolSettingsItem.number({
    required String title,
    required int number,
    DrawingParameterType param,
  }) = DrawingToolSettingsItemNumber;

  factory DrawingToolSettingsItem.deviation({
    required String title,
    required List<DrawingToolSettingsItem> settings,
  }) = DrawingToolSettingsItemDeviation;

}

class DrawingToolSettingsItemColor extends DrawingToolSettingsItem {
  DrawingToolSettingsItemColor({
    required this.title,
    required this.color,
    required this.param,
  }) : super._();

  final String title;
  final PickerColor color;
  final DrawingParameterType param;
}

class DrawingToolSettingsItemLine extends DrawingToolSettingsItem {
  DrawingToolSettingsItemLine({
    required this.title,
    required this.line,
    this.lineTypeParam = DrawingParameterType.lineType,
    this.lineWidthParam = DrawingParameterType.lineWidth,
  }) : super._();

  final String title;
  final LineTypes line;
  final DrawingParameterType lineTypeParam, lineWidthParam;
}

class DrawingToolSettingsItemChooseValue extends DrawingToolSettingsItem {
  DrawingToolSettingsItemChooseValue({
    required this.title,
    this.secondaryText,
    required this.param,
    required this.options,
    this.isMultipleSelection = false,
    this.hasCustomValueSupport = false,
    this.hasNegativeValueSupport = true,
  }) : super._();

  final String title;
  final String? secondaryText;
  final DrawingParameterType param;
  final List<OptionItemModel> options;
  final bool isMultipleSelection,
      hasCustomValueSupport,
      hasNegativeValueSupport;
}

class DrawingToolSettingsItemStyle extends DrawingToolSettingsItem {
  DrawingToolSettingsItemStyle({
    required this.title,
    required this.isBold,
    required this.isItalic,
    this.weightParam = DrawingParameterType.weight,
    this.styleParam = DrawingParameterType.style,
  }) : super._();

  final String title;
  final bool isBold, isItalic;
  final DrawingParameterType weightParam, styleParam;
}

class DrawingToolSettingsItemSwitch extends DrawingToolSettingsItem {
  DrawingToolSettingsItemSwitch({
    required this.title,
    required this.isChecked,
    required this.param,
  }) : super._();

  final String title;
  final bool isChecked;
  final DrawingParameterType param;
}


class DrawingToolSettingsItemNumber extends DrawingToolSettingsItem {
  DrawingToolSettingsItemNumber({
    required this.title,
    required this.number,
    this.param = DrawingParameterType.priceBuckets,
  }) : super._();

  final String title;
  final int number;
  final DrawingParameterType param;
}

class DrawingToolSettingsItemDeviation extends DrawingToolSettingsItem {
  DrawingToolSettingsItemDeviation({
    required this.title,
    required this.settings,
  }) : super._();

  final String title;
  final List<DrawingToolSettingsItem> settings;
}
