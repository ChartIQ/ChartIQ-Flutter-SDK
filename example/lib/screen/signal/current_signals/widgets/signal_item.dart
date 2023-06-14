import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:example/common/widgets/buttons/custom_slidable_button.dart';
import 'package:example/common/widgets/list_tiles/custom_trailing_list_tile.dart';
import 'package:example/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SignalItem extends StatelessWidget {
  const SignalItem({
    Key? key,
    required this.signal,
    required this.onToggleSignal,
    required this.onRemoveSignal,
    required this.onSignalTap,
  }) : super(key: key);

  final Signal signal;
  final void Function(bool) onToggleSignal;
  final void Function(Signal) onRemoveSignal, onSignalTap;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(signal.hashCode),
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        dismissible: DismissiblePane(
          onDismissed: () => onRemoveSignal(signal),
        ),
        dragDismissible: true,
        extentRatio: 0.4,
        children: [
          CustomSlidableButton(
            text: context.translateWatch(RemoteLocaleKeys.delete),
            onTap: () => onRemoveSignal(signal),
          ),
        ],
      ),
      child: CustomTrailingListTile(
        title: signal.name,
        onTap: () => onSignalTap(signal),
        trailing: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          children: [
            CupertinoSwitch(
              value: !signal.disabled,
              onChanged: onToggleSignal,
            ),
            Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20,
              color: context.colors.listTileTrailingIconColor,
            ),
          ],
        ),
      ),
    );
  }
}
