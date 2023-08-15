import 'package:chart_iq/chartiq_flutter_sdk.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/bottom_sheet_scroll_physics.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/buttons/app_bar_text_button.dart';
import 'package:example/common/widgets/custom_separated_list_view.dart';
import 'package:example/common/widgets/empty_view.dart';
import 'package:example/common/widgets/modals/app_bottom_sheet.dart';
import 'package:example/screen/studies/add_studies/add_studies_page.dart';
import 'package:example/screen/studies/study_parameters/study_parameters_page.dart';
import 'package:example/screen/studies/study_parameters/study_parameters_vm.dart';
import 'package:example/screen/studies/widgets/full_screen_loader.dart';
import 'package:example/theme/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'active_studies_vm.dart';
import 'widgets/active_study_list_item.dart';

class ActiveStudiesPage extends StatefulWidget {
  const ActiveStudiesPage({Key? key}) : super(key: key);

  @override
  State<ActiveStudiesPage> createState() => _ActiveStudiesPageState();
}

class _ActiveStudiesPageState extends State<ActiveStudiesPage> {
  Future<void> _addStudies(BuildContext context) async {
    final vm = context.read<ActiveStudiesVM>();

    await showAppBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return AddStudiesPage(
          chartIQController: vm.chartIQController,
        );
      },
    );
    if (mounted) vm.getActiveStudies();
  }

  Future<void> _removeStudy(BuildContext context, Study study) {
    final vm = context.read<ActiveStudiesVM>();
    return vm.removeStudy(study);
  }

  Future<void> _onStudyTap(BuildContext context, Study study) async {
    final vm = context.read<ActiveStudiesVM>();
    if (!vm.isControllerAvailable) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ActiveStudiesVM>.value(value: vm),
              ChangeNotifierProvider<StudyParametersVM>(
                create: (_) => StudyParametersVM(
                  chartIQController: vm.chartIQController!,
                  study: study,
                ),
              ),
            ],
            child: StudyParametersPage(
              onRemoveStudy: (study) async => _removeStudy(context, study),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ActiveStudiesVM>();
    return Scaffold(
      appBar: ModalAppBar(
        middleText: 'Active Studies',
        trailingWidget: vm.studies.isEmpty
            ? null
            : AppBarTextButton(
                onPressed: () => _addStudies(context),
                child: Text(context.translateWatch(RemoteLocaleKeys.add)),
              ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Builder(builder: (context) {
            if (vm.studies.isEmpty) {
              return Center(
                child: EmptyView(
                  icon: context.assets.analysisIcon.path,
                  title: 'No Active Studies to display yet',
                  buttonText: 'Add Studies',
                  onButtonPressed: () => _addStudies(context),
                ),
              );
            }
            return SlidableAutoCloseBehavior(
              child: CustomSeparatedListView(
                physics: const BottomSheetScrollPhysics(),
                controller: ModalScrollController.of(context),
                itemCount: vm.studies.length,
                itemBuilder: (context, index) {
                  return ActiveStudyListItem(
                    study: vm.studies[index],
                    onRemoveStudy: (study) => _removeStudy(context, study),
                    onCloneStudy: vm.cloneStudy,
                    onStudyTap: (study) => _onStudyTap(context, study),
                  );
                },
              ),
            );
          }),
          if (vm.isLoading) const FullScreenLoader(),
        ],
      ),
    );
  }
}
