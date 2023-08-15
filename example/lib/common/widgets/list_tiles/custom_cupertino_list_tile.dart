import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

const double _kLeadingSize = 28.0;
const double _kNotchedLeadingSize = 30.0;
const double _kMinHeight = _kLeadingSize + 2 * 8.0;
const double _kMinHeightWithSubtitle = _kLeadingSize + 2 * 10.0;
const double _kNotchedMinHeight = _kNotchedLeadingSize + 2 * 12.0;
const double _kNotchedMinHeightWithoutLeading = _kNotchedLeadingSize + 2 * 10.0;
const EdgeInsetsDirectional _kPadding =
    EdgeInsetsDirectional.only(start: 20.0, end: 14.0);
const EdgeInsetsDirectional _kPaddingWithSubtitle =
    EdgeInsetsDirectional.only(start: 20.0, end: 14.0);
const EdgeInsets _kNotchedPadding = EdgeInsets.symmetric(horizontal: 14.0);
const EdgeInsetsDirectional _kNotchedPaddingWithoutLeading =
    EdgeInsetsDirectional.fromSTEB(28.0, 10.0, 14.0, 10.0);
const double _kLeadingToTitle = 16.0;
const double _kNotchedLeadingToTitle = 12.0;
const double _kNotchedTitleToSubtitle = 3.0;
const double _kAdditionalInfoToTrailing = 6.0;
const double _kNotchedTitleWithSubtitleFontSize = 16.0;
const double _kSubtitleFontSize = 12.0;
const double _kNotchedSubtitleFontSize = 14.0;

enum _CupertinoListTileType { base, notched }

class CustomCupertinoListTile extends StatefulWidget {
  const CustomCupertinoListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.additionalInfo,
    this.leading,
    this.trailing,
    this.onTap,
    this.backgroundColor,
    this.backgroundColorActivated,
    this.padding,
    this.leadingSize = _kLeadingSize,
    this.leadingToTitle = _kLeadingToTitle,
  }) : _type = _CupertinoListTileType.base;

  const CustomCupertinoListTile.notched({
    super.key,
    required this.title,
    this.subtitle,
    this.additionalInfo,
    this.leading,
    this.trailing,
    this.onTap,
    this.backgroundColor,
    this.backgroundColorActivated,
    this.padding,
    this.leadingSize = _kNotchedLeadingSize,
    this.leadingToTitle = _kNotchedLeadingToTitle,
  }) : _type = _CupertinoListTileType.notched;

  final _CupertinoListTileType _type;

  final Widget title;

  final Widget? subtitle;

  final Widget? additionalInfo;

  final Widget? leading;

  final Widget? trailing;

  final FutureOr<void> Function()? onTap;

  final Color? backgroundColor;

  final Color? backgroundColorActivated;

  final EdgeInsetsGeometry? padding;

  final double leadingSize;

  final double leadingToTitle;

  @override
  State<CustomCupertinoListTile> createState() =>
      _CustomCupertinoListTileState();
}

class _CustomCupertinoListTileState extends State<CustomCupertinoListTile> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    final TextStyle titleTextStyle =
        widget._type == _CupertinoListTileType.base || widget.subtitle == null
            ? CupertinoTheme.of(context).textTheme.textStyle
            : CupertinoTheme.of(context).textTheme.textStyle.merge(
                  TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: widget.leading == null
                        ? _kNotchedTitleWithSubtitleFontSize
                        : null,
                  ),
                );

    final TextStyle subtitleTextStyle =
        widget._type == _CupertinoListTileType.base
            ? CupertinoTheme.of(context).textTheme.textStyle.merge(
                  TextStyle(
                    fontSize: _kSubtitleFontSize,
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                  ),
                )
            : CupertinoTheme.of(context).textTheme.textStyle.merge(
                  TextStyle(
                    fontSize: _kNotchedSubtitleFontSize,
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                  ),
                );

    final TextStyle? additionalInfoTextStyle = widget.additionalInfo != null
        ? CupertinoTheme.of(context).textTheme.textStyle.merge(TextStyle(
            color: CupertinoColors.secondaryLabel.resolveFrom(context)))
        : null;

    final Widget title = DefaultTextStyle(
      style: titleTextStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      child: widget.title,
    );

    EdgeInsetsGeometry? padding = widget.padding;
    if (padding == null) {
      switch (widget._type) {
        case _CupertinoListTileType.base:
          padding = widget.subtitle == null ? _kPadding : _kPaddingWithSubtitle;
          break;
        case _CupertinoListTileType.notched:
          padding = widget.leading == null
              ? _kNotchedPaddingWithoutLeading
              : _kNotchedPadding;
          break;
      }
    }

    Widget? subtitle;
    if (widget.subtitle != null) {
      subtitle = DefaultTextStyle(
        style: subtitleTextStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        child: widget.subtitle!,
      );
    }

    Widget? additionalInfo;
    if (widget.additionalInfo != null) {
      additionalInfo = DefaultTextStyle(
        style: additionalInfoTextStyle!,
        maxLines: 1,
        child: widget.additionalInfo!,
      );
    }

    Color? backgroundColor = widget.backgroundColor;
    if (_tapped) {
      backgroundColor = widget.backgroundColorActivated ??
          CupertinoColors.systemGrey4.resolveFrom(context);
    }

    double minHeight;
    switch (widget._type) {
      case _CupertinoListTileType.base:
        minHeight = subtitle == null ? _kMinHeight : _kMinHeightWithSubtitle;
        break;
      case _CupertinoListTileType.notched:
        minHeight = widget.leading == null
            ? _kNotchedMinHeightWithoutLeading
            : _kNotchedMinHeight;
        break;
    }

    final Widget child = Container(
      constraints:
          BoxConstraints(minWidth: double.infinity, minHeight: minHeight),
      color: backgroundColor,
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            if (widget.leading != null) ...<Widget>[
              SizedBox(
                width: widget.leadingSize,
                height: widget.leadingSize,
                child: Center(
                  child: widget.leading,
                ),
              ),
              SizedBox(width: widget.leadingToTitle),
            ] else
              SizedBox(height: widget.leadingSize),
            Expanded(
              flex: widget.trailing != null ? 1 : 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title,
                  if (subtitle != null) ...<Widget>[
                    const SizedBox(height: _kNotchedTitleToSubtitle),
                    subtitle,
                  ],
                ],
              ),
            ),
            if (additionalInfo != null) ...<Widget>[
              Expanded(child: additionalInfo),
              if (widget.trailing != null)
                const SizedBox(width: _kAdditionalInfoToTrailing),
            ],
            if (widget.trailing != null)
              Align(alignment: Alignment.centerRight, child: widget.trailing!)
          ],
        ),
      ),
    );

    if (widget.onTap == null) {
      return child;
    }

    return GestureDetector(
      onTapDown: (_) => setState(() {
        _tapped = true;
      }),
      onTapCancel: () => setState(() {
        _tapped = false;
      }),
      onTap: () async {
        await widget.onTap!();
        if (mounted) {
          setState(() {
            _tapped = false;
          });
        }
      },
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
