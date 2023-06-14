import 'package:example/common/widgets/buttons/app_action_button.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/theme/app_text_field_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChooseValueCustomAddField extends StatefulWidget {
  const ChooseValueCustomAddField({
    Key? key,
    this.hasNegativeValueSupport = true,
    required this.onAdded,
  }) : super(key: key);

  final bool hasNegativeValueSupport;
  final ValueChanged<String?> onAdded;

  static final _negativeFormatter =
  FilteringTextInputFormatter.allow(RegExp(r'[0-9.-]')),
      _positiveFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));

  @override
  State<ChooseValueCustomAddField> createState() =>
      _ChooseValueCustomAddFieldState();
}

class _ChooseValueCustomAddFieldState extends State<ChooseValueCustomAddField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        SizedBox(
          height: 45,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      widget.hasNegativeValueSupport
                          ? ChooseValueCustomAddField._negativeFormatter
                          : ChooseValueCustomAddField._positiveFormatter,
                    ],
                    style: Theme.of(context)
                        .extension<AppTextFieldTheme>()
                        ?.textStyle,
                    cursorColor: ColorName.mountainMeadow,
                    decoration: InputDecoration(
                      hintText: 'Custom %',
                      hintStyle: Theme.of(context)
                          .extension<AppTextFieldTheme>()
                          ?.placeholderStyle,
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Theme.of(context).listTileTheme.tileColor,
                    ),
                  ),
                ),
                AppActionButton(
                  onPressed: () {
                    widget.onAdded(_controller.text);
                    _controller.clear();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: const Text("Add"),
                )
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
