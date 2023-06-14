import 'package:example/common/widgets/list_tiles/custom_trailing_list_tile.dart';
import 'package:example/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class FontStyleListTile extends StatelessWidget {
  const FontStyleListTile({
    Key? key,
    this.isBold = false,
    this.isItalic = false,
    this.onBoldTap,
    this.onItalicTap,
  }) : super(key: key);

  final bool isBold, isItalic;
  final VoidCallback? onBoldTap, onItalicTap;

  @override
  Widget build(BuildContext context) {
    return CustomTrailingListTile(
      title: 'Font style',
      trailing: _buildTrailing(context),
    );
  }

  Widget _buildTrailing(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: [
        _buildSelectButton(
          context,
          'B',
          isSelected: isBold,
          textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w900,
              ),
          onTap: onBoldTap,
        ),
        _buildSelectButton(
          context,
          'I',
          isSelected: isItalic,
          textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
          onTap: onItalicTap,
        ),
      ],
    );
  }

  Widget _buildSelectButton(
    BuildContext context,
    String text, {
    required TextStyle textStyle,
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(3),
      child: Container(
        width: 32,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.fromBorderSide(
            isSelected
                ? const BorderSide(
                    color: ColorName.mountainMeadow,
                    width: 1,
                  )
                : Theme.of(context).chipTheme.shape!.side,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
