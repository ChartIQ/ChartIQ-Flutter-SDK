import 'package:example/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class PanelMainIconContainer extends StatelessWidget {
  const PanelMainIconContainer({
    Key? key,
    required this.labelBuilder,
    this.isSelected = false,
    this.onSelected,
  }) : super(key: key);

  final WidgetBuilder labelBuilder;
  final bool isSelected;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: AnimatedContainer(
        width: 32,
        height: 32,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Theme.of(context).chipTheme.backgroundColor,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: isSelected ? ColorName.mountainMeadow : Colors.transparent,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(4),
        child: Center(
          child: labelBuilder(context),
        ),
      ),
    );
  }
}
