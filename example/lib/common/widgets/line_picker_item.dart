import 'package:example/data/model/drawing_tool/line/line_types_enum.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LinePickerItem extends StatelessWidget {
  const LinePickerItem({
    Key? key,
    required this.line,
    this.isSelected = false,
    this.onTap,
    this.padding,
  }) : super(key: key);

  final LineTypes line;
  final bool isSelected;
  final VoidCallback? onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        decoration: BoxDecoration(
          // color: color.getColorWithAuto(context),
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
        child: SvgPicture.asset(
          line.icon,
          colorFilter: ColorFilter.mode(
            Theme.of(context).iconTheme.color!,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
