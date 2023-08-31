import 'package:example/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class CustomSlidableButton extends StatelessWidget {
  const CustomSlidableButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.backgroundColor = Colors.red,
    this.textColor = Colors.white,
    this.icon,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final Color backgroundColor, textColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox.expand(
        child: OutlinedButton.icon(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: backgroundColor,
            side: BorderSide.none,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          icon: icon != null
              ? Icon(
                  icon!,
                  color: ColorName.white,
                  size: 18,
                )
              : const SizedBox.shrink(),
          label: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontSize: 15, color: textColor, letterSpacing: 0.2),
          ),
        ),
      ),
    );
  }
}
