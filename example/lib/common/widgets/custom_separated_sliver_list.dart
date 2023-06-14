import 'dart:math' as math;

import 'package:example/common/const/const.dart';
import 'package:example/common/widgets/animations/custom_fade_in_container.dart';
import 'package:flutter/material.dart';

class CustomSeparatedSliverList extends StatelessWidget {
  const CustomSeparatedSliverList({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
    this.addBottomSafeArea = true,
    this.showFadeInAnimation = true,
    this.customFadeInDuration,
  })  : isList = false,
        children = null,
        super(key: key);

  const CustomSeparatedSliverList.list({
    Key? key,
    this.separatorBuilder,
    this.addBottomSafeArea = true,
    this.showFadeInAnimation = true,
    this.customFadeInDuration,
    required this.children,
  })  : isList = true,
        itemCount = 0,
        itemBuilder = null,
        super(key: key);

  final int itemCount;
  final NullableIndexedWidgetBuilder? itemBuilder;
  final Widget Function(bool? isFull)? separatorBuilder;
  final List<Widget>? children;
  final bool addBottomSafeArea, showFadeInAnimation, isList;
  final Duration? customFadeInDuration;

  @override
  Widget build(BuildContext context) {
    return CustomFadeInContainer.sliver(
      customDuration: showFadeInAnimation
          ? customFadeInDuration
          : const Duration(microseconds: 0),
      child: SliverSafeArea(
        bottom: addBottomSafeArea,
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final int itemIndex = index ~/ 2;

              if (index.isOdd) {
                return isList
                    ? children![itemIndex]
                    : itemBuilder?.call(context, itemIndex);
              }

              if (separatorBuilder != null) {
                return separatorBuilder!
                    .call(index == 0 || index == itemCount * 2);
              }

              return _DefaultSeparatorBuilder(
                isFull: index == 0 || index == itemCount * 2,
              );
            },
            semanticIndexCallback: (_, int localIndex) {
              if (localIndex.isEven) {
                return localIndex ~/ 2;
              }
              return null;
            },
            childCount:
                math.max(0, (isList ? children!.length : itemCount) * 2 + 1),
          ),
        ),
      ),
    );
  }
}

class _DefaultSeparatorBuilder extends StatelessWidget {
  const _DefaultSeparatorBuilder({
    Key? key,
    required this.isFull,
  }) : super(key: key);

  final bool isFull;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isFull)
          Container(
            width: AppConst.kListTileSeparatorIndent,
            height: 1,
            color: Theme.of(context).listTileTheme.tileColor,
          ),
        const Expanded(
          child: Divider(),
        ),
      ],
    );
  }
}
