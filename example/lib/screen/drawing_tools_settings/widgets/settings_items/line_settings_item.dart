import 'package:chart_iq/chart_iq.dart';
import 'package:example/common/widgets/list_tiles/custom_text_list_tile.dart';
import 'package:example/common/widgets/modals/app_bottom_sheet.dart';
import 'package:example/data/model/drawing_tool/line/line_types_enum.dart';
import 'package:example/screen/drawing_tools_settings/model/drawing_tool_settings_item.dart';
import 'package:example/screen/line_picker/color_picker_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef LineTypeChanged = void Function(
  DrawingParameterType type,
  DrawingParameterType width,
  LineTypes,
);

class LineSettingsItem extends StatefulWidget {
  const LineSettingsItem({
    Key? key,
    required this.item,
    required this.onLineChanged,
  }) : super(key: key);

  final DrawingToolSettingsItemLine item;

  final LineTypeChanged onLineChanged;

  @override
  State<LineSettingsItem> createState() => _LineSettingsItemState();
}

class _LineSettingsItemState extends State<LineSettingsItem> {
  Future<void> _openLinePicker(
    BuildContext context, {
    required DrawingToolSettingsItemLine item,
  }) async {
    final newLine = await showAppBottomSheet<LineTypes>(
      context: context,
      builder: (context) {
        return LinePickerPage(
          currentLine: item.line,
        );
      },
    );

    if (!mounted || newLine == null) return;

    widget.onLineChanged.call(
      widget.item.lineTypeParam,
      widget.item.lineWidthParam,
      newLine,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextListTile(
      onTap: () => _openLinePicker(
        context,
        item: widget.item,
      ),
      title: widget.item.title,
      trailing: SizedBox(
        width: 32,
        child: SvgPicture.asset(
          widget.item.line.icon,
          colorFilter: ColorFilter.mode(
            Theme.of(context).iconTheme.color!,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
