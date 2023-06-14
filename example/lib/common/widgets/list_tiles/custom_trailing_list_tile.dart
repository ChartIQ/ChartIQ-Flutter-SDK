import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTrailingListTile extends StatelessWidget {
  const CustomTrailingListTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.trailingText,
    this.trailing,
    this.onTap,
    this.showChevron = false,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final Widget? trailingText, trailing;
  final VoidCallback? onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      backgroundColor: Theme.of(context).listTileTheme.tileColor,
      onTap: onTap,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!,
      ),
      additionalInfo: trailingText == null
          ? null
          : DefaultTextStyle(
              style: Theme.of(context).textTheme.labelMedium!,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              child: trailingText!,
            ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleSmall,
            )
          : null,
      trailing: showChevron ? const CupertinoListTileChevron() : trailing,
    );
  }
}
