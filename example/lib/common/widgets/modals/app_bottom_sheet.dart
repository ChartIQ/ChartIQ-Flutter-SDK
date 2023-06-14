import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'floating_modal.dart';

Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool useRootNavigator = false,
}) async {
  if (MediaQuery.of(context).size.shortestSide <= 700) {
    return await showCupertinoModalBottomSheet<T>(
      context: context,
      builder: builder,
      useRootNavigator: useRootNavigator,
    );
  }
  return await Navigator.of(context, rootNavigator: true).push<T>(
    CupertinoModalBottomSheetRoute<T>(
      expanded: false,
      isDismissible: true,
      builder: builder,
      containerBuilder: (
          BuildContext context,
          Animation<double> animation,
          Widget child,
          ) {
        return Navigator(
          onGenerateRoute: (settings) {
            return MaterialWithModalsPageRoute(
              fullscreenDialog: true,
              settings: settings,
              builder: (_) => PrimaryScrollController(
                controller: ModalScrollController.of(context) ??
                    PrimaryScrollController.of(context),
                child: FloatingModal(child: child),
              ),
            );
          },
        );
      },
    ),
  );
}
