import 'package:example/common/utils/bottom_sheet_scroll_physics.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/line_picker_item.dart';
import 'package:example/data/model/drawing_tool/line/line_types_enum.dart';
import 'package:example/gen/localization/app_localizations.gen.dart';
import 'package:flutter/material.dart';

class LinePickerPage extends StatelessWidget {
  const LinePickerPage({
    Key? key,
    this.appBarText,
    this.currentLine,
  }) : super(key: key);

  final String? appBarText;
  final LineTypes? currentLine;

  static const _lines = LineTypes.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModalAppBar(middleText: appBarText ?? L.of(context).selectLineType),
      body: CustomScrollView(
        physics: const BottomSheetScrollPhysics(),
        slivers: [
          SliverSafeArea(
            sliver: SliverPadding(
              padding: const EdgeInsets.only(
                top: 20.0,
                bottom: 10.0,
                left: 16.0,
                right: 16.0,
              ),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  mainAxisExtent: 58,
                  maxCrossAxisExtent: 90,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return LinePickerItem(
                      line: _lines[index],
                      isSelected: currentLine == _lines[index],
                      padding: const EdgeInsets.all(12),
                      onTap: () => Navigator.of(context, rootNavigator: true)
                          .pop(_lines[index]),
                    );
                  },
                  childCount: _lines.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
