import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/bottom_sheet_scroll_physics.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/buttons/app_bar_text_button.dart';
import 'package:example/common/widgets/common_settings_items/choose_setting_item.dart';
import 'package:example/common/widgets/common_settings_items/color_setting_item.dart';
import 'package:example/common/widgets/common_settings_items/text_field_setting_item.dart';
import 'package:example/common/widgets/custom_separated_list_view.dart';
import 'package:example/common/widgets/spacing.dart';
import 'package:example/screen/signal/add_signal/add_condition/widgets/attention_label.dart';
import 'package:example/screen/signal/add_signal/add_condition/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'add_condition_vm.dart';

class AddConditionPage extends StatefulWidget {
  const AddConditionPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<AddConditionPage> createState() => _AddConditionPageState();
}

class _AddConditionPageState extends State<AddConditionPage> {
  static const _kSelectOptionTitle = "Select Option";

  void _onSave(BuildContext context) {
    final vm = context.read<AddConditionVM>();
    Navigator.of(context, rootNavigator: !vm.isEdit).pop(vm.getNewCondition());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddConditionVM>();
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: ModalAppBar(
        rootNavigatorForBackButton: !vm.isEdit,
        isBackButtonIcon: vm.isEdit,
        middleText: widget.title,
        transitionAnimation: true,
        trailingWidget: AppBarTextButton(
          onPressed: vm.isSaveAvailable ? () => _onSave(context) : null,
          child: Text(context.translateWatch(RemoteLocaleKeys.save)),
        ),
      ),
      body: CustomSeparatedListView.list(
        physics: const BottomSheetScrollPhysics(),
        controller: ModalScrollController.of(context),
        showOuterDividers: false,
        showFadeInAnimation: false,
        separatorBuilder: (_, __) => const VerticalSpacing(15),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(text: 'condition settings'),
              if (vm.indicators1 != null && vm.indicators1!.isNotEmpty)
                CustomSeparatedListView.list(
                  showFadeInAnimation: false,
                  children: [
                    ChooseSettingItem(
                      title: 'Indicator 1',
                      pickerTitle: _kSelectOptionTitle,
                      options: vm.indicators1!,
                      onChanged: (options) => vm.onSelect1Indicator(
                        options[0].title,
                      ),
                      isGeneralDialog: false,
                      forceTitleInChoiceScreen: true,
                    ),
                    ChooseSettingItem(
                      title: 'Condition',
                      pickerTitle: _kSelectOptionTitle,
                      options: vm.operators,
                      placeholder: "Select Action",
                      onChanged: (options) =>
                          vm.onOperatorSelected(options[0].title),
                      isGeneralDialog: false,
                    ),
                    if (vm.indicators2 != null &&
                        vm.selectedOperator != null &&
                        vm.showIndicator2)
                      ChooseSettingItem(
                        title: 'Indicator 2',
                        pickerTitle: _kSelectOptionTitle,
                        options: vm.indicators2!,
                        onChanged: (options) =>
                            vm.onSelect2Indicator(options[0].title),
                        isGeneralDialog: false,
                        forceTitleInChoiceScreen: true,
                      ),
                    if (vm.showValueField)
                      TextFieldSettingItem.number(
                        title: 'Value',
                        onChanged: (value) => vm.onValueFieldChanged(value),
                        value: vm.valueField,
                        supportNegativeValues: true,
                      ),
                  ],
                ),
            ],
          ),
          if (vm.selectedOperator != null && vm.showAppearance)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(text: 'appearance settings'),
                if (vm.indicators1 != null && vm.indicators1!.isNotEmpty)
                  CustomSeparatedListView.list(
                    showFadeInAnimation: false,
                    children: [
                      ChooseSettingItem(
                        title: 'Marker Type',
                        pickerTitle: _kSelectOptionTitle,
                        options: vm.markerTypes,
                        onChanged: (options) =>
                            vm.onMarkerTypeSelected(options[0].title),
                        isGeneralDialog: false,
                      ),
                      ColorSettingItem(
                        title: context.translateWatch(RemoteLocaleKeys.color),
                        currentColor: vm.userSelectedColor ??
                            vm.defaultSelectedColor ??
                            AddConditionVM.kDefaultAutoColor,
                        onColorChanged: (color) => vm.onColorSelected(color),
                        useRootNavigator: true,
                      ),
                      if (vm.showAdditionalAppearanceSettings) ...[
                        ChooseSettingItem(
                          title: 'Shape',
                          pickerTitle: _kSelectOptionTitle,
                          options: vm.shapes,
                          onChanged: (options) =>
                              vm.onShapeSelected(options[0].title),
                          isGeneralDialog: false,
                        ),
                        TextFieldSettingItem(
                          title: 'Tag Mark',
                          value: vm.tagMarkValue,
                          onChanged: vm.onTagMarkChanged,
                        ),
                        ChooseSettingItem(
                          title: 'Size',
                          pickerTitle: _kSelectOptionTitle,
                          options: vm.sizes,
                          onChanged: (options) =>
                              vm.onSizeSelected(options[0].title),
                          isGeneralDialog: false,
                        ),
                        ChooseSettingItem(
                          title: 'Position',
                          pickerTitle: _kSelectOptionTitle,
                          options: vm.positions,
                          onChanged: (options) =>
                              vm.onPositionSelected(options[0].title),
                          isGeneralDialog: false,
                        ),
                      ]
                    ],
                  ),
              ],
            ),
          if (vm.isAttentionMessageVisible) const AttentionLabel(),
        ],
      ),
    );
  }
}
