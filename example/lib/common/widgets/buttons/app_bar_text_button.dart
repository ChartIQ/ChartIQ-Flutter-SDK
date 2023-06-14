import 'package:example/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarTextButton extends StatelessWidget {
  const AppBarTextButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.padding,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w400,
                color: ColorName.mountainMeadow,
              ),
        ),
        primaryColor: ColorName.mountainMeadow,
      ),
      child: CupertinoButton(
        padding: padding ?? const EdgeInsets.all(0),
        onPressed: onPressed,
        disabledColor: ColorName.coralRed,
        child: child,
      ),
    );
  }
}
