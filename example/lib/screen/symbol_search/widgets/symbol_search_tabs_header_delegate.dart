
// to allow floating filter above the list
import 'package:example/common/widgets/custom_choice_chip.dart';
import 'package:example/screen/symbol_search/symbol_filter_enum.dart';
import 'package:flutter/material.dart';

class SymbolSearchTabsHeaderDelegate extends SliverPersistentHeaderDelegate {
  const SymbolSearchTabsHeaderDelegate({
    required this.selectedFilter,
    required this.onSelected,
  });

  final SymbolFilter selectedFilter;
  final ValueChanged<SymbolFilter> onSelected;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: SymbolFilter.values.length,
          itemBuilder: (_, index) {
            final item = SymbolFilter.values[index];
            final key = GlobalKey();
            return CustomChoiceChip(
              key: key,
              label: Text(item.getTranslatedTitle(context)),
              isSelected: item == selectedFilter,
              onSelected: (_) {
                Scrollable.ensureVisible(
                  key.currentContext!,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  alignment: 0.5,
                );
                onSelected(item);
              },
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 12),
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