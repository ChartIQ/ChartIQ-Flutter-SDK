import 'dart:io';

/// An enumeration of available signal operators
enum SignalOperator {
  /// Signal operator for a greater than
  greaterThan('greater_than'),

  /// Signal operator for a less than
  lessThan('less_than'),

  /// Signal operator for a equal to
  equalTo('equal_to'),

  /// Signal operator for a crosses
  crosses("crosses"),

  /// Signal operator for a crosses above
  crossesAbove("crosses_above"),

  /// Signal operator for a crosses below
  crossesBelow("crosses_below"),

  /// Signal operator for a turns up
  turnsUp("turns_up"),

  /// Signal operator for a turns down
  turnsDown("turns_down"),

  /// Signal operator for a increases
  increases("increases"),

  /// Signal operator for a decreases
  decreases("decreases"),

  /// Signal operator for a does not change
  doesNotChange("does_not_change");

  final String value;

  const SignalOperator(this.value);



  /// Returns a [SignalOperator] from a [String] value
  static SignalOperator fromMarkValue(String title) {
    switch (title) {
      case ">":
        return greaterThan;
      case "<":
        return lessThan;
      case "=":
        return equalTo;
      case "x":
        return crosses;
      case "x+":
        return crossesAbove;
      case "x-":
        return crossesBelow;
      case "t+":
        return turnsUp;
      case "t-":
        return turnsDown;
      case ">p":
        return increases;
      case "<p":
        return decreases;
      case "=p":
        return doesNotChange;
      default:
        return doesNotChange;
    }
  }

  static SignalOperator getPlatformOperator(String value) {
    if (Platform.isIOS) return SignalOperator.fromMarkValue(value);
    return values.firstWhere((element) => element.value.toUpperCase() == value);
  }

  String getPlatformValue() {
    if (Platform.isIOS) {
      return value;
    } else {
      return value.toUpperCase();
    }
  }
}
