import 'dart:io';

/// An enumeration of available signal positions
enum SignalPosition {
  /// Signal position for a above candle
  aboveCandle("above_candle"),

  /// Signal position for a below candle
  belowCandle("below_candle"),

  /// Signal position for a on candle
  onCandle("on_candle");

  final String value;

  const SignalPosition(this.value);

  /// Returns a [SignalPosition] from a [String] value
  static SignalPosition fromString(String title) {
    return values.firstWhere(
      (element) => element.value.toLowerCase() == title.toLowerCase(),
      orElse: () => onCandle,
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
