import 'package:flutter/material.dart';

@immutable
class AppTextFieldTheme extends ThemeExtension<AppTextFieldTheme> {
  const AppTextFieldTheme({
    required this.iconsColor,
    required this.backgroundColor,
    required this.textStyle,
    required this.placeholderStyle,
  });

  final Color? iconsColor, backgroundColor;
  final TextStyle? textStyle, placeholderStyle;

  @override
  AppTextFieldTheme copyWith({
    Color? iconsColor,
    Color? backgroundColor,
    TextStyle? textStyle,
    TextStyle? placeholderStyle,
  }) {
    return AppTextFieldTheme(
      iconsColor:
      iconsColor ?? this.iconsColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
      placeholderStyle: placeholderStyle ?? this.placeholderStyle,
    );
  }

  @override
  AppTextFieldTheme lerp(ThemeExtension<AppTextFieldTheme>? other, double t) {
    if (other is! AppTextFieldTheme) {
      return this;
    }
    return AppTextFieldTheme(
      iconsColor: Color.lerp(
        iconsColor,
        other.iconsColor,
        t,
      ),
      backgroundColor: Color.lerp(
        backgroundColor,
        other.backgroundColor,
        t,
      ),
      textStyle: TextStyle.lerp(
        textStyle,
        other.textStyle,
        t,
      ),
      placeholderStyle: TextStyle.lerp(
        placeholderStyle,
        other.placeholderStyle,
        t,
      ),
    );
  }
}
