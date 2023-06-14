import 'package:example/common/widgets/list_tiles/custom_text_list_tile.dart';
import 'package:example/common/widgets/modals/app_bottom_sheet.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/screen/color_picker/color_picker_page.dart';
import 'package:flutter/material.dart';

class ColorSettingItem extends StatefulWidget {
  const ColorSettingItem({
    Key? key,
    required this.title,
    required this.currentColor,
    required this.onColorChanged,
    this.useRootNavigator = false,
  }) : super(key: key);

  final String title;
  final PickerColor currentColor;
  final void Function(PickerColor) onColorChanged;
  final bool useRootNavigator;

  @override
  State<ColorSettingItem> createState() => _ColorSettingItemState();
}

class _ColorSettingItemState extends State<ColorSettingItem> {
  void _openColorPicker(
    BuildContext context,
  ) async {
    final newColor = await showAppBottomSheet<PickerColor>(
      context: context,
      useRootNavigator: widget.useRootNavigator,
      builder: (context) {
        return ColorPickerPage(
          currentColor: widget.currentColor,
        );
      },
    );
    if (!mounted || newColor == null) return;
    widget.onColorChanged.call(newColor);
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextListTile(
      title: widget.title,
      onTap: () => _openColorPicker(
        context,
      ),
      trailing: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: widget.currentColor.getColorWithAuto(context),
          borderRadius: BorderRadius.circular(2),
          border: Border.fromBorderSide(
            Theme.of(context).chipTheme.shape!.side,
          ),
        ),
      ),
    );
  }
}
