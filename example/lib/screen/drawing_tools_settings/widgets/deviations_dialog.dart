import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/common_settings_items/color_setting_item.dart';
import 'package:example/common/widgets/common_settings_items/switch_setting_item.dart';
import 'package:example/common/widgets/custom_separated_list_view.dart';
import 'package:example/common/widgets/custom_separated_sliver_list.dart';
import 'package:example/common/widgets/spacing.dart';
import 'package:example/data/model/drawing_tool/line/line_types_enum.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/screen/drawing_tools_settings/drawing_tools_settings_vm.dart';
import 'package:example/screen/drawing_tools_settings/model/drawing_tool_settings_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'settings_items/settings_items.dart';

class DeviationsDialog extends StatefulWidget {
  const DeviationsDialog({
    Key? key,
    required this.settingsItem,
  }) : super(key: key);

  final DrawingToolSettingsItemDeviation settingsItem;

  @override
  State<DeviationsDialog> createState() => _DeviationsDialogState();
}

class _DeviationsDialogState extends State<DeviationsDialog> {
  late List<List<DrawingToolSettingsItem>> chunkedSettings;

  @override
  void initState() {
    super.initState();
    chunkedSettings = _splitToChunks(widget.settingsItem.settings, 3);
  }

  @override
  void didUpdateWidget(covariant DeviationsDialog oldWidget) {
    setState(() {
      chunkedSettings = _splitToChunks(widget.settingsItem.settings, 3);
    });
    super.didUpdateWidget(oldWidget);
  }

  void _onColorChanged(DrawingParameterType param, PickerColor color) async {
    final settingsVM = context.read<DrawingToolsSettingsVM>();

    await settingsVM.updateParameter(
      param,
      color.hexValueWithHash,
    );
  }

  void _onLineChanged(DrawingParameterType typeParam,
      DrawingParameterType widthParam, LineTypes line) async {
    final settingsVM = context.read<DrawingToolsSettingsVM>();

    await settingsVM.updateLineType(
      line,
      lineTypeParam: typeParam,
      lineWidthParam: widthParam,
    );
  }

  void _onSwitchChanged(DrawingParameterType param, bool value) async {
    final settingsVM = context.read<DrawingToolsSettingsVM>();

    await settingsVM.updateParameter(
      param,
      value.toString(),
    );
  }

  List<List<T>> _splitToChunks<T>(List<T> list, int chunkSize) {
    List<List<T>> chunks = [];
    int len = list.length;
    for (var i = 0; i < len; i += chunkSize) {
      int size = i + chunkSize;
      chunks.add(list.sublist(i, size > len ? len : size));
    }
    return chunks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: ModalAppBar(
        addTopSafeArea: true,
        isBackButtonIcon: true,
        middleText: widget.settingsItem.title,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: VerticalSpacing(40)),
          CustomSeparatedSliverList(
            itemCount: chunkedSettings.length,
            separatorBuilder: (_) => const VerticalSpacing(40),
            itemBuilder: (context, index) {
              final chunk = chunkedSettings[index];
              return CustomSeparatedListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: chunk.length,
                itemBuilder: (context, i) => _buildSettingItem(
                  context,
                  chunk[i],
                ),
              );
            },
          ),
          const SliverToBoxAdapter(child: VerticalSpacing(40)),
        ],
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
      case DrawingToolSettingsItemSwitch:
        final setting = item as DrawingToolSettingsItemSwitch;
        return SwitchSettingItem(
          title: setting.title,
          value: setting.isChecked,
          onChanged: (value) => _onSwitchChanged(setting.param, value),
        );
      default:
        return const SizedBox();
    }
  }
}
