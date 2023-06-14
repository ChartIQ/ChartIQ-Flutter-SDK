import 'package:flutter/material.dart';

class VerticalSpacing extends StatelessWidget {
  final int spacing;

  const VerticalSpacing(this.spacing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(height: spacing.toDouble());
}

class HorizontalSpacing extends StatelessWidget {
  final int spacing;

  const HorizontalSpacing(this.spacing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(width: spacing.toDouble());
}
