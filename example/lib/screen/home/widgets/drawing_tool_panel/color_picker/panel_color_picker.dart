import 'package:example/common/const/const.dart';
import 'package:example/common/widgets/color_picker_item.dart';
import 'package:example/common/widgets/spacing.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PanelColorPicker extends StatefulWidget {
  const PanelColorPicker({
    Key? key,
    this.selectedColor,
    this.onColorSelected,
  }) : super(key: key);

  final PickerColor? selectedColor;
  final ValueChanged<PickerColor>? onColorSelected;

  @override
  State<PanelColorPicker> createState() => _PanelColorPickerState();
}

class _PanelColorPickerState extends State<PanelColorPicker> {
  final _colors = AppConst.defaultPickerColors;

  final keys = List.generate(
    AppConst.defaultPickerColors.length,
    (index) => GlobalKey(),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final indexOfSelectedColor =
          _colors.indexOf(widget.selectedColor ?? _colors.first);
      if (indexOfSelectedColor != -1) {
        Scrollable.ensureVisible(
          keys[indexOfSelectedColor].currentContext!,
          alignment: 0.5,
          duration: const Duration(milliseconds: 300),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      color: context.colors.drawingToolPanelPickerBackgroundColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Row(
                children: [
                  const HorizontalSpacing(8),
                  ..._colors.map((color) {
                    final index = _colors.indexOf(color);
                    return Container(
                      width: 44,
                      height: 44,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: ColorPickerItem(
                        padding: const EdgeInsets.all(6),
                        key: keys[index],
                        color: color,
                        isSelected: widget.selectedColor == color,
                        onTap: () => widget.onColorSelected?.call(color),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            const HorizontalSpacing(8),
          ],
        ),
      ),
    );
  }
}
