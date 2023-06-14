import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/bottom_sheet_scroll_physics.dart';
import 'package:example/common/widgets/app_bars/modal_app_bar.dart';
import 'package:example/common/widgets/common_settings_items/choose_setting_item.dart';
import 'package:example/common/widgets/common_settings_items/switch_setting_item.dart';
import 'package:example/common/widgets/custom_separated_list_view.dart';
import 'package:example/common/widgets/spacing.dart';
import 'package:example/data/model/chartiq_language_enum.dart';
import 'package:example/data/model/option_item_model.dart';
import 'package:example/providers/locale_provider.dart';
import 'package:example/screen/home/main_vm.dart';
import 'package:example/screen/settings/settings_vm.dart';
import 'package:example/screen/settings/widgets/section_headline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SettingsVM>(context);
    final l = context.watch<LocaleProvider>();

    final settingsList = [
      SwitchSettingItem(
        title: vm.logScale.getLocalizedValue(context),
        onChanged: (_) => vm.setChartScale(),
        value: vm.logScale.selected,
      ),
      SwitchSettingItem(
        title: vm.invertYAxis.getLocalizedValue(context),
        onChanged: (_) => vm.setIsInvertYAxis(),
        value: vm.invertYAxis.selected,
      ),
      SwitchSettingItem(
        title: vm.extendHours.getLocalizedValue(context),
        onChanged: (_) => vm.setExtendHours(),
        value: vm.extendHours.selected,
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: ModalAppBar(
        middleText: l.translate(RemoteLocaleKeys.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: SingleChildScrollView(
          physics: const BottomSheetScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpacing(50),
              SectionHeadline(
                text: l
                    .translate(RemoteLocaleKeys.chartPreferences)
                    .toUpperCase(),
              ),
              CustomSeparatedListView(
                itemCount: settingsList.length,
                itemBuilder: (context, index) {
                  return settingsList[index];
                },
              ),
              const VerticalSpacing(50),
              SectionHeadline(
                text: l
                    .translate(RemoteLocaleKeys.languagePreferences)
                    .toUpperCase(),
              ),
              const SafeArea(top: false, bottom: false, child: Divider()),
              SafeArea(
                top: false,
                bottom: false,
                child: ChooseSettingItem(
                  isGeneralDialog: false,
                  title: l.translate(RemoteLocaleKeys.language),
                  options: ChartIQLanguage.values
                      .map(
                        (e) => OptionItemModel(
                          title: e.name,
                          isChecked: e == l.appLanguage,
                        ),
                      )
                      .toList(),
                  onChanged: (language) {
                    l.set(
                      ChartIQLanguage.values
                          .where(
                            (element) => element.name == language[0].title,
                          )
                          .first,
                      context.read<MainVM>().chartIQController!,
                    );
                  },
                ),
              ),
              const SafeArea(top: false, child: Divider()),
            ],
          ),
        ),
      ),
    );
  }
}
