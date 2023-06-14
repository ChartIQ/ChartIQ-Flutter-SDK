import 'dart:io';

/// An enumeration of available signal marker types
enum SignalMarkerType {
  /// Signal marker type for a marker
  marker('marker'),

  /// Signal operator for a paintbar
  paintbar('paintbar');

  final String value;

  const SignalMarkerType(this.value);

  /// Returns a [SignalMarkerType] from a [String] value
  static SignalMarkerType fromString(String title) {
    return values.firstWhere(
      (element) => element.value == title.toLowerCase(),
      orElse: () => paintbar,
    );
  }

  String getPlatformValue() {
    if (Platform.isAndroid) {
      return value.toUpperCase();
    } else {
      return value;
    }
  }
}
