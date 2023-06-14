import 'package:example/gen/colors.gen.dart';
import 'package:example/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String? icon, selectedIcon;
  final bool isSelectable;
  final bool? isSelected, followForegroundIconThemeColor;
  final List<BoxShadow>? boxShadow;
  final Color? foregroundColor;
  final double? size;
  final bool isLoading;

  const CustomIconButton({
    Key? key,
    this.icon,
    this.onPressed,
    this.followForegroundIconThemeColor = true,
    this.boxShadow,
    this.foregroundColor,
    this.size,
    this.isLoading = false,
  })  : selectedIcon = '',
        isSelected = false,
        isSelectable = false,
        assert(isLoading == false ? icon != null : true),
        super(key: key);

  const CustomIconButton.selectable({
    Key? key,
    required this.icon,
    required this.selectedIcon,
    this.onPressed,
    this.isSelected = false,
    this.followForegroundIconThemeColor = true,
    this.boxShadow,
    this.size,
    this.isLoading = false,
  })  : foregroundColor = null,
        isSelectable = true,
        assert(
          isLoading == false ? (icon != null && selectedIcon != null) : true,
        ),
        super(key: key);

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  Color? get backgroundColor {
    if (widget.isSelectable) {
      return widget.isSelected!
          ? Theme.of(context)
              .extension<AppColors>()
              ?.iconButtonSelectedBackgroundColor
          : Theme.of(context).extension<AppColors>()?.iconButtonBackgroundColor;
    }
    return Theme.of(context).extension<AppColors>()?.iconButtonBackgroundColor;
  }

  Color? get foregroundColor {
    if (!(widget.followForegroundIconThemeColor ?? false)) {
      return widget.foregroundColor;
    }
    if (widget.isSelectable) {
      return widget.isSelected!
          ? Theme.of(context)
              .extension<AppColors>()
              ?.iconButtonSelectedForegroundColor
          : Theme.of(context).iconTheme.color;
    }
    return Theme.of(context).iconTheme.color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size ?? 32,
      height: widget.size ?? 32,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: widget.boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        type: MaterialType.circle,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: widget.onPressed,
          child: Center(
            child: widget.isLoading
                ? const CupertinoActivityIndicator(
                    color: ColorName.mountainMeadow,
                    radius: 9,
                  )
                : SvgPicture.asset(
                    widget.isSelectable && (widget.isSelected ?? false)
                        ? widget.selectedIcon!
                        : widget.icon!,
                    colorFilter: foregroundColor == null
                        ? null
                        : ColorFilter.mode(
                            foregroundColor ??
                                Theme.of(context).iconTheme.color!,
                            BlendMode.srcIn,
                          ),
                  ),
          ),
        ),
      ),
    );
  }
}
