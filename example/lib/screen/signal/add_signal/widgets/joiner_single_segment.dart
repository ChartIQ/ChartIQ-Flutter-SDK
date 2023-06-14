import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/theme/app_colors.dart';
import 'package:flutter/material.dart';

class JoinerSingleSegment extends StatelessWidget {
  const JoinerSingleSegment({
    Key? key,
    required this.joiner,
  }) : super(key: key);

  final SignalJoiner joiner;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.segmentedControlBackgroundColor!,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 64,
      ),
      child: Text(
        joiner.name.capitalize(),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
