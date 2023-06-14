import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/spacing.dart';
import 'package:example/theme/app_crosshair_text_theme.dart';
import 'package:flutter/material.dart';

class CrosshairValueContainer extends StatelessWidget {
  const CrosshairValueContainer({
    Key? key,
    required this.firstTranslationKey,
    required this.firstValue,
    required this.secondTranslationKey,
    required this.secondValue,
  }) : super(key: key);

  final String firstTranslationKey,
      firstValue,
      secondTranslationKey,
      secondValue;

  @override
  Widget build(BuildContext context) {
    final textStyleTheme =
        Theme.of(context).extension<AppCrosshairTextTheme>()!;
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              RemoteLocaleKeys.crosshairFullLabel(
                context.translateWatch(firstTranslationKey),
              ).toUpperCase(),
              style: textStyleTheme.labelTextStyle,
            ),
            const VerticalSpacing(4),
            Text(
              RemoteLocaleKeys.crosshairFullLabel(
                context.translateWatch(secondTranslationKey),
              ).toUpperCase(),
              style: textStyleTheme.labelTextStyle,
            ),
          ],
        ),
        const HorizontalSpacing(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(firstValue, style: textStyleTheme.valueTextStyle),
            const VerticalSpacing(4),
            Text(secondValue, style: textStyleTheme.valueTextStyle),
          ],
        ),
      ],
    );
  }
}
