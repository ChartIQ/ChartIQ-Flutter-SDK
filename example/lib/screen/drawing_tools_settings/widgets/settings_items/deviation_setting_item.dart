import 'package:example/common/widgets/list_tiles/custom_text_list_tile.dart';
import 'package:example/screen/drawing_tools_settings/drawing_tools_settings_vm.dart';
import 'package:example/screen/drawing_tools_settings/model/drawing_tool_settings_item.dart';
import 'package:example/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../deviations_dialog.dart';

class DeviationSettingsItem extends StatelessWidget {
  const DeviationSettingsItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final DrawingToolSettingsItemDeviation item;

  @override
  Widget build(BuildContext context) {
    return CustomTextListTile(
      title: item.title,
      trailing: Icon(
        Icons.arrow_forward_ios_sharp,
        size: 20,
        color: context.colors.listTileTrailingIconColor,
      ),
      onTap: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) {
            return ChangeNotifierProvider<DrawingToolsSettingsVM>.value(
              value: context.read<DrawingToolsSettingsVM>(),
              builder: (c, _) {
                return DeviationsDialog(
                  settingsItem:
                      c.watch<DrawingToolsSettingsVM>().deviationSetting!,
                );
              },
            );
          },
        );
      },
    );
  }
}
