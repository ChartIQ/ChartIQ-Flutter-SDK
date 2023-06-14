import 'package:example/common/utils/debouncer.dart';
import 'package:example/common/widgets/spacing.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/theme/app_text_field_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldListTile extends StatefulWidget {
  const TextFieldListTile({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.trailing,
    this.placeholder,
  })  : supportsNegativeValues = false,
        isNumber = false,
        super(key: key);

  const TextFieldListTile.number({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.supportsNegativeValues = false,
    this.trailing,
    this.placeholder,
  })  : isNumber = true,
        super(key: key);

  final String title;
  final String? value, placeholder;
  final ValueChanged<String?> onChanged;
  final bool supportsNegativeValues;
  final bool isNumber;
  final Widget? trailing;

  @override
  State<TextFieldListTile> createState() => _TextFieldListTileState();
}

class _TextFieldListTileState extends State<TextFieldListTile> {
  static final _debouncer = Debouncer(milliseconds: 500);
  final _controller = TextEditingController();

  static final _negativeFormatter =
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.-]')),
      _positiveFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));

  @override
  void initState() {
    if (widget.value != null) _controller.text = widget.value!.toString();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextFieldListTile oldWidget) {
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
      height: 45,
      padding: Theme.of(context).listTileTheme.contentPadding,
      color: Theme.of(context).listTileTheme.tileColor,
      child: Row(
        children: [
          Text(
            widget.title,
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
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: widget.placeholder,
                hintStyle: Theme.of(context)
                    .extension<AppTextFieldTheme>()
                    ?.placeholderStyle,
              ),
              keyboardType: widget.isNumber
                  ? const TextInputType.numberWithOptions(
                      decimal: true,
                    )
                  : TextInputType.name,
              inputFormatters: [
                if (widget.isNumber)
                  widget.supportsNegativeValues
                      ? _negativeFormatter
                      : _positiveFormatter,
              ],
              onChanged: (value) => _debouncer.run(
                () => widget.onChanged(value),
              ),
            ),
          ),
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );
  }
}
