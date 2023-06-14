import 'package:flutter/material.dart';

@immutable
class AppCrosshairTextTheme extends ThemeExtension<AppCrosshairTextTheme> {
  const AppCrosshairTextTheme({
    required this.labelTextStyle,
    required this.valueTextStyle,
  });

  final TextStyle? labelTextStyle, valueTextStyle;

  @override
  AppCrosshairTextTheme copyWith({
    TextStyle? labelTextStyle,
    TextStyle? valueTextStyle,
  }) {
    return AppCrosshairTextTheme(
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      valueTextStyle: valueTextStyle ?? this.valueTextStyle,
    );
  }

  @override
  AppCrosshairTextTheme lerp(
      ThemeExtension<AppCrosshairTextTheme>? other, double t) {
    if (other is! AppCrosshairTextTheme) {
      return this;
    }
    return AppCrosshairTextTheme(
      labelTextStyle: TextStyle.lerp(
        labelTextStyle,
        other.labelTextStyle,
        t,
      ),
      valueTextStyle: TextStyle.lerp(
        valueTextStyle,
        other.valueTextStyle,
        t,
      ),
    );
  }
}
