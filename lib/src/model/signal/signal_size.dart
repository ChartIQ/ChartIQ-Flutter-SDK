import 'dart:io';

/// An enumeration of available signal sizes
enum SignalSize {
  /// Signal size for a small
  S("small"),

  /// Signal size for a medium
  M("medium"),

  /// Signal size for a large
  L("large");

  final String value;

  const SignalSize(this.value);

  static SignalSize getPlatformSize(String value) {
    if (Platform.isIOS) return SignalSize.fromMarkValue(value);
    return values.firstWhere(
        (element) => element.name.toLowerCase() == value.toLowerCase());
  }

  /// Returns a [SignalSize] from a [String] value
  static SignalSize fromMarkValue(String title) {
    switch (title) {
      case 'S':
        return S;
      case 'M':
        return M;
      case 'L':
        return L;
      default:
        return M;
    }
  }

  String getPlatformValue() {
    if (Platform.isAndroid) {
      return name;
    } else {
      return value;
    }
  }
}
