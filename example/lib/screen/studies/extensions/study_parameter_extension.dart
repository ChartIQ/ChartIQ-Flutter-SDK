import 'package:chart_iq/chart_iq.dart';

extension StudyParameterTextExtension on StudyParameterText {
  StudyParameter copyWithNewValue({String? value}) {
    return StudyParameterText(
      heading: heading,
      name: name,
      parameterType: parameterType,
      defaultValue: defaultValue,
      value: value ?? this.value,
    );
  }
}

extension StudyParameterNumberExtension on StudyParameterNumber {
  StudyParameter copyWithNewValue({double? value}) {
    return StudyParameterNumber(
      heading: heading,
      name: name,
      parameterType: parameterType,
      defaultValue: defaultValue,
      value: value ?? this.value,
    );
  }
}

extension StudyParameterColorExtension on StudyParameterColor {
  StudyParameter copyWithNewValue({String? value}) {
    return StudyParameterColor(
      heading: heading,
      name: name,
      parameterType: parameterType,
      defaultValue: defaultValue,
      value: value ?? this.value,
    );
  }
}

extension StudyParameterTextColorExtension on StudyParameterTextColor {
  StudyParameter copyWithNewValue({String? color, double? value}) {
    return StudyParameterTextColor(
      heading: heading,
      name: name,
      parameterType: parameterType,
      defaultColor: defaultColor,
      color: color ?? this.color,
      defaultValue: defaultValue,
      value: value ?? this.value,
    );
  }
}

extension StudyParameterCheckboxExtension on StudyParameterCheckbox {
  StudyParameter copyWithNewValue({bool? value}) {
    return StudyParameterCheckbox(
      heading: heading,
      name: name,
      parameterType: parameterType,
      defaultValue: defaultValue,
      value: value ?? this.value,
    );
  }
}

extension StudyParameterSelectExtension on StudyParameterSelect {
  StudyParameter copyWithNewValue({String? value}) {
    return StudyParameterSelect(
      heading: heading,
      name: name,
      parameterType: parameterType,
      options: options,
      defaultValue: defaultValue,
      value: value ?? this.value,
    );
  }
}
