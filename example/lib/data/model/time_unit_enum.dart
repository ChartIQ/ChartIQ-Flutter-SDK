import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/extensions.dart';

enum ChartIQTimeUnit {
  tick,
  second,
  minute,
  hour,
  day,
  week,
  month;

  String getFullTranslationKey() {
    late String val;

    switch (this) {
      case ChartIQTimeUnit.tick:
        val = RemoteLocaleKeys.tick;
        break;
      case ChartIQTimeUnit.second:
        val = RemoteLocaleKeys.second;
        break;
      case ChartIQTimeUnit.minute:
        val = RemoteLocaleKeys.minute;
        break;
      case ChartIQTimeUnit.hour:
        val = RemoteLocaleKeys.hour;
        break;
      case ChartIQTimeUnit.day:
        val = RemoteLocaleKeys.day.capitalize();
        break;
      case ChartIQTimeUnit.week:
        val = RemoteLocaleKeys.week;
        break;
      case ChartIQTimeUnit.month:
        val = RemoteLocaleKeys.month;
        break;
    }

    return val.capitalize();
  }

  String getShortTranslationKey() {
    switch (this) {
      case ChartIQTimeUnit.tick:
        return RemoteLocaleKeys.tick;
      case ChartIQTimeUnit.second:
        return RemoteLocaleKeys.secondShort;
      case ChartIQTimeUnit.minute:
        return RemoteLocaleKeys.minuteShort;
      case ChartIQTimeUnit.hour:
        return RemoteLocaleKeys.hourShort.capitalize();
      case ChartIQTimeUnit.day:
        return RemoteLocaleKeys.dayShort.capitalize();
      case ChartIQTimeUnit.week:
        return RemoteLocaleKeys.weekShort.capitalize();
      case ChartIQTimeUnit.month:
        return RemoteLocaleKeys.monthShort.capitalize();
    }
  }
}
