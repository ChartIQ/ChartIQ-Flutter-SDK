import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/theme/app_crosshair_text_theme.dart';
import 'package:flutter/material.dart';

class CrosshairValueContainer extends StatelessWidget {
  const CrosshairValueContainer({
    Key? key,
    required this.firstTranslationKey,
    required this.firstValue,
    required this.secondTranslationKey,
    required this.secondValue,
    required this.thirdTranslationKey,
    required this.thirdValue,
  }) : super(key: key);

  final String firstTranslationKey,
      firstValue,
      secondTranslationKey,
      secondValue,
      thirdTranslationKey,
      thirdValue;

  String trimValue(String value) {
    final doubleValue = double.tryParse(value);
    if (doubleValue == null) return value;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final textStyleTheme =
        Theme.of(context).extension<AppCrosshairTextTheme>()!;
    const double titleSize = 50;
    return Row(
      children: [
        SizedBox(
          width: titleSize,
          child: Text(
            RemoteLocaleKeys.crosshairFullLabel(
              context.translateWatch(firstTranslationKey),
            ).toUpperCase(),
            style: textStyleTheme.labelTextStyle,
          ),
        ),
        Expanded(
            flex: 3,
            child: Text(
              trimValue(firstValue),
              style: textStyleTheme.valueTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
        const Spacer(),
        SizedBox(
          width: titleSize,
          child: Text(
            RemoteLocaleKeys.crosshairFullLabel(
              context.translateWatch(secondTranslationKey),
            ).toUpperCase(),
            style: textStyleTheme.labelTextStyle,
          ),
        ),
        Expanded(
            flex: 3,
            child: Text(
              trimValue(secondValue),
              style: textStyleTheme.valueTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
        const Spacer(),
        SizedBox(
          width: titleSize,
          child: Text(
            RemoteLocaleKeys.crosshairFullLabel(
              context.translateWatch(thirdTranslationKey),
            ).toUpperCase(),
            style: textStyleTheme.labelTextStyle,
          ),
        ),
        Expanded(
            flex: 3,
            child: Text(
              trimValue(thirdValue),
              style: textStyleTheme.valueTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
      ],
    );
  }
}
