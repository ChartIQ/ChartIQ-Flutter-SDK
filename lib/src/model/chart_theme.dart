/// An enumeration of available chart themes
enum ChartTheme {
  /// A light theme
  day('day'),

  /// A dark theme
  night('night'),

  /// A none theme
  none('none');

  final String value;

  const ChartTheme(this.value);
}
