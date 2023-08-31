import 'package:example/common/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTitleTrailingListTile extends StatelessWidget {
  const CustomTitleTrailingListTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.trailingText,
    this.trailing,
    this.onTap,
    this.visualDensity,
    this.dense = false,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final Widget? trailingText, trailing;
  final VoidCallback? onTap;
  final VisualDensity? visualDensity;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      backgroundColor: Theme.of(context).listTileTheme.tileColor,
      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 14.0, 10.0),
      onTap: onTap,
      title: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!,
          ),
          if (trailingText != null) ...[
            const HorizontalSpacing(16),
            Expanded(
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.labelMedium!,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                child: trailingText!,
              ),
            ),
          ]
        ],
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleSmall,
            )
          : null,
      trailing: trailing,
    );
  }
}
