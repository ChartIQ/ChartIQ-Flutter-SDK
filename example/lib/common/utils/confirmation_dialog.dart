import 'package:example/common/widgets/modals/confirmation_dialog_body.dart';
import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(
  BuildContext context,
  String title,
  String content,
  String confirmText, {
  bool isConfirmDangerousAction = true,
  bool useRootNavigator = false,
}) async {
  return await showGeneralDialog<bool>(
    useRootNavigator: useRootNavigator,
    context: context,
    barrierDismissible: false,
    pageBuilder: (ctx, __, ___) {
      return ConfirmationDialogBody(
        title: title,
        content: content,
        confirmText: confirmText,
        isConfirmDangerousAction: isConfirmDangerousAction,
      );
    },
  );
}
