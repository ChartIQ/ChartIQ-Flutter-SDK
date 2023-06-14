import 'package:flutter/material.dart';

class AppBarControlButtonsWrapper extends StatelessWidget {
  const AppBarControlButtonsWrapper({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.end,
      alignment: WrapAlignment.end,
      children: children,
    );
  }
}
