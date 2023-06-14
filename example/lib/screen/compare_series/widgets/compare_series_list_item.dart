import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/buttons/custom_slidable_button.dart';
import 'package:example/common/widgets/list_tiles/custom_text_list_tile.dart';
import 'package:example/common/widgets/modals/app_bottom_sheet.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/screen/color_picker/color_picker_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CompareSeriesListItem extends StatefulWidget {
  const CompareSeriesListItem({
    Key? key,
    required this.series,
    required this.onRemoveSeries,
    required this.onSeriesColorChanged,
  }) : super(key: key);

  final Series series;
  final ValueChanged<Series> onRemoveSeries;
  final ValueChanged<PickerColor> onSeriesColorChanged;

  @override
  State<CompareSeriesListItem> createState() => _CompareSeriesListItemState();
}

class _CompareSeriesListItemState extends State<CompareSeriesListItem> {
  Future<void> _openColorPicker(
      BuildContext context, {
        required PickerColor currentColor,
      }) async {
    final newColor = await showAppBottomSheet<PickerColor>(
      context: context,
      builder: (context) {
        return ColorPickerPage(
          currentColor: currentColor,
        );
      },
    );
    if (!mounted || newColor == null) return;
    widget.onSeriesColorChanged(newColor);
  }

  @override
  Widget build(BuildContext context) {
    final symbolColor = PickerColor(widget.series.color);
    return Slidable(
      key: ValueKey(widget.series.hashCode),
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        dismissible: DismissiblePane(
          onDismissed: () => widget.onRemoveSeries(widget.series),
        ),
        dragDismissible: true,
        extentRatio: 0.2,
        children: [
          CustomSlidableButton(
            text: context.translateWatch(RemoteLocaleKeys.delete),
            onTap: () => widget.onRemoveSeries(widget.series),
          ),
        ],
      ),
      child: CustomTextListTile(
        title: widget.series.symbolName,
        trailing: InkWell(
          onTap: () => _openColorPicker(
            context,
            currentColor: symbolColor,
          ),
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: symbolColor.getColorWithAuto(context),
              borderRadius: BorderRadius.circular(2),
              border: Border.fromBorderSide(
                Theme.of(context).chipTheme.shape!.side,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
