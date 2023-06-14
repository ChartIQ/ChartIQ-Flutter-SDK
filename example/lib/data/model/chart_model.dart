import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chart_model.g.dart';

@JsonSerializable()
class ChartModel {
  @JsonKey(name: 'DT')
  final String? date;
  @JsonKey(name: 'Open')
  final double? open;
  @JsonKey(name: 'High')
  final double? high;
  @JsonKey(name: 'Low')
  final double? low;
  @JsonKey(name: 'Close')
  final double? close;
  @JsonKey(name: 'Volume')
  final double? volume;
  @JsonKey(name: 'AdjClose')
  final double? adjClose;

  const ChartModel({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    required this.adjClose,
  });

  factory ChartModel.fromJson(Map<String, dynamic> json) =>
      _$ChartModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChartModelToJson(this);

  OHLCParams toOHLCParams() {
    return OHLCParams(
      date: date != null ? DateTime.tryParse(date!) : null,
      open: open,
      high: high,
      low: low,
      close: close,
      volume: volume,
      adjClose: adjClose,
    );
  }
}
