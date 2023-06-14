import 'study_parameter_type.dart';

/// A base class of active study parameter
class StudyParameter {
  /// A user-friendly name of the parameter
  final String heading;

  /// A name of a parameter to be used as identifier of a parameter
  final String name;

  /// A parameter type
  final StudyParameterType parameterType;

  StudyParameter({
    required this.heading,
    required this.name,
    required this.parameterType,
  });
}

/// A text parameter of active study [Study]
class StudyParameterText extends StudyParameter {
  /// A default [String] value  of text parameter
  final String defaultValue;

  /// A current [String] value of text parameter
  final String value;

  StudyParameterText({
    required String heading,
    required String name,
    required StudyParameterType parameterType,
    required this.defaultValue,
    required this.value,
  }) : super(heading: heading, name: name, parameterType: parameterType);

  factory StudyParameterText.fromJson(Map<String, dynamic> json) {
    return StudyParameterText(
      heading: json['heading'],
      name: json['name'],
      parameterType: StudyParameterType.values
          .firstWhere((element) => element.value == json['parameterType']),
      defaultValue: json['defaultValue'],
      value: json['value'],
    );
  }
}

/// A number parameter of active study [Study]
class StudyParameterNumber extends StudyParameter {
  /// A default [Double] value of text parameter
  final double defaultValue;

  /// A current [Double] value of text parameter
  final double value;

  StudyParameterNumber({
    required String heading,
    required String name,
    required StudyParameterType parameterType,
    required this.defaultValue,
    required this.value,
  }) : super(heading: heading, name: name, parameterType: parameterType);

  factory StudyParameterNumber.fromJson(Map<String, dynamic> json) {
    return StudyParameterNumber(
      heading: json['heading'],
      name: json['name'],
      parameterType: StudyParameterType.values
          .firstWhere((element) => element.value == json['parameterType']),
      defaultValue: json['defaultValue'],
      value: json['value'],
    );
  }
}

/// A color parameter of active study [Study]
class StudyParameterColor extends StudyParameter {
  /// A default color string value of a parameter
  final String defaultValue;

  /// A current color string value of a parameter. A format is <code>#RRGGBB</code>
  final String value;

  StudyParameterColor({
    required String heading,
    required String name,
    required StudyParameterType parameterType,
    required this.defaultValue,
    required this.value,
  }) : super(heading: heading, name: name, parameterType: parameterType);

  factory StudyParameterColor.fromJson(Map<String, dynamic> json) {
    return StudyParameterColor(
      heading: json['heading'],
      name: json['name'],
      parameterType: StudyParameterType.values
          .firstWhere((element) => element.value == json['parameterType']),
      defaultValue: json['defaultValue'],
      value: json['value'],
    );
  }
}

/// A parameter of active study [Study] that contains a number and a color
class StudyParameterTextColor extends StudyParameter {
  /// A default color string value of a parameter
  final String defaultColor;

  /// A current color string value of a parameter. A format is <code>#RRGGBB</code>
  final String color;

  /// A default [Double] value of a parameter
  final double defaultValue;

  /// A current [Double] value of text a parameter
  final double value;

  StudyParameterTextColor({
    required String heading,
    required String name,
    required StudyParameterType parameterType,
    required this.defaultColor,
    required this.color,
    required this.defaultValue,
    required this.value,
  }) : super(heading: heading, name: name, parameterType: parameterType);

  factory StudyParameterTextColor.fromJson(Map<String, dynamic> json) {
    return StudyParameterTextColor(
      heading: json['heading'],
      name: json['name'],
      parameterType: StudyParameterType.values
          .firstWhere((element) => element.value == json['parameterType']),
      defaultColor: json['defaultColor'],
      color: json['color'],
      defaultValue: json['defaultValue'],
      value: json['value'],
    );
  }
}

/// A boolean parameter of active study [Study]
class StudyParameterCheckbox extends StudyParameter {
  /// A default [bool] value of a parameter
  final bool defaultValue;

  /// A current [bool] value of a parameter
  final bool value;

  StudyParameterCheckbox({
    required String heading,
    required String name,
    required StudyParameterType parameterType,
    required this.defaultValue,
    required this.value,
  }) : super(heading: heading, name: name, parameterType: parameterType);

  factory StudyParameterCheckbox.fromJson(Map<String, dynamic> json) {
    return StudyParameterCheckbox(
      heading: json['heading'],
      name: json['name'],
      parameterType: StudyParameterType.values
          .firstWhere((element) => element.value == json['parameterType']),
      defaultValue: json['defaultValue'],
      value: json['value'],
    );
  }
}

/// A parameter of active study [Study] that has a limited list of possible options
class StudyParameterSelect extends StudyParameter {
  /// A default value of a parameter
  final String defaultValue;

  /// A current value of a parameter
  final String value;

  /// A list of possible options
  final Map<String, String> options;

  StudyParameterSelect({
    required String heading,
    required String name,
    required StudyParameterType parameterType,
    required this.defaultValue,
    required this.value,
    required this.options,
  }) : super(heading: heading, name: name, parameterType: parameterType);

  factory StudyParameterSelect.fromJson(Map<String, dynamic> json) {
    return StudyParameterSelect(
      heading: json['heading'],
      name: json['name'],
      parameterType: StudyParameterType.values
          .firstWhere((element) => element.value == json['parameterType']),
      defaultValue: json['defaultValue'],
      value: json['value'],
      options: (json['options'] as Map<String, dynamic>).map((key, value) => MapEntry(key.toString(), value.toString()))
    );
  }
}