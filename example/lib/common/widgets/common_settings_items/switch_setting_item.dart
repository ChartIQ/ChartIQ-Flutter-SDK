import 'package:example/common/widgets/list_tiles/custom_trailing_list_tile.dart';
import 'package:flutter/cupertino.dart';

class SwitchSettingItem extends StatelessWidget {
  const SwitchSettingItem(
      {Key? key,
      required this.title,
      required this.value,
      required this.onChanged})
      : super(key: key);

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomTrailingListTile(
      title: title,
      onTap: () => onChanged(!value),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
