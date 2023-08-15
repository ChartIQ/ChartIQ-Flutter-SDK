import 'package:example/common/const/const.dart';
import 'package:flutter/material.dart';

class PickerColor {
  static const colorAlphaComponent = 'ff', hash = '#';

  final String value;

  const PickerColor(this.value);

  Color get colorFromHex =>
      Color(int.parse(value.substring(1, 7), radix: 16) + 0xFF000000);

  Color getColorWithAuto(BuildContext context) {
    if (value == 'auto' || value.isEmpty) {
      return Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black;
    } else {
      return colorFromHex;
    }
  }

  PickerColor getPickerColorWithAuto(BuildContext context) {
    if (value == 'auto' || value.isEmpty) {
      return Theme.of(context).brightness == Brightness.dark
          ? AppConst.defaultPickerColors.firstWhere(
              (element) => element.value == AppConst.whiteColorString)
          : AppConst.defaultPickerColors.firstWhere(
              (element) => element.value == AppConst.blackColorString);
    } else {
      return this;
    }
  }

  String get hexValueWithHash => colorFromHex.value
      .toRadixString(16)
      .replaceFirst(colorAlphaComponent, hash);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PickerColor &&
          runtimeType == other.runtimeType &&
          value.toLowerCase() == other.value.toLowerCase();

  @override
  int get hashCode => value.hashCode;
}
