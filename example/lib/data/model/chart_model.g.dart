// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartModel _$ChartModelFromJson(Map<String, dynamic> json) => ChartModel(
      date: json['DT'] as String?,
      open: (json['Open'] as num?)?.toDouble(),
      high: (json['High'] as num?)?.toDouble(),
      low: (json['Low'] as num?)?.toDouble(),
      close: (json['Close'] as num?)?.toDouble(),
      volume: (json['Volume'] as num?)?.toDouble(),
      adjClose: (json['AdjClose'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ChartModelToJson(ChartModel instance) =>
    <String, dynamic>{
      'DT': instance.date,
      'Open': instance.open,
      'High': instance.high,
      'Low': instance.low,
      'Close': instance.close,
      'Volume': instance.volume,
      'AdjClose': instance.adjClose,
    };
