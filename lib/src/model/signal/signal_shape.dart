import 'dart:io';

/// An enumeration of available signal shapes
enum SignalShape {
  /// Signal shape for a circle
  circle("circle"),

  /// Signal shape for a square
  square("square"),

  /// Signal shape for a diamond
  diamond("diamond");

  final String value;

  const SignalShape(this.value);

  /// Returns a [SignalShape] from a [String] value
  static SignalShape fromString(String title) {
    return values.firstWhere(
      (element) => element.value.toLowerCase() == title.toLowerCase(),
      orElse: () => circle,
    );
  }

  String getPlatformValue() {
    if (Platform.isIOS) {
      return value;
    } else {
      return value.toUpperCase();
    }
  }
}
