import 'package:example/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class CustomChoiceChip extends StatelessWidget {
  const CustomChoiceChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  final Widget label;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: label,
      selected: isSelected,
      onSelected: onSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: isSelected
            ? const BorderSide(
                color: ColorName.mountainMeadow,
                width: 1,
              )
            : Theme.of(context).chipTheme.shape!.side,
      ),
    );
  }
}
