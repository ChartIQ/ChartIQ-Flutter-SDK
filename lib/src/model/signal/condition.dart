import 'marker_options.dart';
import 'signal_operator.dart';

///Encapsulates parameters with additional information for Study. ChartIQ uses the term “study” to refer to any indicator, oscillator, average, or signal that results from technical analysis of chart data.
class Condition {
  /// leftIndicator is a field in the study's outputMap ".
  final String leftIndicator;

  /// rightIndicator can be either a numeric value or a field in the study's outputMap
  final String? rightIndicator;

  /// signalOperator can be "<", "<=", "=", ">", ">=", "<>", ">p" (greater than previous), "<p" (less than previous), "=p" (same as previous), "x" (crosses another plot/value in either direction), "x+" (crosses another plot/value upwards", "x-" (crosses another plot/value downwards"
  final SignalOperator signalOperator;

  /// markerOption settings for main series marker. When multiple conditions match, markerOptions from the first matching condition are applied.
  final MarkerOption markerOption;

  Condition({
    required this.leftIndicator,
    required this.rightIndicator,
    required this.signalOperator,
    required this.markerOption,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        leftIndicator: json['leftIndicator'],
        rightIndicator: json['rightIndicator'],
        signalOperator: SignalOperator.values.firstWhere(
            (element) => element.value.toUpperCase() == json['signalOperator']),
        markerOption: MarkerOption.fromJson(json['markerOption']),
      );

  Map<String, dynamic> toJson() => {
        'leftIndicator': leftIndicator,
        'rightIndicator': rightIndicator,
        'signalOperator': signalOperator.getPlatformValue(),
        'markerOption': markerOption.toJson(),
      };

  // implement hash code and == operator to compare objects

  @override
  int get hashCode =>
      leftIndicator.hashCode ^
      rightIndicator.hashCode ^
      signalOperator.hashCode ^
      markerOption.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Condition &&
          runtimeType == other.runtimeType &&
          leftIndicator == other.leftIndicator &&
          rightIndicator == other.rightIndicator &&
          signalOperator == other.signalOperator &&
          markerOption == other.markerOption;
}
