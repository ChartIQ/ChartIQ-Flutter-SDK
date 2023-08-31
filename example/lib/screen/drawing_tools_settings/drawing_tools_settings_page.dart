import 'package:chart_iq/chart_iq.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/common_settings_items/choose_setting_item.dart';
import 'package:example/common/widgets/common_settings_items/color_setting_item.dart';
import 'package:example/common/widgets/common_settings_items/switch_setting_item.dart';
import 'package:example/common/widgets/common_settings_items/text_field_setting_item.dart';
import 'package:example/common/widgets/custom_separated_list_view.dart';
import 'package:example/data/model/drawing_tool/line/line_types_enum.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/screen/drawing_tools_settings/drawing_tools_settings_vm.dart';
import 'package:example/screen/home/widgets/drawing_tool_panel/drawing_tool_panel_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/drawing_tool_settings_item.dart';
import '../../data/model/option_item_model.dart';
import 'widgets/settings_items/settings_items.dart';

class DrawingToolsSettingsScreen extends StatefulWidget {
  const DrawingToolsSettingsScreen({Key? key}) : super(key: key);

  @override
  State<DrawingToolsSettingsScreen> createState() =>
      _DrawingToolsSettingsScreenState();
}

class _DrawingToolsSettingsScreenState
    extends State<DrawingToolsSettingsScreen> {
  late final Future<void> listSetupFuture;

  @override
  void initState() {
    super.initState();
    listSetupFuture = context.read<DrawingToolsSettingsVM>().setupScreen();
  }

  void _onColorChanged(DrawingParameterType param, PickerColor color) async {
    final settingsVM = context.read<DrawingToolsSettingsVM>();
    final drawingToolPanelVM = context.read<DrawingToolPanelVM>();

    await settingsVM.updateParameter(
      param,
      color.hexValueWithHash,
    );
    drawingToolPanelVM.setupInstrumentsList();
  }

  void _onLineChanged(DrawingParameterType typeParam,
      DrawingParameterType widthParam, LineTypes line) async {
    final settingsVM = context.read<DrawingToolsSettingsVM>();
    final drawingToolPanelVM = context.read<DrawingToolPanelVM>();

    await settingsVM.updateLineType(line);
    drawingToolPanelVM.setupInstrumentsList();
  }

  void _onSwitchChanged(DrawingParameterType param, bool value) async {
    final settingsVM = context.read<DrawingToolsSettingsVM>();

    await settingsVM.updateParameter(
      param,
      value,
    );
  }

  void _onNumberChanged(DrawingParameterType param, String value) async {
    final settingsVM = context.read<DrawingToolsSettingsVM>();
    await settingsVM.updateParameter(
      param,
      double.tryParse(value) == null ? '0' : value,
    );
  }

  void _onChooseValueChanged(
      DrawingParameterType param, List<OptionItemModel> value) async {
    final settingsVM = context.read<DrawingToolsSettingsVM>();

    await settingsVM.updateMultipleChoiceParameters(
      param,
      options: value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DrawingToolsSettingsVM>();
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: ModalAppBar(
        onCancel: () {
          FocusScope.of(context).unfocus();
          Navigator.of(context).pop();
        },
        addTopSafeArea: true,
        isBackButtonIcon: true,
        transitionAnimation: true,
        middleText: vm.drawingTool.name,
      ),
      body: CustomSeparatedListView(
        itemCount: vm.settingsList.length,
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemBuilder: (context, index) {
          return _buildSettingItem(context, vm.settingsList[index]);
        },
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, DrawingToolSettingsItem item) {
    switch (item.runtimeType) {
      case DrawingToolSettingsItemColor:
        final setting = item as DrawingToolSettingsItemColor;
        return ColorSettingItem(
          title: setting.title,
          currentColor: setting.color,
          onColorChanged: (color) => _onColorChanged(setting.param, color),
        );
      case DrawingToolSettingsItemLine:
        return LineSettingsItem(
          item: item as DrawingToolSettingsItemLine,
          onLineChanged: _onLineChanged,
        );
      case DrawingToolSettingsItemChooseValue:
        final setting = item as DrawingToolSettingsItemChooseValue;
        return ChooseSettingItem(
          title: setting.title,
          secondaryText: setting.secondaryText,
          isMultipleSelection: setting.isMultipleSelection,
          hasNegativeValueSupport: setting.hasNegativeValueSupport,
          hasCustomValueSupport: setting.hasCustomValueSupport,
          options: setting.options,
          onChanged: (options) => _onChooseValueChanged(setting.param, options),
        );
      case DrawingToolSettingsItemStyle:
        return StyleSettingItem(
          item: item as DrawingToolSettingsItemStyle,
        );
      case DrawingToolSettingsItemSwitch:
        final setting = item as DrawingToolSettingsItemSwitch;
        return SwitchSettingItem(
          title: setting.title,
          value: setting.isChecked,
          onChanged: (value) => _onSwitchChanged(setting.param, value),
        );
      case DrawingToolSettingsItemNumber:
        final setting = item as DrawingToolSettingsItemNumber;
        return TextFieldSettingItem.number(
            title: setting.title,
            value: setting.number.toString(),
            onChanged: (value) {
              _onNumberChanged(
                setting.param,
                value != null &&
                        value.isNotEmpty &&
                        (double.tryParse(value) != null)
                    ? value
                    : '0',
              );
            });
      case DrawingToolSettingsItemDeviation:
        return DeviationSettingsItem(
          item: item as DrawingToolSettingsItemDeviation,
        );
      default:
        return const SizedBox();
    }
  }
}
