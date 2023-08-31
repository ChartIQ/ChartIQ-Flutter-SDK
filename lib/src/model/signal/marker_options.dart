import 'signal_marker_type.dart';
import 'signal_position.dart';
import 'signal_shape.dart';
import 'signal_size.dart';

/// Optional settings for main series marker. When multiple conditions match, markerOptions from the first matching condition are applied.
class MarkerOption {
  /// type of the signal marker on the chart. If omitted, "marker" assumed.
  final SignalMarkerType type;

  /// color of the signal marker on the chart. If omitted, the color of the main series is used.
  final String? color;

  /// signalShape of the signal marker on the chart. The shape of the marker on the study will always be "circle". If omitted, "circle" assumed.".
  final SignalShape signalShape;

  /// signalSize of the signal marker on the chart. Possible values are S/M/L. The size of the marker on the study will always be S. If omitted, "S" assumed.
  final SignalSize signalSize;

  /// label Optional string to display in the marker."
  final String? label;

  /// signalPosition Where to display the signal as a marker in relation to the main plot. If omitted, "above_candle" assumed.
  final SignalPosition signalPosition;

  MarkerOption({
    required this.type,
    required this.color,
    required this.signalShape,
    required this.signalSize,
    required this.label,
    required this.signalPosition,
  });

  factory MarkerOption.fromJson(Map<String, dynamic> json) => MarkerOption(
        type: SignalMarkerType.fromString(json['type']),
        color: json['color'],
        signalShape: SignalShape.fromString(json['signalShape']),
        signalSize: SignalSize.getPlatformSize(json['signalSize']),
        label: json['label'],
        signalPosition: SignalPosition.fromString(json['signalPosition']),
      );

  Map<String, dynamic> toJson() => {
        'type': type.getPlatformValue(),
        'color': color,
        'signalShape': signalShape.getPlatformValue(),
        'signalSize': signalSize.getPlatformValue(),
        'label': label,
        'signalPosition': signalPosition.getPlatformValue(),
      };

  // implement hash code and == operator to compare objects

  @override
  int get hashCode =>
      type.hashCode ^
      color.hashCode ^
      signalShape.hashCode ^
      signalSize.hashCode ^
      label.hashCode ^
      signalPosition.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarkerOption &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          color == other.color &&
          signalShape == other.signalShape &&
          signalSize == other.signalSize &&
          label == other.label &&
          signalPosition == other.signalPosition;
}
