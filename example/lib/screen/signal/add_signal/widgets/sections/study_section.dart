import 'package:chart_iq/chart_iq.dart';
import 'package:example/common/widgets/custom_separated_list_view.dart';
import 'package:example/common/widgets/list_tiles/custom_text_list_tile.dart';
import 'package:example/common/widgets/modals/app_bottom_sheet.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/screen/signal/add_signal/add_signal_vm.dart';
import 'package:example/screen/signal/signal_study_info_model.dart';
import 'package:example/screen/studies/add_studies/add_studies_page.dart';
import 'package:example/screen/studies/study_parameters/study_parameters_page.dart';
import 'package:example/screen/studies/study_parameters/study_parameters_vm.dart';
import 'package:example/screen/studies/utils/study_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudySection extends StatefulWidget {
  const StudySection({
    Key? key,
    required this.selectedStudy,
    required this.isEditMode,
  }) : super(key: key);
  final Study? selectedStudy;
  final bool isEditMode;

  @override
  State<StudySection> createState() => _StudySectionState();
}

class _StudySectionState extends State<StudySection> {
  String get buttonText => '${widget.selectedStudy != null ? 'Change' : 'Select'} Study';

  Future<void> _onChangeStudy(BuildContext context) async {
    final vm = context.read<AddSignalVM>();

    final newStudy = await showAppBottomSheet<List<Study>?>(
      context: context,
      useRootNavigator: true,
      builder: (context) => AddStudiesPage(
        chartIQController: vm.chartIQController,
        singleChoice: true,
      ),
    );

    if (!mounted) return;
    if (newStudy != null && newStudy.isNotEmpty) {
      if (SignalStudyInfoModel.instance.studies.isNotEmpty) {
        await vm.chartIQController.study.removeStudy(SignalStudyInfoModel.instance.studies.first);
        SignalStudyInfoModel.instance.studies.remove(SignalStudyInfoModel.instance.studies.first);
      }
      final study = await vm.chartIQController.signal.addSignalStudy(newStudy[0]);
      SignalStudyInfoModel.instance.studies.add(study);
      vm.selectedStudy = study;
      vm.clearConditions();
      if (!mounted) return;
    }
  }

  Future<void> _onConfigureStudy(BuildContext context, Study study) async {
    final vm = context.read<AddSignalVM>();

    final simplified = await Navigator.of(context).push<dynamic>(
      MaterialPageRoute(
        builder: (_) {
          return ChangeNotifierProvider<StudyParametersVM>(
            create: (_) => StudyParametersVM(
              chartIQController: vm.chartIQController,
              study: study,
            ),
            child: const StudyParametersPage(),
          );
        },
      ),
    );

    if (!mounted || simplified == null) return;
    vm.onStudyEdited(simplified);
  }

  @override
  Widget build(BuildContext context) {
    return CustomSeparatedListView.list(
      children: [
        if (widget.selectedStudy != null)
          CustomTextListTile(
            title: StudyExtension.splitName(widget.selectedStudy!.name)[0],
            onTap: () => _onConfigureStudy(context, widget.selectedStudy!),
            showChevron: true,
          ),
        if (!widget.isEditMode)
          CustomTextListTile.widgetTitle(
            titleWidget: Text(
              buttonText,
              style: const TextStyle(
                color: ColorName.mountainMeadow,
              ),
            ),
            onTap: () => _onChangeStudy(context),
          ),
      ],
    );
  }
}
