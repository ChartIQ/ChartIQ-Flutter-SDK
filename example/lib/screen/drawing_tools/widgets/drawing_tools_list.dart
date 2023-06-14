import 'package:example/common/widgets/custom_separated_sliver_list.dart';
import 'package:example/data/model/drawing_tool/drawing_tool_item_model.dart';
import 'package:example/screen/drawing_tools/widgets/drawing_tool_list_item.dart';
import 'package:example/screen/home/main_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawingToolsList extends StatelessWidget {
  const DrawingToolsList({
    Key? key,
    required this.items,
    required this.favouriteItems,
    this.addBottomSafeArea = false,
    this.isItemDismissible = false,
    required this.onFavoriteSelected,
  }) : super(key: key);

  final List<DrawingToolItemModel> items, favouriteItems;
  final bool addBottomSafeArea, isItemDismissible;
  final ValueChanged<DrawingToolItemModel> onFavoriteSelected;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainVM>(
      builder: (_, vm, __) => CustomSeparatedSliverList(
        itemCount: items.length,
        addBottomSafeArea: addBottomSafeArea,
        customFadeInDuration: const Duration(milliseconds: 0),
        itemBuilder: (_, index) {
          return DrawingToolListItem(
            item: items[index],
            isSelected: vm.selectedDrawingTool == items[index],
            isFavourite: favouriteItems.contains(items[index]),
            onFavouriteSelected: onFavoriteSelected,
            isItemDismissible: isItemDismissible,
          );
        },
      ),
    );
  }
}
