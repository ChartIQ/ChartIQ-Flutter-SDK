import 'package:example/common/widgets/list_tiles/custom_trailing_list_tile.dart';
import 'package:example/data/model/option_item_model.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'widgets/choose_value_dialog.dart';

class ChooseSettingItem extends StatelessWidget {
  const ChooseSettingItem({
    Key? key,
    required this.title,
    this.pickerTitle,
    required this.options,
    required this.onChanged,
    this.secondaryText,
    this.placeholder,
    this.isMultipleSelection = false,
    this.hasCustomValueSupport = false,
    this.hasNegativeValueSupport = false,
    this.isGeneralDialog = true,
    this.forceTitleInChoiceScreen = false,
  }) : super(key: key);

  final String title;
  final String? secondaryText, pickerTitle, placeholder;
  final List<OptionItemModel> options;
  final ValueChanged<List<OptionItemModel>> onChanged;
  final bool isMultipleSelection,
      hasCustomValueSupport,
      hasNegativeValueSupport,
      isGeneralDialog,
      forceTitleInChoiceScreen;

  String get trailingText {
    if (secondaryText != null) return secondaryText!;
    if (!isMultipleSelection) {
      final selectedOption = options.firstWhere(
        (e) => e.isChecked,
        orElse: () =>
            OptionItemModel(title: placeholder ?? '', isChecked: true),
      );
      return selectedOption.prettyTitle ?? selectedOption.title;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return CustomTrailingListTile(
      title: title,
      showChevron: true,
      trailingText: Text(trailingText),
      onTap: () async {
        final dialog = ChooseValueDialog(
          title: title,
          pickerTitle: pickerTitle,
          options: options,
          isMultipleSelection: isMultipleSelection,
          hasCustomValueSupport: hasCustomValueSupport,
          hasNegativeValueSupport: hasNegativeValueSupport,
          addTopSafeArea: isGeneralDialog,
          forceTitleInChoiceScreen: forceTitleInChoiceScreen,
        );

        final value = await Navigator.of(
          context,
          rootNavigator: isGeneralDialog,
        ).push(
          MaterialPageRoute(builder: (context) {
            return PrimaryScrollController(
              controller: ModalScrollController.of(context) ??
                  PrimaryScrollController.of(context),
              child: dialog,
            );
          }),
        );
        if (value != null) onChanged(value);
        return;
      },
    );
  }
}
