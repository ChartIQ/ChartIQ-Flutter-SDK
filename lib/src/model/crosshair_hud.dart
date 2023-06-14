/// A heads-up display (HUD) is a method of displaying detailed information for a specific bar on the chart itself.
///
/// The parameters are:
/// - [price]: Price for the bar.
/// - [volume]: Trading volume for the bar in whole numbers
/// - [open]: Opening price for the bar.
/// - [high]: High price for the bar.
/// - [close]: Closing price for the bar.
/// - [low]: Low price for the bar.
class CrosshairHUD {
  /// Price for the bar.
  final String price;

  /// Trading volume for the bar in whole numbers
  final String volume;

  /// Opening price for the bar.
  final String open;

  /// High price for the bar.
  final String high;

  /// Closing price for the bar.
  final String close;

  /// Low price for the bar.
  final String low;

  CrosshairHUD({
    required this.price,
    required this.volume,
    required this.open,
    required this.high,
    required this.close,
    required this.low,
  });

  factory CrosshairHUD.fromJson(Map<String, dynamic> json) {
    return CrosshairHUD(
      price: json['price'] ?? "",
      volume: json['volume'] ?? "",
      open: json['open'] ?? "",
      high: json['high'] ?? "",
      close: json['close'] ?? "",
      low: json['low'] ?? "",
    );
  }

// implement hashCode and == operator to allow for comparison of objects
  @override
  int get hashCode =>
      price.hashCode ^
      volume.hashCode ^
      open.hashCode ^
      high.hashCode ^
      close.hashCode ^
      low.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CrosshairHUD &&
          price == other.price &&
          volume == other.volume &&
          open == other.open &&
          high == other.high &&
          close == other.close &&
          low == other.low;
}
