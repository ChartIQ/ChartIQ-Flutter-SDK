import 'package:chart_iq/chart_iq.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/bottom_sheet_scroll_physics.dart';
import 'package:example/common/utils/confirmation_dialog.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/buttons/app_bar_text_button.dart';
import 'package:example/common/widgets/common_settings_items/choose_setting_item.dart';
import 'package:example/common/widgets/common_settings_items/color_number_setting_number.dart';
import 'package:example/common/widgets/common_settings_items/color_setting_item.dart';
import 'package:example/common/widgets/common_settings_items/switch_setting_item.dart';
import 'package:example/common/widgets/common_settings_items/text_field_setting_item.dart';
import 'package:example/common/widgets/custom_separated_sliver_list.dart';
import 'package:example/common/widgets/list_tiles/custom_text_list_tile.dart';
import 'package:example/common/widgets/spacing.dart';
import 'package:example/data/model/option_item_model.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/screen/studies/active_studies/active_studies_vm.dart';
import 'package:example/screen/studies/utils/study_extension.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'study_parameters_vm.dart';

class KeyedOptionItemModel {
  final String key;
  final String title;
  final bool isChecked;
  const KeyedOptionItemModel(
      {required this.key, required this.title, required this.isChecked});
}

class StudyParametersPage extends StatefulWidget {
  const StudyParametersPage({
    Key? key,
    this.onRemoveStudy,
  }) : super(key: key);

  final void Function(Study)? onRemoveStudy;

  @override
  State<StudyParametersPage> createState() => _StudyParametersPageState();
}

class _StudyParametersPageState extends State<StudyParametersPage> {
  Future<void> _onRemoveStudy(BuildContext context, Study study) async {
    final answer = await showConfirmationDialog(
      context,
      'Do You Want To Remove This Study?',
      'This study will be removed from the current chart.',
      context.translate(RemoteLocaleKeys.delete),
    );

    if (!(answer ?? false)) return;

    widget.onRemoveStudy?.call(study);
    if (mounted) Navigator.pop(context);
  }

  Future<void> _onResetToDefaults(BuildContext context) async {
    final answer = await showConfirmationDialog(
      context,
      'Do You Want To Reset This Study to Defaults?',
      'This study will be reset to default options.',
      'Reset',
    );

    if (!(answer ?? false) || !mounted) return;

    final vm = context.read<StudyParametersVM>();
    vm.resetToDefaults();
  }

  Future<void> _onSave(BuildContext context) async {
    final vm = context.read<StudyParametersVM>();

    final simplifiedStudy = await vm.saveParameters();

    if (!mounted) return;

    if (context.findAncestorWidgetOfExactType<
            ChangeNotifierProvider<ActiveStudiesVM>>() !=
        null) {
      final activeStudiesVm = context.read<ActiveStudiesVM>();
      activeStudiesVm.getActiveStudies();
    }
    Navigator.pop(context, simplifiedStudy);
  }

  @override
  void initState() {
    final vm = context.read<StudyParametersVM>();
    vm.getStudyParameters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StudyParametersVM>();

    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: ModalAppBar(
        middleText: StudyExtension.splitName(vm.study.name)[0],
        isBackButtonIcon: true,
        rootNavigatorForBackButton: false,
        trailingWidget: AppBarTextButton(
          onPressed: () => _onSave(context),
          child: Text(context.translateWatch(RemoteLocaleKeys.save)),
        ),
      ),
      body: CustomScrollView(
        physics: const BottomSheetScrollPhysics(),
        controller: ModalScrollController.of(context),
        slivers: [
          const SliverToBoxAdapter(
            child: VerticalSpacing(20),
          ),
          CustomSeparatedSliverList(
            showFadeInAnimation: false,
            itemCount: vm.parameters.length,
            itemBuilder: (context, index) {
              final parameter = vm.parameters[index];
              return _buildSettingItem(context, parameter);
            },
          ),
          const SliverToBoxAdapter(
            child: VerticalSpacing(20),
          ),
          if (widget.onRemoveStudy != null)
            CustomSeparatedSliverList.list(
              showFadeInAnimation: false,
              children: [
                CustomTextListTile.widgetTitle(
                  titleWidget: const Text(
                    'Reset to Defaults',
                    style: TextStyle(
                      color: ColorName.mountainMeadow,
                    ),
                  ),
                  onTap: () => _onResetToDefaults(context),
                ),
                CustomTextListTile.widgetTitle(
                  titleWidget: Text(
                    context.translateWatch(RemoteLocaleKeys.deleteStudy),
                    style: const TextStyle(
                      color: ColorName.coralRed,
                    ),
                  ),
                  onTap: () => _onRemoveStudy(context, vm.study),
                ),
              ],
            ),
          const SliverToBoxAdapter(
            child: VerticalSpacing(20),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, StudyParameter parameter) {
    final vm = context.read<StudyParametersVM>();
    switch (parameter.runtimeType) {
      case StudyParameterCheckbox:
        final item = parameter as StudyParameterCheckbox;
        return SwitchSettingItem(
          title: item.heading,
          value: item.value,
          onChanged: (value) => vm.onCheckBoxChanged(parameter, value),
        );
      case StudyParameterText:
        final item = parameter as StudyParameterText;
        return TextFieldSettingItem(
          title: item.heading,
          value: item.value.toString(),
          onChanged: (value) => vm.onTextParamChanged(parameter, value),
        );
      case StudyParameterNumber:
        final item = parameter as StudyParameterNumber;
        return TextFieldSettingItem.number(
          title: item.heading,
          value: item.value.toString(),
          onChanged: (value) => {},
          onTapOutside: (value) => vm.onNumberParamChanged(parameter, value),
        );
      case StudyParameterColor:
        final item = parameter as StudyParameterColor;
        return ColorSettingItem(
          title: item.heading,
          currentColor: PickerColor(item.value),
          useRootNavigator: true,
          onColorChanged: (color) => vm.onColorParamChanged(
            parameter,
            color.hexValueWithHash,
          ),
        );
      case StudyParameterSelect:
        final item = parameter as StudyParameterSelect;
        return ChooseSettingItem(
          isGeneralDialog: false,
          /*pickerTitle: "Choose value",*/
          title: item.heading,
          options: item.options.entries
              .map((e) => OptionItemModel(
                    title: e.value,
                    isChecked: e.key == item.value,
                  ))
              .toList(),
          onChanged: (value) => vm.onSelectParamChanged(
              parameter,
              KeyedOptionItemModel(
                key: item.options.entries
                    .elementAt(value[0].title == null
                        ? 0
                        : item.options.values.toList().indexOf(value[0].title))
                    .key,
                title: value[0].title,
                isChecked: value[0].isChecked,
              )),
        );
      case StudyParameterTextColor:
        final item = parameter as StudyParameterTextColor;
        return ColorNumberListSettingItem(
          title: item.heading,
          numberValue: item.value.toString(),
          onNumberChanged: (number) =>
              vm.onNumberParamChanged(parameter, number),
          colorValue: PickerColor(item.color),
          onColorChanged: (color) => vm.onColorParamChanged(
            parameter,
            color.hexValueWithHash,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
