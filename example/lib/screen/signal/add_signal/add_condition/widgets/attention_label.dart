import 'package:example/common/widgets/spacing.dart';
import 'package:example/gen/assets.gen.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AttentionLabel extends StatelessWidget {
  const AttentionLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorName.veryLightPink,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.icons.attention.path,
            colorFilter: const ColorFilter.mode(
              ColorName.coralRed,
              BlendMode.srcIn,
            ),
          ),
          const HorizontalSpacing(15),
          Expanded(
            child: Text(
              'Paintbar doen\'t work with this chart type.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: ColorName.coralRed,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
