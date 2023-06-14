import 'package:example/data/model/picker_color.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class ColorPickerItem extends StatelessWidget {
  const ColorPickerItem({
    Key? key,
    required this.color,
    this.isSelected = false,
    this.onTap,
    this.padding,
  }) : super(key: key);

  final PickerColor color;
  final bool isSelected;
  final VoidCallback? onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () => onTap?.call(),
        child: Container(
          decoration: BoxDecoration(
            color: color.getColorWithAuto(context),
            borderRadius: BorderRadius.circular(4.0),
            border: Border.fromBorderSide(
              isSelected
                  ? const BorderSide(
                      color: ColorName.mountainMeadow,
                      width: 1,
                    )
                  : Theme.of(context).chipTheme.shape!.side,
            ),
          ),
          padding: padding,
          child: _buildSelectedIndicator(isSelected),
        ),
      ),
    );
  }

  Widget _buildSelectedIndicator(bool isSelected) {
    if (!isSelected) {
      return const SizedBox.shrink();
    }
    return FittedBox(
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black26,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(9.0),
          child: const Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
