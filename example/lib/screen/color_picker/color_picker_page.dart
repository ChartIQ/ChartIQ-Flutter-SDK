import 'package:example/common/const/const.dart';
import 'package:example/common/utils/bottom_sheet_scroll_physics.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/color_picker_item.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/gen/localization/app_localizations.gen.dart';
import 'package:flutter/material.dart';

class ColorPickerPage extends StatelessWidget {
  const ColorPickerPage({
    Key? key,
    this.appBarText,
    this.currentColor,
  }) : super(key: key);

  final String? appBarText;
  final PickerColor? currentColor;

  static const _colors = AppConst.defaultPickerColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModalAppBar(middleText: appBarText ?? L.of(context).selectColor),
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 5
                          : 11,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  childAspectRatio: 1 / 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ColorPickerItem(
                      color: _colors[index],
                      isSelected:
                          currentColor?.getPickerColorWithAuto(context) ==
                              _colors[index],
                      padding: const EdgeInsets.all(12),
                      onTap: () => Navigator.of(context, rootNavigator: true)
                          .pop(_colors[index]),
                    );
                  },
                  childCount: _colors.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
