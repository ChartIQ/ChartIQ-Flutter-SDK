import 'package:json_annotation/json_annotation.dart';

part 'fib_model.g.dart';

@JsonSerializable()
class FibModel {
  final double level;
  @JsonKey(defaultValue: false)
  final bool display;

  const FibModel({
    required this.level,
    required this.display,
  });

  factory FibModel.fromJson(Map<String, dynamic> json) =>
      _$FibModelFromJson(json);

  Map<String, dynamic> toJson() => _$FibModelToJson(this);
}
