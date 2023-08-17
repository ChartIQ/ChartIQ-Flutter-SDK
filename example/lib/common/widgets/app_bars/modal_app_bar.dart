import 'dart:ui';

import 'package:example/common/widgets/buttons/app_bar_text_button.dart';
import 'package:example/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalAppBar extends StatelessWidget implements PreferredSizeWidget {
  ModalAppBar({
    Key? key,
    required this.middleText,
    this.onCancel,
    this.isBackButtonIcon = false,
    this.trailingWidget,
    this.addTopSafeArea = false,
    this.showBottomLine = true,
    this.rootNavigatorForBackButton = true,
    this.transitionAnimation = false,
  }) : super(key: key);

  final bool isBackButtonIcon;
  final String middleText;
  final VoidCallback? onCancel;
  final Widget? trailingWidget;
  final bool addTopSafeArea,
      showBottomLine,
      rootNavigatorForBackButton,
      transitionAnimation;

  final logicalSize = window.physicalSize / window.devicePixelRatio;

  /*@override
  Size get preferredSize =>
      Size.fromHeight(logicalSize.shortestSide <= 700 ? 55 : 45);*/

  @override
  Size get preferredSize => const Size.fromHeight(55);

  Widget _getBackButton(BuildContext context) {
    final isLtr = Directionality.of(context) == TextDirection.ltr;
    if (isBackButtonIcon) {
      return AppBarTextButton(
        onPressed: () => onCancel != null
            ? onCancel?.call()
            : Navigator.of(context, rootNavigator: rootNavigatorForBackButton)
                .pop(),
        padding: EdgeInsets.only(right: isLtr ? 16 : 0, left: isLtr ? 0 : 16),
        child: Text(
          String.fromCharCode(CupertinoIcons.back.codePoint),
          style: TextStyle(
            fontSize: 30,
            fontFamily: CupertinoIcons.back.fontFamily,
            package: CupertinoIcons.back.fontPackage,
          ),
        ),
      );
    }

    return AppBarTextButton(
      onPressed: () => onCancel != null
          ? onCancel?.call()
          : Navigator.of(context, rootNavigator: rootNavigatorForBackButton)
              .pop(),
      child: const Text('Cancel'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: SizedBox(
        height: 200,
        child: CupertinoTheme(
          data: CupertinoThemeData(
            brightness: Theme.of(context).brightness,
            primaryColor: Theme.of(context).primaryColor,
            barBackgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          ),
          child: CupertinoNavigationBar(
            transitionBetweenRoutes: transitionAnimation,
            border: Border(
              bottom: BorderSide(
                color: context.colors.modalAppBarUnderlineColor!,
                width: 0.3,
              ),
            ),
            leading: _getBackButton(context),
            automaticallyImplyLeading: true,
            middle: Text(
              middleText,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            trailing: trailingWidget ?? const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
