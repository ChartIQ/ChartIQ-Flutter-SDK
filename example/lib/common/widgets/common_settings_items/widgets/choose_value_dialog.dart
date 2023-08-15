import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/bottom_sheet_scroll_physics.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/buttons/app_bar_text_button.dart';
import 'package:example/common/widgets/custom_separated_sliver_list.dart';
import 'package:example/common/widgets/list_tiles/custom_text_list_tile.dart';
import 'package:example/common/widgets/spacing.dart';
import 'package:example/data/model/option_item_model.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import 'choose_value_custom_add_field.dart';

class ChooseValueDialog extends StatefulWidget {
  const ChooseValueDialog({
    Key? key,
    required this.title,
    this.pickerTitle,
    required this.options,
    this.isMultipleSelection = false,
    this.hasCustomValueSupport = false,
    this.hasNegativeValueSupport = false,
    this.addTopSafeArea = true,
    this.forceTitleInChoiceScreen = false,
  }) : super(key: key);

  final String title;
  final String? pickerTitle;
  final List<OptionItemModel> options;
  final bool isMultipleSelection,
      hasCustomValueSupport,
      hasNegativeValueSupport,
      addTopSafeArea,
      forceTitleInChoiceScreen;

  @override
  State<ChooseValueDialog> createState() => _ChooseValueDialogState();
}

class _ChooseValueDialogState extends State<ChooseValueDialog> {
  late final List<OptionItemModel> options =
      List<OptionItemModel>.from(widget.options);

  List<OptionItemModel> get _currentOptions {
    // this is need because [hasNegativeValueSupport] is false by default
    // and we need to check if all options are numbers
    // and only then decide how to filter elements
    if (!widget.hasNegativeValueSupport &&
        options.every((e) => double.tryParse(e.title) != null)) {
      return options.where((e) {
        return (double.tryParse(e.title) ?? -1) >= 0;
      }).toList();
    }
    return options;
  }

  void _onOptionTap(OptionItemModel option) {
    if (!widget.isMultipleSelection) {
      return Navigator.pop(context, [
        option.copyWith(
          isChecked: !option.isChecked,
        ),
      ]);
    }

    setState(() {
      options[options.indexOf(option)] =
          option.copyWith(isChecked: !option.isChecked);
    });
  }

  void _onCustomOptionAdded(String? value) {
    if (value == null) return;

    final parsedValue = double.tryParse(value);

    if (parsedValue == null) return;

    final newOption = OptionItemModel(
      title: value,
      prettyTitle: '$parsedValue%',
      isChecked: true,
    );

    setState(() {
      options.add(newOption);
    });
  }

  void _onSaveTap() {
    Navigator.pop(context, options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: ModalAppBar(
        middleText: widget.pickerTitle ?? widget.title,
        rootNavigatorForBackButton: false,
        addTopSafeArea: widget.addTopSafeArea,
        isBackButtonIcon: true,
        transitionAnimation: true,
        trailingWidget: widget.isMultipleSelection
            ? AppBarTextButton(
                onPressed: _onSaveTap,
                child: Text(context.translateWatch(RemoteLocaleKeys.save)),
              )
            : null,
      ),
      body: CustomScrollView(
        physics: const BottomSheetScrollPhysics(),
        slivers: [
          SliverSafeArea(
            top: false,
            bottom: !widget.hasCustomValueSupport,
            sliver: SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              sliver: CustomSeparatedSliverList(
                showFadeInAnimation: false,
                itemCount: _currentOptions.length,
                itemBuilder: (context, index) {
                  final option = _currentOptions[index];
                  return CustomTextListTile(
                    title: widget.forceTitleInChoiceScreen
                        ? option.title
                        : option.prettyTitle ?? option.title,
                    onTap: () => _onOptionTap(option),
                    trailing: option.isChecked
                        ? const Icon(
                            Icons.check,
                            color: ColorName.mountainMeadow,
                          )
                        : null,
                  );
                },
              ),
            ),
          ),
          if (widget.hasCustomValueSupport)
            SliverSafeArea(
              top: false,
              sliver: SliverToBoxAdapter(
                child: Column(children: [
                  ChooseValueCustomAddField(
                    onAdded: _onCustomOptionAdded,
                    hasNegativeValueSupport: widget.hasNegativeValueSupport,
                  ),
                  const VerticalSpacing(30),
                ]),
              ),
            ),
        ],
      ),
    );
  }
}
