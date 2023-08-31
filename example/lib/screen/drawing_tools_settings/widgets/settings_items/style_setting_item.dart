import 'package:chart_iq/chart_iq.dart';
import 'package:example/screen/drawing_tools_settings/drawing_tools_settings_vm.dart';
import 'package:example/screen/drawing_tools_settings/model/drawing_tool_settings_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../font_style_list_tile.dart';

class StyleSettingItem extends StatelessWidget {
  const StyleSettingItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final DrawingToolSettingsItemStyle item;

  void _updateParameter(
      BuildContext context, DrawingParameterType param, String value) {
    context.read<DrawingToolsSettingsVM>().updateParameter(param, value);
  }

  @override
  Widget build(BuildContext context) {
    return FontStyleListTile(
      isBold: item.isBold,
      isItalic: item.isItalic,
      onBoldTap: () => _updateParameter(
        context,
        item.weightParam,
        item.isBold ? 'normal' : 'bold',
      ),
      onItalicTap: () => _updateParameter(
        context,
        item.styleParam,
        item.isItalic ? 'normal' : 'italic',
      ),
    );
  }
}
