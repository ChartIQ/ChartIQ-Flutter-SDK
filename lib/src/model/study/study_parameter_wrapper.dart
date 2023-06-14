
import 'dart:convert';

class StudyParameterWrapper {
  final String type;
  final Map<String, dynamic> value;

  StudyParameterWrapper({
    required this.type,
    required this.value,
  });

  factory StudyParameterWrapper.fromJson(Map<String, dynamic> json) {
    return StudyParameterWrapper(
      type: json['type'],
      value: jsonDecode(json['value']),
    );
  }
}