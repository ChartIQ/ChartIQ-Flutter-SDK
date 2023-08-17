import 'package:example/common/widgets/buttons/app_bar_text_button.dart';
import 'package:example/common/widgets/custom_cupertino_search_field.dart';
import 'package:example/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({
    Key? key,
    this.onCancel,
    this.textController,
    this.onTextChanged,
  }) : super(key: key);

  final VoidCallback? onCancel;
  final TextEditingController? textController;
  final ValueChanged<String>? onTextChanged;

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: SizedBox(
        height: 200,
        child: CupertinoNavigationBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          border: Border(
            bottom: BorderSide(
              color: context.colors.modalAppBarUnderlineColor!,
              width: 0.3, // 0.0 means one physical pixel
            ),
          ),
          automaticallyImplyLeading: false,
          middle: Container(
            transform: Matrix4.translationValues(8, 0, 0),
            child: CustomCupertinoSearchField(
              controller: textController,
              onChanged: onTextChanged,
              autofocus: true,
            ),
          ),
          trailing: AppBarTextButton(
            onPressed: () => onCancel != null
                ? onCancel?.call()
                : Navigator.of(context, rootNavigator: true).pop(),
            padding: const EdgeInsets.only(left: 16),
            child: const Text('Cancel'),
          ),
        ),
      ),
    );
  }
}
