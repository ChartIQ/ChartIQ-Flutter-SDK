import 'package:example/common/widgets/custom_cupertino_search_field.dart';
import 'package:flutter/material.dart';

class AddStudiesSearchDelegate extends SliverPersistentHeaderDelegate {
  const AddStudiesSearchDelegate({
    required this.onChanged,
  });

  final ValueChanged<String?> onChanged;

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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: CustomCupertinoSearchField(
            autofocus: false,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 56;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
