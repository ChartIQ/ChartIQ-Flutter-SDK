import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/animations/custom_fade_in_container.dart';
import 'package:example/common/widgets/buttons/app_action_button.dart';
import 'package:example/common/widgets/spacing.dart';
import 'package:example/theme/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    Key? key,
    required this.title,
    this.icon,
    this.buttonText,
    this.onButtonPressed,
    this.subtitle,
    this.backgroundColor,
  }) : super(key: key);

  final String title;
  final String? buttonText, subtitle, icon;
  final VoidCallback? onButtonPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CustomFadeInContainer(
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.only(
          top: 94.0,
          left: 38.0,
          right: 38.0,
          bottom: 16,
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              icon ?? context.assets.searchIcon.path,
              width: 120,
              height: 120,
            ),
            const VerticalSpacing(32),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            if (subtitle != null) ...[
              const VerticalSpacing(12),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      height: 1.5,
                    ),
              ),
            ],
            if (onButtonPressed != null && buttonText != null) ...[
              const VerticalSpacing(32),
              Row(
                children: [
                  Expanded(
                    child: AppActionButton(
                      onPressed: onButtonPressed!,
                      child: Text(
                        buttonText!.capitalizeAll(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const VerticalSpacing(16),
          ],
        ),
      ),
    );
  }
}
