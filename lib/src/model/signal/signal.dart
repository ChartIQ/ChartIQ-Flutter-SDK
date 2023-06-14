import 'package:chartiq_flutter_sdk/src/model/signal/signal_joiner.dart';
import 'package:collection/collection.dart';

import '../study/study.dart';
import 'condition.dart';

/// Encapsulates parameters with additional information for Study. ChartIQ uses the term “study” to refer to any indicator, oscillator, average, or signal that results from technical analysis of chart data.
class Signal {
  final String uniqueId;

  /// Name of Signal. Signal will be saved with this name and this name will appear in any study legend and in the expanded signal's title.
  final String name;

  /// Array of conditions; each condition is itself an array of [lhs, operator, rhs, color]
  final List<Condition> conditions;

  /// & or | to join conditions. If omitted, "|" assumed.
  final SignalJoiner joiner;

  /// Description of signal.
  final String description;
  final bool disabled;
  final Study study;

  Signal({
    required this.uniqueId,
    required this.name,
    required this.conditions,
    required this.joiner,
    required this.description,
    required this.disabled,
    required this.study,
  });

  factory Signal.fromJson(Map<String, dynamic> json) => Signal(
        uniqueId: json['uniqueId'],
        name: json['name'],
        conditions: List<Condition>.from(
            json['conditions'].map((x) => Condition.fromJson(x))),
        joiner: SignalJoiner.values
            .firstWhere((element) => element.value == json['joiner']),
        description: json['description'],
        disabled: json['disabled'],
        study: Study.fromJson(json['study']),
      );

  Map<String, dynamic> toJson() => {
        'uniqueId': uniqueId,
        'name': name,
        'conditions': List<dynamic>.from(conditions.map((x) => x.toJson())),
        'joiner': joiner.value,
        'description': description,
        'disabled': disabled,
        'study': study.toJson(),
      };

  @override
  int get hashCode =>
      uniqueId.hashCode ^
      name.hashCode ^
      conditions.hashCode ^
      joiner.hashCode ^
      description.hashCode ^
      disabled.hashCode ^
      study.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Signal &&
          runtimeType == other.runtimeType &&
          uniqueId == other.uniqueId &&
          name == other.name &&
          const DeepCollectionEquality.unordered()
              .equals(conditions, other.conditions) &&
          joiner == other.joiner &&
          description == other.description &&
          disabled == other.disabled &&
          study == other.study;
}
