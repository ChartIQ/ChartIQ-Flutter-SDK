import 'package:example/common/widgets/spacing.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'panel_main_icon.dart';

class PanelColorWithIconButton extends StatelessWidget {
  const PanelColorWithIconButton({
    Key? key,
    required this.icon,
    required this.currentColor,
    this.isSelected = false,
    this.onSelected,
  }) : super(key: key);

  final String icon;
  final PickerColor currentColor;
  final bool isSelected;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return PanelMainIconContainer(
      labelBuilder: (_) => Column(
        children: [
          Expanded(
            child: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color!,
                BlendMode.srcIn,
              ),
            ),
          ),
          const VerticalSpacing(4),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: currentColor.getColorWithAuto(context),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: ColorName.cadetBlue,
                width: 0.5,
              ),
            ),
          ),
        ],
      ),
      isSelected: isSelected,
      onSelected: () => onSelected?.call(),
    );
  }
}
