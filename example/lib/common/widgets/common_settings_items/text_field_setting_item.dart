import 'package:example/common/widgets/common_settings_items/widgets/text_field_list_tile.dart';
import 'package:flutter/material.dart';

class TextFieldSettingItem extends StatelessWidget {
  const TextFieldSettingItem({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.placeholder,
    this.onTapOutside,
  })  : _isNumber = false,
        supportNegativeValues = false,
        super(key: key);

  const TextFieldSettingItem.number({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.supportNegativeValues = false,
    this.placeholder,
    this.onTapOutside,
  })  : _isNumber = true,
        super(key: key);

  final String title;
  final String? value, placeholder;
  final ValueChanged<String?> onChanged;
  final ValueChanged<String?>? onTapOutside;
  final bool supportNegativeValues, _isNumber;

  @override
  Widget build(BuildContext context) {
    if (!_isNumber) {
      return TextFieldListTile(
        title: title,
        value: value,
        onChanged: onChanged,
        placeholder: placeholder,
        onTapOutside: onTapOutside,
      );
    }
    return TextFieldListTile.number(
      title: title,
      value: value,
      onChanged: onChanged,
      supportsNegativeValues: supportNegativeValues,
      placeholder: placeholder,
      onTapOutside: onTapOutside,
    );
  }
}
