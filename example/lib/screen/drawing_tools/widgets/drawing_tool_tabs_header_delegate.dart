import 'package:example/common/widgets/custom_choice_chip.dart';
import 'package:example/data/model/drawing_tool/drawing_tool_category.dart';
import 'package:flutter/material.dart';

class DrawingToolTabsHeaderDelegate extends SliverPersistentHeaderDelegate {
  DrawingToolTabsHeaderDelegate({
    required this.selectedCategory,
    required this.onSelected,
  });

  final DrawingToolCategory selectedCategory;
  final ValueChanged<DrawingToolCategory> onSelected;

  final _categories = DrawingToolCategory.values
      .where((element) => element != DrawingToolCategory.none)
      .toList();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Material(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
          ),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (_, index) {
              final item = _categories[index];
              final key = GlobalKey();
              return CustomChoiceChip(
                key: key,
                label: Text(item.getTranslatedTitle(context)),
                isSelected: item == selectedCategory,
                onSelected: (_) {
                  Scrollable.ensureVisible(
                    key.currentContext!,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    alignment: 0.5,
                    alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
                  );
                  onSelected(item);
                },
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 12),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
