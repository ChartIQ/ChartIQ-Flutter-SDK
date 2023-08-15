import 'package:example/common/const/const.dart';
import 'package:example/common/utils/debouncer.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/theme/app_text_field_theme.dart';
import 'package:flutter/material.dart';

class TextAreaListTile extends StatefulWidget {
  const TextAreaListTile({
    Key? key,
    required this.title,
    required this.value,
    this.placeholder,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final String? value, placeholder;
  final ValueChanged<String?> onChanged;

  @override
  State<TextAreaListTile> createState() => _TextAreaListTileState();
}

class _TextAreaListTileState extends State<TextAreaListTile> {
  static final _debouncer = Debouncer(milliseconds: 500);
  final _controller = TextEditingController();

  @override
  void initState() {
    if (widget.value != null) _controller.text = widget.value!.toString();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextAreaListTile oldWidget) {
    if (widget.value != oldWidget.value && widget.value != _controller.text) {
      _controller.text = widget.value.toString();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: AppConst.kListTileSeparatorIndent,
      ),
      color: Theme.of(context).listTileTheme.tileColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium!,
          ),
          TextField(
            controller: _controller,
            cursorColor: ColorName.mountainMeadow,
            maxLines: 3,
            style: Theme.of(context)
                .extension<AppTextFieldTheme>()
                ?.placeholderStyle,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              label: Text(
                widget.placeholder ?? "",
                style: Theme.of(context)
                    .extension<AppTextFieldTheme>()
                    ?.placeholderStyle,
              ),
            ),
            keyboardType: TextInputType.name,
            onChanged: (value) => _debouncer.run(
              () => widget.onChanged(value),
            ),
          ),
        ],
      ),
    );
  }
}
