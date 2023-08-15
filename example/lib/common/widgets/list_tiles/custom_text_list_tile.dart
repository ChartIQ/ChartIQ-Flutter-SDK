import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextListTile extends StatelessWidget {
  const CustomTextListTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.leading,
    this.dense,
    this.minLeadingWidth,
    this.showChevron = false,
  })  : isWidgetTitle = false,
        titleWidget = null,
        super(key: key);

  const CustomTextListTile.widgetTitle({
    Key? key,
    required this.titleWidget,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.leading,
    this.dense,
    this.minLeadingWidth,
    this.showChevron = false,
  })  : isWidgetTitle = true,
        title = null,
        super(key: key);

  final String? title;
  final Widget? titleWidget;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing, leading;
  final bool isWidgetTitle, showChevron;
  final bool? dense;
  final double? minLeadingWidth;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      onTap: onTap,
      backgroundColor: Theme.of(context).listTileTheme.tileColor,
      leading: leading,
      trailing: showChevron ? const CupertinoListTileChevron() : trailing,
      title: DefaultTextStyle(
        style: Theme.of(context).textTheme.titleMedium!,
        child: isWidgetTitle ? titleWidget! : Text(title!),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: Theme.of(context).textTheme.titleSmall,
            )
          : null,
    );
  }
}
