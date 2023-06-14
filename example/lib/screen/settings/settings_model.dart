import 'package:example/common/utils/extensions.dart';
import 'package:flutter/material.dart';

class SettingsModel {
  final String translationKey;
  bool selected = false;

  SettingsModel(this.translationKey);

  bool switchSelected({bool? value}) => selected = value ?? !selected;

  String getLocalizedValue(BuildContext context) =>
      context.translate(translationKey);
}
