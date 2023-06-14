import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/widgets/custom_expandable_body.dart';
import 'package:example/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'crosshair_value_container.dart';

class CrosshairView extends StatelessWidget {
  const CrosshairView({
    Key? key,
    this.isExpanded = false,
    this.data,
  }) : super(key: key);

  final bool isExpanded;
  final CrosshairHUD? data;

  @override
  Widget build(BuildContext context) {
    return CustomExpandableBody(
      expand: isExpanded,
      axisAlignment: -1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.mainAppBarColor,
        ),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CrosshairValueContainer(
                  firstTranslationKey: RemoteLocaleKeys.crosshairPrice,
                  firstValue: data?.price ?? '',
                  secondTranslationKey: RemoteLocaleKeys.crosshairVol,
                  secondValue: data?.volume ?? '',
                ),
                CrosshairValueContainer(
                  firstTranslationKey: RemoteLocaleKeys.open,
                  firstValue: data?.open  ?? '',
                  secondTranslationKey: RemoteLocaleKeys.high,
                  secondValue: data?.high ?? '',
                ),
                CrosshairValueContainer(
                  firstTranslationKey: RemoteLocaleKeys.close,
                  firstValue: data?.close ?? '',
                  secondTranslationKey: RemoteLocaleKeys.low,
                  secondValue: data?.low ?? '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
