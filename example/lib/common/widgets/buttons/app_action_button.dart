import 'package:flutter/material.dart';

class AppActionButton extends StatelessWidget {
  const AppActionButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.shape,
    this.padding,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final OutlinedBorder? shape;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            shape: shape != null
                ? MaterialStateProperty.all((shape!))
                : Theme.of(context).elevatedButtonTheme.style!.shape,
            maximumSize: MaterialStateProperty.all(const Size.fromHeight(100)),
            padding: padding != null
                ? MaterialStateProperty.all(padding)
                : Theme.of(context).elevatedButtonTheme.style!.padding,
          ),
      child: child,
    );
  }
}
