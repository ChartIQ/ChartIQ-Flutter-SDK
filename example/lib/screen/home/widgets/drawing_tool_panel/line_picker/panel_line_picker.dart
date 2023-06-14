import 'package:example/common/widgets/line_picker_item.dart';
import 'package:example/common/widgets/spacing.dart';
import 'package:example/data/model/drawing_tool/line/line_types_enum.dart';
import 'package:example/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PanelLinePicker extends StatefulWidget {
  const PanelLinePicker({
    Key? key,
    this.selectedLineType,
    this.onLineTypeSelected,
  }) : super(key: key);

  final LineTypes? selectedLineType;
  final ValueChanged<LineTypes>? onLineTypeSelected;

  @override
  State<PanelLinePicker> createState() => _PanelLinePickerState();
}

class _PanelLinePickerState extends State<PanelLinePicker> {
  final _lines = LineTypes.values;

  final keys = List.generate(LineTypes.values.length, (index) => GlobalKey());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final indexOfSelectedLine =
          _lines.indexOf(widget.selectedLineType ?? _lines.first);
      if (indexOfSelectedLine != -1) {
        Scrollable.ensureVisible(
          keys[indexOfSelectedLine].currentContext!,
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
                  ..._lines.map((line) {
                    final index = _lines.indexOf(line);
                    return Container(
                      width: 58,
                      height: 44,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: LinePickerItem(
                        padding: const EdgeInsets.all(6),
                        key: keys[index],
                        line: line,
                        isSelected: widget.selectedLineType == line,
                        onTap: () => widget.onLineTypeSelected?.call(line),
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
