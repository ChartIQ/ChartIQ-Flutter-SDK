import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/buttons/custom_slidable_button.dart';
import 'package:example/common/widgets/list_tiles/custom_text_list_tile.dart';
import 'package:example/data/model/drawing_tool/drawing_tool_item_model.dart';
import 'package:example/gen/assets.gen.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/screen/home/main_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DrawingToolListItem extends StatelessWidget {
  const DrawingToolListItem({
    Key? key,
    required this.item,
    this.isSelected = false,
    this.isFavourite = false,
    this.isItemDismissible = false,
    required this.onFavouriteSelected,
  }) : super(key: key);

  final DrawingToolItemModel item;
  final bool isSelected, isFavourite, isItemDismissible;
  final ValueChanged<DrawingToolItemModel> onFavouriteSelected;

  Widget _buildSlidableAction(BuildContext context) {
    if (isFavourite) {
      return CustomSlidableButton(
        text: 'Remove',
        onTap: () {
          Slidable.of(context)?.close();
          onFavouriteSelected(item);
        },
        icon: Icons.star_border,
        backgroundColor: ColorName.brillianteAzure,
      );
    }
    return CustomSlidableButton(
      text: context.translate(RemoteLocaleKeys.add),
      onTap: () {
        Slidable.of(context)?.close();
        onFavouriteSelected(item);
      },
      icon: Icons.star,
      backgroundColor: ColorName.brillianteAzure,
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '${context.translate(item.name)} ',
        children: [
          if (isFavourite)
            const WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(
                Icons.star,
                size: 14,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(item.hashCode.toString()),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        dragDismissible: true,
        dismissible: DismissiblePane(
          closeOnCancel: true,
          dismissThreshold: 0.5,
          resizeDuration: const Duration(milliseconds: 200),
          dismissalDuration: const Duration(milliseconds: 200),
          confirmDismiss: () async {
            if (isItemDismissible) return Future.value(true);
            onFavouriteSelected(item);
            return Future.value(false);
          },
          onDismissed: () {
            if (isItemDismissible) onFavouriteSelected(item);
          },
        ),
        children: [
          Builder(builder: (context) {
            return _buildSlidableAction(context);
          })
        ],
      ),
      child: CustomTextListTile.widgetTitle(
        titleWidget: _buildTitle(context),
        leading: SvgPicture.asset(
          item.icon,
          colorFilter: ColorFilter.mode(
            Theme.of(context).iconTheme.color!,
            BlendMode.srcIn,
          ),
        ),
        trailing: isSelected
            ? SvgPicture.asset(
                Assets.icons.check.path,
                colorFilter: const ColorFilter.mode(
                  ColorName.mountainMeadow,
                  BlendMode.srcIn,
                ),
              )
            : null,
        onTap: () {
          context.read<MainVM>().onDrawingToolSelected(item);
          Navigator.of(context, rootNavigator: true).pop();
        },
      ),
    );
  }
}
