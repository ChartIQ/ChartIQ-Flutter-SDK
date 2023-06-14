/// An enumeration for available time units
enum TimeUnit {
  /// A time unit for a tick
  tick('TICK'),

  /// A time unit for a second
  second('SECOND'),

  /// A time unit for a minute
  minute('MINUTE'),

  /// A time unit for an hour
  hour('HOUR'),

  /// A time unit for a day
  day('DAY'),

  /// A time unit for a week
  week('WEEK'),

  /// A time unit for a month
  month('MONTH');

  final String value;

  const TimeUnit(this.value);
}
