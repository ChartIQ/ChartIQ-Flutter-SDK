import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/common_settings_items/text_field_setting_item.dart';
import 'package:example/common/widgets/custom_separated_list_view.dart';
import 'package:example/screen/signal/add_signal/widgets/text_area_list_tile.dart';
import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({
    Key? key,
    required this.onNameChanged,
    required this.onDescriptionChanged,
    this.nameValue,
    this.descriptionValue,
  }) : super(key: key);

  final ValueChanged<String?> onNameChanged, onDescriptionChanged;
  final String? nameValue, descriptionValue;

  @override
  Widget build(BuildContext context) {
    return CustomSeparatedListView.list(
      children: [
        TextAreaListTile(
          title: 'Description',
          placeholder:
              'Description will appear in an infobox when the signal is clicked',
          value: descriptionValue,
          onChanged: onDescriptionChanged,
        ),
        TextFieldSettingItem(
          title: context.translateWatch(RemoteLocaleKeys.name),
          placeholder: 'Enter a Name',
          value: nameValue,
          onChanged: onNameChanged,
        ),
      ],
    );
  }
}
