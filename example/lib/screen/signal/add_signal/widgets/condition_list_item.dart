import 'package:chart_iq/chartiq_flutter_sdk.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/buttons/custom_slidable_button.dart';
import 'package:example/data/model/condition_item.dart';
import 'package:example/screen/signal/add_signal/add_signal_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'condition_info_item.dart';
import 'joiner_segmented_control.dart';
import 'joiner_single_segment.dart';

class ConditionListItem extends StatelessWidget {
  const ConditionListItem({
    Key? key,
    required this.index,
    required this.condition,
    required this.onJoinerChanged,
    required this.onEditCondition,
  }) : super(key: key);

  final int index;
  final ConditionItem condition;
  final ValueChanged<SignalJoiner> onJoinerChanged;
  final ValueChanged<ConditionItem> onEditCondition;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddSignalVM>();
    return Slidable(
      key: ValueKey(condition.hashCode),
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        dismissible: DismissiblePane(
          onDismissed: () => vm.removeCondition(index),
        ),
        dragDismissible: true,
        extentRatio: 0.4,
        children: [
          CustomSlidableButton(
            text: context.translateWatch(RemoteLocaleKeys.delete),
            onTap: () => vm.removeCondition(index),
          ),
        ],
      ),
      child: Column(
        children: [
          ConditionInfoItem(
            condition: condition,
            onTap: onEditCondition,
            showSignalPreview: vm.selectedJoiner == SignalJoiner.or
                ? true
                : index == 0
                    ? true
                    : false,
          ),
            if (index == 0)
              JoinerSegmentedControl(
                selected: vm.selectedJoiner,
                onJoinerChanged: onJoinerChanged,
              )
            else if (index + 1 != vm.conditions.length)
              JoinerSingleSegment(joiner: vm.selectedJoiner),
        ],
      ),
    );
  }
}
