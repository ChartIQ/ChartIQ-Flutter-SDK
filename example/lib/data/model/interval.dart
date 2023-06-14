import 'package:example/providers/locale_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'time_unit_enum.dart';

class ChartInterval {
  final int period, interval;
  final ChartIQTimeUnit timeUnit;

  ChartInterval({
    required this.period,
    required this.interval,
    required this.timeUnit,
  });

  int get _fullPeriodicity {
    int full = period * interval;
    if (timeUnit == ChartIQTimeUnit.hour) {
      full = (full / 60).floor();
    }
    return full;
  }

  ChartIQTimeUnit getSafeTimeUnit() {
    if (timeUnit == ChartIQTimeUnit.hour) {
      return ChartIQTimeUnit.minute;
    }
    return timeUnit;
  }

  factory ChartInterval.createInterval(
      int period, String interval, String timeUnit) {
    ChartIQTimeUnit? unit;
    int convertedInterval;
    if (timeUnit == 'null') {
      unit = ChartIQTimeUnit.values.firstWhere(
          (element) => element.name == interval.replaceAll('"', ''));
      convertedInterval = 1;
    } else {
      convertedInterval = int.parse(interval);
      unit = (convertedInterval * period % 60 == 0)
          ? ChartIQTimeUnit.hour
          : ChartIQTimeUnit.values
              .firstWhere((element) => element.name == timeUnit);
    }
    return ChartInterval(
      period: period,
      interval: convertedInterval,
      timeUnit: unit,
    );
  }

  String getPrettyValue(BuildContext context) {
    final l = context.read<LocaleProvider>();
    late final String localizedTimeUnit;
    switch (timeUnit) {
      case ChartIQTimeUnit.day:
        localizedTimeUnit =
            l.translate(timeUnit.getFullTranslationKey()).toLowerCase();
        break;
      default:
        localizedTimeUnit =
            l.translate(timeUnit.getFullTranslationKey()).toLowerCase();
    }

    return "$_fullPeriodicity $localizedTimeUnit";
  }

  String getShortValue(BuildContext context) {
    final l = context.read<LocaleProvider>();
    final String localizedTimeUnit =
        l.translate(timeUnit.getShortTranslationKey());

    return "$_fullPeriodicity$localizedTimeUnit";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChartInterval &&
          runtimeType == other.runtimeType &&
          period == other.period &&
          interval == other.interval &&
          timeUnit == other.timeUnit;

  @override
  int get hashCode => period.hashCode ^ interval.hashCode ^ timeUnit.hashCode;
}
