// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symbol_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SymbolResponse _$SymbolResponseFromJson(Map<String, dynamic> json) =>
    SymbolResponse(
      mimeType: json['mime_type'] as String,
      payload: Payload.fromJson(json['payload'] as Map<String, dynamic>),
      message: json['message'] as String,
    );

Map<String, dynamic> _$SymbolResponseToJson(SymbolResponse instance) =>
    <String, dynamic>{
      'mime_type': instance.mimeType,
      'payload': instance.payload.toJson(),
      'message': instance.message,
    };
