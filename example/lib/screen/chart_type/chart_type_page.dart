import 'package:chart_iq/chartiq_flutter_sdk.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/bottom_sheet_scroll_physics.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/custom_separated_list_view.dart';
import 'package:example/common/widgets/list_tiles/custom_text_list_tile.dart';
import 'package:example/data/model/chart_style_item_type_model.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/screen/chart_type/chart_type_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChartTypePage extends StatefulWidget {
  const ChartTypePage({
    Key? key,
    this.selectedStyle,
  }) : super(key: key);

  final ChartTypeItemModel? selectedStyle;

  @override
  State<ChartTypePage> createState() => _ChartTypePageState();
}

class _ChartTypePageState extends State<ChartTypePage> {
  final _allStyles = [
    ChartType.values.map(
      (e) => e.toModel(),
    ),
    ChartAggregationType.values.map(
      (e) => e.toModel(),
    ),
  ].expand((element) => element).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModalAppBar(
        middleText: context.translateWatch(RemoteLocaleKeys.chartStyle),
      ),
      body: CustomSeparatedListView(
        physics: const BottomSheetScrollPhysics(),
        dividerIndent: 65,
        itemCount: _allStyles.length,
        itemBuilder: (_, index) {
          final style = _allStyles[index];
          return CustomTextListTile(
              title: context.translateWatch(style.title),
              leading: SvgPicture.asset(
                style.icon,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).iconTheme.color!,
                  BlendMode.srcIn,
                ),
              ),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop(style);
              },
              trailing: widget.selectedStyle == style
                  ? const Icon(
                      Icons.check,
                      color: ColorName.mountainMeadow,
                    )
                  : null);
        },
      ),
    );
  }
}
