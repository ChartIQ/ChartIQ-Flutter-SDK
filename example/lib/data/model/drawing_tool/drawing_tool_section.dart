import 'package:example/gen/localization/app_localizations.gen.dart';
import 'package:flutter/material.dart';

enum DrawingToolSection {
  other("other"),
  main("main");

  final String value;

  const DrawingToolSection(this.value);

  String getPrettyTitle(BuildContext context) {
    return L.of(context).drawingToolSectionTitle(value);
  }
}
