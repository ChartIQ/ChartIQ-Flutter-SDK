/// A series is a set of data, for example a line graph or one set of columns. All data plotted on a chart comes from the series object.
///
/// The parameters are:
/// - [symbolName]: A string that contains series's symbol
/// - [color]: A string with a hex color of the symbol to be displayed
class Series {
  /// A string that contains series's symbol
  final String symbolName;

  /// A string with a hex color of the symbol to be displayed
  final String color;

  Series({
    required this.symbolName,
    required this.color,
  });

  Map<String, dynamic> toJson() => {
        'symbolName': symbolName,
        'color': color,
      };

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      symbolName: json['symbolName'],
      color: json['color'],
    );
  }

  @override
  int get hashCode => symbolName.hashCode ^ color.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Series &&
          runtimeType == other.runtimeType &&
          symbolName == other.symbolName &&
          color == other.color;
}
