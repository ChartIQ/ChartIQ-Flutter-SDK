import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:example/theme/app_text_field_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoSearchField extends StatefulWidget {
  const CustomCupertinoSearchField({
    Key? key,
    this.controller,
    this.onChanged,
    this.autofocus,
  }) : super(key: key);

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool? autofocus;

  @override
  State<CustomCupertinoSearchField> createState() =>
      _CustomCupertinoSearchFieldState();
}

class _CustomCupertinoSearchFieldState
    extends State<CustomCupertinoSearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    final textFieldTheme = Theme.of(context).extension<AppTextFieldTheme>();
    return CupertinoTextField(
      onChanged: widget.onChanged,
      controller: _controller,
      autofocus: widget.autofocus ?? false,
      style: textFieldTheme?.textStyle,
      placeholder: context.translateWatch(RemoteLocaleKeys.search),
      placeholderStyle: textFieldTheme?.placeholderStyle,
      padding: const EdgeInsets.symmetric(vertical: 8),
      suffixMode: OverlayVisibilityMode.editing,
      suffix: GestureDetector(
        onTap: _clear,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            CupertinoIcons.clear_thick_circled,
            color: textFieldTheme?.iconsColor,
          ),
        ),
      ),
      prefix: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(
          Icons.search,
          color: textFieldTheme?.iconsColor,
        ),
      ),
      cursorColor: ColorName.mountainMeadow,
      decoration: BoxDecoration(
        color: textFieldTheme?.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
