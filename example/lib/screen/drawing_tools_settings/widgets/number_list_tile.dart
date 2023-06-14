import 'package:example/common/utils/debouncer.dart';
import 'package:example/common/widgets/spacing.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/screen/drawing_tools_settings/model/drawing_tool_settings_item.dart';
import 'package:example/theme/app_text_field_theme.dart';
import 'package:flutter/material.dart';

class NumberListTile extends StatefulWidget {
  const NumberListTile({
    Key? key,
    required this.item,
    required this.onChanged,
  }) : super(key: key);

  final DrawingToolSettingsItemNumber item;
  final ValueChanged<String?> onChanged;

  @override
  State<NumberListTile> createState() => _NumberListTileState();
}

class _NumberListTileState extends State<NumberListTile> {
  static final _debouncer = Debouncer(milliseconds: 500);
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.item.number.toString();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: Theme.of(context).listTileTheme.contentPadding,
      color: Theme.of(context).listTileTheme.tileColor,
      child: Row(
        children: [
          Text(
            widget.item.title,
            style: Theme.of(context).textTheme.titleMedium!,
          ),
          const HorizontalSpacing(10),
          Expanded(
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.end,
              cursorColor: ColorName.mountainMeadow,
              style: Theme.of(context)
                  .extension<AppTextFieldTheme>()
                  ?.placeholderStyle,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
              onChanged: (value) => _debouncer.run(
                () => widget.onChanged(value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
