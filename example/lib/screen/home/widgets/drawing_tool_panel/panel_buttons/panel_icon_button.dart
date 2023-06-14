import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'panel_main_icon.dart';

class PanelIconButton extends StatelessWidget {
  const PanelIconButton({
    Key? key,
    required this.icon,
    this.isSelected = false,
    this.onSelected,
  }) : super(key: key);

  final String icon;
  final bool isSelected;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return PanelMainIconContainer(
      labelBuilder: (_) => SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          Theme.of(context).iconTheme.color!,
          BlendMode.srcIn,
        ),
      ),
      isSelected: isSelected,
      onSelected: () => onSelected?.call(),
    );
  }
}
