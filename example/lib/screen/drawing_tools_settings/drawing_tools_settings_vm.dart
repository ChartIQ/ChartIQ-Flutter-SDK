import 'dart:convert';
import 'package:chart_iq/chartiq_flutter_sdk.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/utils/parse_string_or_double_to_int.dart';
import 'package:example/data/model/drawing_tool/drawing_tool_item_model.dart';
import 'package:example/data/model/drawing_tool/fib_model.dart';
import 'package:example/data/model/drawing_tool/font/font_family_enum.dart';
import 'package:example/data/model/drawing_tool/font/font_model.dart';
import 'package:example/data/model/drawing_tool/font/font_size_enum.dart';
import 'package:example/data/model/drawing_tool/font/font_style_enum.dart';
import 'package:example/data/model/drawing_tool/line/line_type_enum.dart';
import 'package:example/data/model/drawing_tool/line/line_types_enum.dart';
import 'package:example/data/model/option_item_model.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/screen/home/widgets/drawing_tool_panel/drawing_tool_panel_vm.dart';
import 'package:flutter/material.dart';

import 'model/drawing_tool_settings_item.dart';

class DrawingToolsSettingsVM extends ChangeNotifier {
  DrawingToolItemModel drawingTool;
  final ChartIQController chartIQController;

  static const int _keyBoldOff = 300;
  static const _keyVolumeProfile = 'volumeProfile';
  static const _keyWaveParameters = 'waveParameters';

  DrawingToolsSettingsVM({
    required this.drawingTool,
    required this.chartIQController,
  });

  DrawingToolSettingsItemDeviation? deviationSetting;

  final List<DrawingToolSettingsItem> settingsList = [];

  void updateVM(DrawingToolPanelVM newVM) {
    if (newVM.drawingTool != drawingTool) {
      drawingTool = newVM.drawingTool!;
      setupScreen();
    }
  }

  Future<void> setupScreen() async {
    final drawingToolParameters =
        await chartIQController.chartIQDrawingTool.getDrawingParameters(
      drawingTool.tool,
    );
    final manager = chartIQController.drawingManager;

    final futures = await Future.wait<bool>([
      manager.isSupportingFillColor(drawingTool.tool),
      manager.isSupportingLineColor(drawingTool.tool),
      manager.isSupportingLineType(drawingTool.tool),
      manager.isSupportingFont(drawingTool.tool),
      manager.isSupportingAxisLabel(drawingTool.tool),
      manager.isSupportingDeviations(drawingTool.tool),
      manager.isSupportingFibonacci(drawingTool.tool),
      manager.isSupportingElliottWave(drawingTool.tool),
      manager.isSupportingVolumeProfile(drawingTool.tool),
    ]);

    settingsList.clear();

    // fill color
    if (futures[0]) {
      settingsList.add(_getFillColorFromParams(drawingToolParameters));
    }

    // line color
    if (futures[1]) {
      settingsList.add(_getLineColorFromParams(drawingToolParameters));
    }

    // line type
    if (futures[2]) {
      settingsList.add(_getLineTypeFromParams(drawingToolParameters));
    }

    // font
    if (futures[3]) {
      settingsList.addAll(_getFontModelsFromParams(drawingToolParameters));
    }

    // axis label
    if (futures[4]) {
      //TODO: missing enum value on native side
      settingsList.add(_getAxisLabelFromParams(drawingToolParameters));
    }

    // deviations
    if (futures[5]) {
      settingsList.add(_getDeviationsFromParams(drawingToolParameters));
    }

    // fibonacci
    if (futures[6]) {
      settingsList.add(_getFibonacciFromParams(drawingToolParameters));
    }

    // elliot wave
    if (futures[7]) {
      settingsList.addAll(_getElliotWaveFromParams(drawingToolParameters));
    }

    // volume profile
    if (futures[8]) {
      settingsList.add(_getVolumeProfileFromParams(drawingToolParameters));
    }
    notifyListeners();
  }

  Future<void> updateParameter(
      DrawingParameterType parameter, dynamic value) async {
    if (value is bool) {
      await chartIQController.chartIQDrawingTool.setDrawingParameter(
        parameter,
        value,
      );
    } else {
      await chartIQController.chartIQDrawingTool.setDrawingParameterByName(
        parameter.value,
        value.toString(),
      );
    }
    await setupScreen();
  }

  Future<void> updateParameterByName(String parameter, String value) async {
    await chartIQController.chartIQDrawingTool.setDrawingParameterByName(
      parameter,
      value,
    );
    await setupScreen();
  }

  Future<void> updateMultipleChoiceParameters(
    DrawingParameterType parameter, {
    required List<OptionItemModel> options,
  }) async {
    String valueToUpdate;

    if (parameter == DrawingParameterType.fibs) {
      final fibs = jsonEncode(options
          .map(
            (e) => FibModel(
              level: double.parse(e.title),
              display: e.isChecked,
            ).toJson(),
          )
          .toList());
      valueToUpdate = base64Encode(utf8.encode(fibs));
    } else {
      //TODO: if multiple choice, set isCheck for all options and pass array of values ??
      valueToUpdate = options.firstWhere((element) => element.isChecked).title;
    }

    updateParameter(parameter, valueToUpdate);
  }

  Future<void> updateLineType(
    LineTypes line, {
    DrawingParameterType? lineTypeParam,
    DrawingParameterType? lineWidthParam,
  }) async {
    Future.wait([
      chartIQController.chartIQDrawingTool.setDrawingParameterByName(
        (lineTypeParam ?? DrawingParameterType.lineType).value,
        line.type.name,
      ),
      chartIQController.chartIQDrawingTool.setDrawingParameterByName(
        (lineWidthParam ?? DrawingParameterType.lineWidth).value,
        line.width.toString(),
      ),
    ]);

    await setupScreen();
  }

  DrawingToolSettingsItem _getFillColorFromParams(Map<String, dynamic> params) {
    const colorParam = DrawingParameterType.fillColor;
    return DrawingToolSettingsItem.color(
      title: "Fill Color",
      color: PickerColor(params[colorParam.value]),
      param: colorParam,
    );
  }

  DrawingToolSettingsItem _getLineColorFromParams(Map<String, dynamic> params) {
    const colorParam = DrawingParameterType.lineColor;
    return DrawingToolSettingsItem.color(
      title: "Line Color",
      color: PickerColor(params[colorParam.value]),
      param: colorParam,
    );
  }

  DrawingToolSettingsItem _getLineTypeFromParams(Map<String, dynamic> params) {
    final lineType = params[DrawingParameterType.lineType.value];
    final lineWidth = params[DrawingParameterType.lineWidth.value];
    return DrawingToolSettingsItem.line(
      title: "Line Type",
      line: LineTypes.getFromParameters(
        LineType.values.firstWhere(
          (element) => element.name == lineType,
          orElse: () => LineType.solid,
        ),
        parseStringOrDoubleToInt(lineWidth),
      ),
    );
  }

  List<DrawingToolSettingsItem> _getFontModelsFromParams(
      Map<String, dynamic> params) {
    final result = List<DrawingToolSettingsItem>.empty(growable: true);
    final font = FontModel.fromJson(params['font']);

    result.add(
      DrawingToolSettingsItem.chooseValue(
        title: "Font Family",
        param: DrawingParameterType.family,
        options: FontFamily.values
            .map(
              (e) => OptionItemModel(
                title: e.value,
                isChecked: e.value == font.family.value,
              ),
            )
            .toList(),
      ),
    );

    final isBold = font.weight == 'bold' ||
        (int.tryParse(font.weight) ?? _keyBoldOff) > _keyBoldOff;

    result.add(
      DrawingToolSettingsItem.style(
        title: 'Font Style',
        isBold: isBold,
        isItalic: font.style == FontStyleEnum.italic,
      ),
    );

    result.add(
      DrawingToolSettingsItem.chooseValue(
        title: "Font Size",
        param: DrawingParameterType.size,
        options: FontSize.values
            .map(
              (e) => OptionItemModel(
                title: e.value,
                isChecked: e.value == font.size.value,
              ),
            )
            .toList(),
      ),
    );

    return result;
  }

  DrawingToolSettingsItem _getAxisLabelFromParams(Map<String, dynamic> params) {
    final axisLabel = params[DrawingParameterType.axisLabel.value];
    return DrawingToolSettingsItem.switchValue(
      title: "Axis Label",
      isChecked: axisLabel,
      param: DrawingParameterType.axisLabel,
    );
  }

  DrawingToolSettingsItem _getFibonacciFromParams(Map<String, dynamic> params) {
    final fibonacci = (params[DrawingParameterType.fibs.value] as List)
        .map((e) => FibModel.fromJson(e));
    return DrawingToolSettingsItem.chooseValue(
      title: "Fibonacci Settings",
      options: fibonacci
          .map((e) => OptionItemModel(
                title: e.level.toString(),
                prettyTitle: '${e.level}%',
                isChecked: e.display,
              ))
          .toList(),
      hasCustomValueSupport: true,
      hasNegativeValueSupport: drawingTool.tool != DrawingTool.fibArc,
      isMultipleSelection: true,
      param: DrawingParameterType.fibs,
    );
  }

  DrawingToolSettingsItem _getVolumeProfileFromParams(
      Map<String, dynamic> params) {
    final volumeParams = params[_keyVolumeProfile];
    return DrawingToolSettingsItem.number(
      title: "Volume Profile",
      number: parseStringOrDoubleToInt(
          volumeParams[DrawingParameterType.priceBuckets.value])!,
    );
  }

  List<DrawingToolSettingsItem> _getElliotWaveFromParams(
      Map<String, dynamic> params) {
    final List<DrawingToolSettingsItem> result =
        List<DrawingToolSettingsItem>.empty(growable: true);

    final waveParams = params[_keyWaveParameters];

    final impulseValue = waveParams[DrawingParameterType.impulse.value];
    result.add(
      DrawingToolSettingsItem.chooseValue(
        title: "Impulse",
        secondaryText: impulseValue.toString(),
        options: WaveImpulse.values
            .map((e) => OptionItemModel(
                  title: e.value,
                  isChecked: e.value == impulseValue,
                ))
            .toList(),
        param: DrawingParameterType.impulse,
      ),
    );

    final correctiveValue = waveParams[DrawingParameterType.corrective.value];
    result.add(
      DrawingToolSettingsItem.chooseValue(
        title: "Corrective",
        secondaryText: correctiveValue.toString(),
        options: WaveCorrective.values
            .map((e) => OptionItemModel(
                  title: e.value,
                  isChecked: e.value == correctiveValue,
                ))
            .toList(),
        param: DrawingParameterType.corrective,
      ),
    );

    final decorationValue =
        waveParams[DrawingParameterType.decoration.value].toString();
    result.add(
      DrawingToolSettingsItem.chooseValue(
        title: "Decoration",
        secondaryText: decorationValue.capitalize(),
        options: WaveDecoration.values
            .map((e) => OptionItemModel(
                  title: e.value,
                  isChecked:
                      e.value.toLowerCase() == decorationValue.toLowerCase(),
                ))
            .toList(),
        param: DrawingParameterType.decoration,
      ),
    );

    final showLines =
        waveParams[DrawingParameterType.showLines.value]?.toString().toBool() ??
            false;
    result.add(
      DrawingToolSettingsItem.switchValue(
        title: "Show Lines",
        isChecked: showLines,
        param: DrawingParameterType.showLines,
      ),
    );

    return result;
  }

  DrawingToolSettingsItem _getDeviationsFromParams(
      Map<String, dynamic> params) {
    final deviationItem = DrawingToolSettingsItemDeviation(
        title: 'STD Deviations', settings: List.empty(growable: true));

    void addSwitchModel(DrawingParameterType boolParam, String title) {
      final isActive = params[boolParam.value]?.toString().toBool() ?? false;
      deviationItem.settings.add(DrawingToolSettingsItem.switchValue(
        title: title,
        isChecked: isActive,
        param: boolParam,
      ));
    }

    void addColorModel(DrawingParameterType colorParam, String title) {
      final color = params[colorParam.value];
      deviationItem.settings.add(DrawingToolSettingsItem.color(
        title: title,
        color: PickerColor(color),
        param: colorParam,
      ));
    }

    void addLineModel(DrawingParameterType typeParam,
        DrawingParameterType widthParam, String title) {
      final type = params[typeParam.value];
      final width = params[widthParam.value];
      deviationItem.settings.add(
        DrawingToolSettingsItem.line(
          title: title,
          line: LineTypes.getFromParameters(
              LineType.values.firstWhere(
                (element) => element.name == type,
                orElse: () => LineType.solid,
              ),
              parseStringOrDoubleToInt(width)),
          lineTypeParam: typeParam,
          lineWidthParam: widthParam,
        ),
      );
    }

    addSwitchModel(DrawingParameterType.active1, "Show Line 1");
    addColorModel(DrawingParameterType.color1, "Line 1 Color");
    addLineModel(
      DrawingParameterType.pattern1,
      DrawingParameterType.lineWidth1,
      "Line 1 Type",
    );

    addSwitchModel(DrawingParameterType.active2, "Show Line 2");
    addColorModel(DrawingParameterType.color2, "Line 2 Color");
    addLineModel(
      DrawingParameterType.pattern2,
      DrawingParameterType.lineWidth2,
      "Line 2 Type",
    );

    addSwitchModel(DrawingParameterType.active3, "Show Line 3");
    addColorModel(DrawingParameterType.color3, "Line 3 Color");
    addLineModel(
      DrawingParameterType.pattern3,
      DrawingParameterType.lineWidth3,
      "Line 3 Type",
    );

    deviationSetting = deviationItem;

    return deviationItem;
  }
}
