import 'package:flutter/material.dart';

class DrawingToolSectionTitle extends StatelessWidget {
  const DrawingToolSectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 14.0,
        left: 16.0,
        right: 16.0,
        bottom: 6.0,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 13),
      ),
    );
  }
}
