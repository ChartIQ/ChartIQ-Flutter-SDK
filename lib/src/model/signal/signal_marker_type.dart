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
      (element) => element.value.toLowerCase() == title.toLowerCase(),
      orElse: () => paintbar,
    );
  }

  String getPlatformValue() {
    if (Platform.isIOS) {
      return value;
    } else {
      return value.toUpperCase();
    }
  }

  String getPrettyTitle() {
    switch(this) {
      case SignalMarkerType.marker:
        return 'Chart Marker';
      case SignalMarkerType.paintbar:
        return 'Paintbar';
    }
  }
}
