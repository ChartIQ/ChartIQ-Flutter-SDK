// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fib_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FibModel _$FibModelFromJson(Map<String, dynamic> json) => FibModel(
      level: (json['level'] as num).toDouble(),
      display: json['display'] as bool? ?? false,
    );

Map<String, dynamic> _$FibModelToJson(FibModel instance) => <String, dynamic>{
      'level': instance.level,
      'display': instance.display,
    };
