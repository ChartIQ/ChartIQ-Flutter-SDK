import 'package:example/common/widgets/animations/custom_fade_in_container.dart';
import 'package:example/common/widgets/animations/custom_scale_down_container.dart';
import 'package:flutter/cupertino.dart';

class ConfirmationDialogBody extends StatelessWidget {
  const ConfirmationDialogBody({
    Key? key,
    required this.title,
    required this.content,
    required this.confirmText,
    this.isConfirmDangerousAction = true,
  }) : super(key: key);

  final String title, content, confirmText;
  final bool isConfirmDangerousAction;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: const CupertinoThemeData(),
      child: CustomScaleDownContainer(
        customDuration: const Duration(milliseconds: 200),
        child: CustomFadeInContainer(
          customDuration: const Duration(milliseconds: 200),
          child: CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: isConfirmDangerousAction,
                onPressed: () => Navigator.pop(context, true),
                child: Text(confirmText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
