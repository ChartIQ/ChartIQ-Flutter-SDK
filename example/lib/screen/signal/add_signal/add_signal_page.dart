import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/bottom_sheet_scroll_physics.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/buttons/app_bar_text_button.dart';
import 'package:example/common/widgets/custom_separated_list_view.dart';
import 'package:example/common/widgets/spacing.dart';
import 'package:example/screen/signal/add_signal/widgets/sections/conditions_section.dart';
import 'package:example/screen/signal/add_signal/widgets/sections/study_section.dart';
import 'package:example/screen/signal/signal_study_info_model.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'add_signal_vm.dart';
import 'widgets/sections/info_section.dart';

class AddSignalPage extends StatefulWidget {
  const AddSignalPage({Key? key}) : super(key: key);

  @override
  State<AddSignalPage> createState() => _AddSignalPageState();
}

class _AddSignalPageState extends State<AddSignalPage> {
  Future<void> _addSignal(BuildContext context) async {
    final vm = context.read<AddSignalVM>();
    await vm.addSignal();
    SignalStudyInfoModel.instance.removeLast();
    if (!mounted) return;
    Navigator.of(context, rootNavigator: !vm.isEditMode).pop();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddSignalVM>();
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: ModalAppBar(
        middleText: vm.isEditMode ? 'Edit Signal' : 'New Signal',
        rootNavigatorForBackButton: !vm.isEditMode,
        isBackButtonIcon: vm.isEditMode,
        trailingWidget: AppBarTextButton(
          onPressed: vm.isSaveAvailable ? () => _addSignal(context) : null,
          child: Text(context.translateWatch(RemoteLocaleKeys.save)),
        ),
      ),
      body: CustomSeparatedListView.list(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        physics: const BottomSheetScrollPhysics(),
        controller: ModalScrollController.of(context),
        children: [
          StudySection(
            selectedStudy: vm.selectedStudy,
            isEditMode: vm.isEditMode,
          ),
          if (vm.selectedStudy != null) const ConditionsSection(),
          InfoSection(
            nameValue: vm.nameValue,
            descriptionValue: vm.descriptionValue,
            onNameChanged: (value) => vm.name = value,
            onDescriptionChanged: (value) => vm.description = value,
          ),
        ],
        separatorBuilder: (context, index) => const VerticalSpacing(30),
      ),
    );
  }
}
