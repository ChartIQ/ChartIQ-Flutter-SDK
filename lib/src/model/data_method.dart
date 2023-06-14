/// An enumeration of available data methods
enum DataMethod {
  /// A data method for a push
  push('PUSH'),

  /// A data method for a pull
  pull('PULL');

  final String value;

  const DataMethod(this.value);
}
