import 'package:flutter/material.dart';

class SectionHeadline extends StatelessWidget {
  const SectionHeadline({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(left: 14, bottom: 6, right: 14),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Theme.of(context).textTheme.labelMedium!.color,
              ),
        ),
      ),
    );
  }
}
