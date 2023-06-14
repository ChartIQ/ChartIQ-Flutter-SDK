import 'package:example/common/widgets/common_settings_items/widgets/text_field_list_tile.dart';
import 'package:example/common/widgets/modals/app_bottom_sheet.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/screen/color_picker/color_picker_page.dart';
import 'package:flutter/material.dart';

class ColorNumberListSettingItem extends StatefulWidget {
  const ColorNumberListSettingItem({
    Key? key,
    required this.title,
    required this.numberValue,
    required this.onNumberChanged,
    required this.colorValue,
    required this.onColorChanged,
  }) : super(key: key);

  final String title, numberValue;
  final PickerColor colorValue;
  final ValueChanged<String?> onNumberChanged;
  final ValueChanged<PickerColor> onColorChanged;

  @override
  State<ColorNumberListSettingItem> createState() => _ColorNumberListSettingItemState();
}

class _ColorNumberListSettingItemState extends State<ColorNumberListSettingItem> {
  void _openColorPicker(
      BuildContext context,
      ) async {
    final newColor = await showAppBottomSheet<PickerColor>(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return ColorPickerPage(
          currentColor: widget.colorValue,
        );
      },
    );
    if (!mounted || newColor == null) return;
    widget.onColorChanged.call(newColor);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: TextFieldListTile.number(
          title: widget.title,
          value: widget.numberValue,
          onChanged: widget.onNumberChanged,
          trailing: GestureDetector(
            onTap: () => _openColorPicker(context),
            child: Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                color: widget.colorValue.getColorWithAuto(context),
                borderRadius: BorderRadius.circular(2),
                border: Border.fromBorderSide(
                  Theme.of(context).chipTheme.shape!.side,
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
