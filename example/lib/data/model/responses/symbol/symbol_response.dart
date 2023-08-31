import 'package:json_annotation/json_annotation.dart';

import 'payload.dart';

part 'symbol_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SymbolResponse {
  @JsonKey(name: 'mime_type')
  final String mimeType;
  @JsonKey(name: 'payload')
  final Payload payload;
  @JsonKey(name: 'message')
  final String message;

  const SymbolResponse({
    required this.mimeType,
    required this.payload,
    required this.message,
  });

  factory SymbolResponse.fromJson(Map<String, dynamic> json) =>
      _$SymbolResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SymbolResponseToJson(this);
}
