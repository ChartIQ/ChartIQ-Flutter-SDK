import 'package:example/common/widgets/custom_separated_list_view.dart';
import 'package:example/common/widgets/list_tiles/custom_text_list_tile.dart';
import 'package:example/common/widgets/modals/app_bottom_sheet.dart';
import 'package:example/data/model/condition_item.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/screen/signal/add_signal/add_condition/add_condition_page.dart';
import 'package:example/screen/signal/add_signal/add_condition/add_condition_vm.dart';
import 'package:example/screen/signal/add_signal/add_signal_vm.dart';
import 'package:example/screen/signal/add_signal/widgets/condition_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ConditionsSection extends StatefulWidget {
  const ConditionsSection({Key? key}) : super(key: key);

  @override
  State<ConditionsSection> createState() => _ConditionsSectionState();
}

class _ConditionsSectionState extends State<ConditionsSection> {
  Future<void> _onAddCondition(BuildContext context) async {
    final vm = context.read<AddSignalVM>();
    final newCondition = await _showConditionPage(
      context,
      "${vm.conditions.length + 1} Condition",
      showAppearance: vm.canShowAppearanceForCondition(null),
      isEdit: false,
    );

    if (!mounted || newCondition == null) return;
    vm.addCondition(newCondition);
  }

  Future<void> _onEditCondition(
    BuildContext context, {
    required int index,
    required ConditionItem condition,
  }) async {
    final vm = context.read<AddSignalVM>();
    final newCondition = await _showConditionPage(
      context,
      condition.title,
      condition: condition,
      showAppearance: vm.canShowAppearanceForCondition(condition),
      isEdit: true,
    );

    if (!mounted || newCondition == null) return;
    vm.updateCondition(newCondition);
  }

  Future<ConditionItem?> _showConditionPage(
    BuildContext context,
    String title, {
    ConditionItem? condition,
    required bool showAppearance,
    required bool isEdit,
  }) async {
    final vm = context.read<AddSignalVM>();
    final page = ChangeNotifierProvider(
      create: (_) => AddConditionVM(
        context: context,
        isEdit: isEdit,
        condition: condition,
        chartIQController: vm.chartIQController,
        showAppearance: showAppearance,
        study: vm.selectedStudy!,
      ),
      child: AddConditionPage(title: title),
    );

    if (isEdit) {
      return await Navigator.of(context).push<ConditionItem>(
        MaterialPageRoute(
          builder: (_) => page,
        ),
      );
    }

    return await showAppBottomSheet<ConditionItem>(
      context: context,
      useRootNavigator: true,
      builder: (context) => Navigator(onGenerateRoute: (context) {
        return MaterialPageRoute(
          builder: (_) => page,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddSignalVM>();
    return SlidableAutoCloseBehavior(
      child: CustomSeparatedListView.list(
        children: [
          CustomSeparatedListView(
            showOuterDividers: false,
            separatorBuilder: (_, __) => const SizedBox.shrink(),
            itemCount: vm.conditions.length,
            itemBuilder: (context, index) {
              final condition = vm.conditions[index];
              return ConditionListItem(
                index: index,
                condition: condition,
                onJoinerChanged: vm.onJoinerChanged,
                onEditCondition: (c) => _onEditCondition(
                  context,
                  index: index,
                  condition: c,
                ),
              );
            },
          ),
          CustomTextListTile.widgetTitle(
            titleWidget: const Text(
              'Add Condition',
              style: TextStyle(
                color: ColorName.mountainMeadow,
              ),
            ),
            onTap: () => _onAddCondition(context),
          ),
        ],
      ),
    );
  }
}
