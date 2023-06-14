import '../../chartiq_flutter_sdk.dart';

class DataPullModel {
  final String? type;
  final QuoteFeedParams params;

  DataPullModel({this.type, required this.params});

  DataPullModel.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        params = QuoteFeedParams.fromJson(json['params']);
}
