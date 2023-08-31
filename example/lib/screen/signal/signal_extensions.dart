import 'package:chart_iq/chart_iq.dart';

extension SignalOperatorExtension on SignalOperator {
  bool get isNonValueItem =>
      this == SignalOperator.increases ||
      this == SignalOperator.decreases ||
      this == SignalOperator.doesNotChange ||
      this == SignalOperator.turnsUp ||
      this == SignalOperator.turnsDown;
}

extension SignalExtension on Signal {
  Signal copyWith({
    String? name,
    String? description,
    SignalJoiner? joiner,
    bool? disabled,
    List<Condition>? conditions,
    Study? study,
  }) {
    return Signal(
      uniqueId: uniqueId,
      name: name ?? this.name,
      description: description ?? this.description,
      conditions: conditions ?? this.conditions,
      disabled: disabled ?? this.disabled,
      study: study ?? this.study,
      joiner: joiner ?? this.joiner,
    );
  }
}

extension ConditionExtension on Condition {
  Condition copyWithIndicators({
    String? leftIndicator,
    String? rightIndicator,
  }) {
    return Condition(
      leftIndicator: leftIndicator ?? this.leftIndicator,
      rightIndicator: rightIndicator ?? this.rightIndicator,
      markerOption: markerOption,
      signalOperator: signalOperator,
    );
  }
}
