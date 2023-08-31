import 'package:chart_iq/chart_iq.dart';
import 'package:example/common/const/const.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JoinerSegmentedControl extends StatefulWidget {
  const JoinerSegmentedControl({
    Key? key,
    required this.selected,
    required this.onJoinerChanged,
  }) : super(key: key);

  final SignalJoiner selected;
  final ValueChanged<SignalJoiner> onJoinerChanged;

  @override
  State<JoinerSegmentedControl> createState() => _JoinerSegmentedControlState();
}

class _JoinerSegmentedControlState extends State<JoinerSegmentedControl> {
  final values = SignalJoiner.values;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: AppConst.kListTileSeparatorIndent,
      ),
      child: Row(
        children: [
          Expanded(
            child: CupertinoSlidingSegmentedControl<SignalJoiner>(
              backgroundColor: context.colors.segmentedControlBackgroundColor!,
              thumbColor: context.colors.segmentedControlSelectedColor!,
              padding: const EdgeInsets.all(2),
              groupValue: widget.selected,
              children: {
                for (var e in values)
                  e: Text(
                    e.name.capitalize(),
                    style: Theme.of(context).textTheme.labelMedium,
                  )
              },
              onValueChanged: (joiner) {
                if (joiner != null) widget.onJoinerChanged(joiner);
              },
            ),
          ),
        ],
      ),
    );
  }
}
