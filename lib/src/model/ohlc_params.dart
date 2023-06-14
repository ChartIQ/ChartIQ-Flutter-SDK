/// Class of OHLC parameters
///
/// The parameters are:
/// - [date]: A date string, representing the start time of the bar or tick, in case a DT compatible value is not available.
/// - [open]: Opening price for the bar. Required for candle charts only.
/// - [high]: High price for the bar. Required for candle charts only.
/// - [low]: Low price for the bar. Required for candle charts only.
/// - [close]: Closing price for the bar. Excluding or setting this field to null will cause the chart to display a gap for this bar.
/// - [volume]: Trading volume for the bar in whole numbers.
/// - [adjClose]: Closing price adjusted price after splits or dividends. This is only necessary if you wish to give users the ability to display both adjusted and unadjusted values.
class OHLCParams {
  /// A date string, representing the start time of the bar or tick, in case a DT compatible value is not available.
  final DateTime? date;

  /// Opening price for the bar. Required for candle charts only.
  final double? open;

  /// High price for the bar. Required for candle charts only.
  final double? high;

  /// Low price for the bar. Required for candle charts only.
  final double? low;

  /// Closing price for the bar. Excluding or setting this field to null will cause the chart to display a gap for this bar.
  final double? close;

  /// Trading volume for the bar in whole numbers.
  final double? volume;

  /// Closing price adjusted price after splits or dividends. This is only necessary if you wish to give users the ability to display both adjusted and unadjusted values.
  final double? adjClose;

  OHLCParams({
    this.date,
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
    this.adjClose,
  });

  /// Convert the OHLCParams to a json.
  Map<String, dynamic> toJson() {
    return {
      'DT': date?.toIso8601String(),
      'Open': open,
      'High': high,
      'Low': low,
      'Close': close,
      'Volume': volume,
      'AdjClose': adjClose,
    };
  }
}
