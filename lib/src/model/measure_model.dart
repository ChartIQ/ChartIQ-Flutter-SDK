class MeasureModel {
  final String? type;
  final String? measure;

  MeasureModel({this.type, required this.measure});

  MeasureModel.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        measure = json['measure'];
}
