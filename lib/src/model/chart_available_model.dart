class ChartAvailableModel {
  final String? type;
  final bool available;

  ChartAvailableModel({this.type, required this.available});

  ChartAvailableModel.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        available = json['available'];
}
