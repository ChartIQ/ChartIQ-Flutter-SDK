import 'package:example/common/widgets/list_tiles/custom_text_list_tile.dart';
import 'package:example/data/model/condition_item.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ConditionInfoItem extends StatelessWidget {
  const ConditionInfoItem({
    Key? key,
    required this.condition,
    required this.showSignalPreview,
    required this.onTap,
  }) : super(key: key);

  final ConditionItem condition;
  final bool showSignalPreview;
  final ValueChanged<ConditionItem> onTap;

  static const _kDefaultLabel = 'X';

  Color _getLeadingTextColor(BuildContext context) =>
      condition.displayColor.getColorWithAuto(context).computeLuminance() > .5
          ? ColorName.black
          : ColorName.white;

  String get _label => condition.condition.markerOption.label != null &&
          condition.condition.markerOption.label!.isNotEmpty
      ? condition.condition.markerOption.label!
      : _kDefaultLabel;

  @override
  Widget build(BuildContext context) {
    return CustomTextListTile(
      onTap: () => onTap(condition),
      title: condition.title,
      minLeadingWidth: 0,
      subtitle: condition.description,
      trailing: Icon(
        Icons.arrow_forward_ios_sharp,
        size: 20,
        color: context.colors.listTileTrailingIconColor,
      ),
      leading: !showSignalPreview
          ? null
          : Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: condition.displayColor.getColorWithAuto(context),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  _label,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: _getLeadingTextColor(context)),
                ),
              ),
            ),
    );
  }
}
