/// A model to change a parameter in active study [Study]
class StudyParameterModel {
  final String fieldName;
  final String fieldSelectedValue;

  StudyParameterModel({
    required this.fieldName,
    required this.fieldSelectedValue,
  });

  factory StudyParameterModel.fromJson(Map<String, dynamic> json) {
    return StudyParameterModel(
      fieldName: json['fieldName'],
      fieldSelectedValue: json['fieldSelectedValue'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fieldName'] = fieldName;
    data['fieldSelectedValue'] = fieldSelectedValue;
    return data;
  }
}
