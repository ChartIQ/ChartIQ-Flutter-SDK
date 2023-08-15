import 'package:example/common/widgets/custom_icon_button.dart';
import 'package:example/common/widgets/spacing.dart';
import 'package:example/theme/app_assets.dart';
import 'package:flutter/material.dart';

class DrawingActionButtons extends StatelessWidget {
  const DrawingActionButtons({
    Key? key,
    required this.onUndo,
    required this.onRedo,
  }) : super(key: key);

  final VoidCallback onUndo, onRedo;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: [
          CustomIconButton(
            followForegroundIconThemeColor: false,
            icon: context.assets.undoIcon.path,
            onPressed: onUndo,
          ),
          const HorizontalSpacing(16),
          CustomIconButton(
            followForegroundIconThemeColor: false,
            icon: context.assets.redoIcon.path,
            onPressed: onRedo,
          ),
        ],
      ),
    );
  }
}
