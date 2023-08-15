import 'dart:io';

/// An enumeration of available signal joiners
enum SignalJoiner {
  /// Signal or
  or("OR"),

  /// Signal and
  and("AND");

  final String value;

  const SignalJoiner(this.value);

  /// Returns the platform value of the signal joiner
  ///
  /// Used by the native side to map the enum value to the platform value
  static SignalJoiner getPlatformJoiner(String value) {
    if (Platform.isIOS) return SignalJoiner.fromMarkString(value);
    return values.firstWhere((element) => element.value.toUpperCase() == value);
  }

  static SignalJoiner fromMarkString(String mark) {
    switch (mark) {
      case '|':
        return SignalJoiner.or;
      case '&':
        return SignalJoiner.and;
    }
    return SignalJoiner.or;
  }
}
