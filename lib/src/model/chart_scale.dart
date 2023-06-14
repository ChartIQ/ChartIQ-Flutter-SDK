/// A set of possible chart scale for the chart.
enum ChartScale {
  /// A logarithmic scale.
  log('log'),

  /// A linear scale.
  linear('linear');

  final String value;

  const ChartScale(this.value);
}
