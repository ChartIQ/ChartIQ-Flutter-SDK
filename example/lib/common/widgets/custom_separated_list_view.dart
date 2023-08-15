import 'package:example/common/const/const.dart';
import 'package:example/common/widgets/animations/custom_fade_in_container.dart';
import 'package:flutter/material.dart';

class CustomSeparatedListView extends StatelessWidget {
  const CustomSeparatedListView({
    Key? key,
    this.shrinkWrap = true,
    this.physics,
    this.padding,
    this.dividerIndent = AppConst.kListTileSeparatorIndent,
    this.separatorBuilder,
    this.showOuterDividers = true,
    this.controller,
    this.showFadeInAnimation = true,
    this.customFadeInDuration,
    required this.itemCount,
    required this.itemBuilder,
  })  : isList = false,
        children = null,
        super(key: key);

  const CustomSeparatedListView.list({
    Key? key,
    this.shrinkWrap = true,
    this.physics,
    this.padding,
    this.dividerIndent = AppConst.kListTileSeparatorIndent,
    this.separatorBuilder,
    this.showOuterDividers = true,
    this.controller,
    this.showFadeInAnimation = true,
    this.customFadeInDuration,
    required this.children,
  })  : isList = true,
        itemCount = 0,
        itemBuilder = null,
        super(key: key);

  final NullableIndexedWidgetBuilder? itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final List<Widget>? children;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final int itemCount;
  final EdgeInsets? padding;
  final double? dividerIndent;
  final bool isList, showOuterDividers, showFadeInAnimation;
  final Duration? customFadeInDuration;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return CustomFadeInContainer(
      customDuration: showFadeInAnimation
          ? customFadeInDuration
          : const Duration(microseconds: 0),
      child: SingleChildScrollView(
        physics: physics,
        controller: controller,
        child: SafeArea(
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 0),
            child: Column(
              children: [
                if (showOuterDividers) const Divider(),
                if (isList) ...[
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: shrinkWrap,
                    itemCount: children!.length,
                    itemBuilder: (context, index) => children![index],
                    separatorBuilder: separatorBuilder ??
                        (_, __) =>
                            _DefaultSeparatorBuilder(indent: dividerIndent),
                  ),
                ] else
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: shrinkWrap,
                    itemCount: itemCount,
                    itemBuilder: itemBuilder!,
                    separatorBuilder: separatorBuilder ??
                        (_, __) =>
                            _DefaultSeparatorBuilder(indent: dividerIndent),
                  ),
                if (showOuterDividers) const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DefaultSeparatorBuilder extends StatelessWidget {
  const _DefaultSeparatorBuilder({
    Key? key,
    this.indent,
  }) : super(key: key);

  final double? indent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: indent,
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
