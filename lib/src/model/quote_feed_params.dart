/// QuoteFeedParams is a class that contains the parameters for the quote feed.
///
/// The parameters are:
/// - [symbol]: symbol of the quote.
/// - [period]: period of the quote.
/// - [interval]: interval of the quote.
/// - [start]: start date of the quote.
/// - [end]: end date of the quote.
/// - [meta]: meta data of the quote.
/// - [callbackId]: callback id of the quote.
class QuoteFeedParams {
  /// Symbol of the quote.
  final String? symbol;

  /// Period of the quote.
  final int? period;

  /// Interval of the quote.
  final String? interval;

  /// Start date of the quote.
  final String? start;

  /// End date of the quote.
  final String? end;

  /// Meta data of the quote.
  final dynamic meta;

  /// Callback id of the quote.
  final String? callbackId;

  QuoteFeedParams({
    this.symbol,
    this.period,
    this.interval,
    this.start,
    this.end,
    this.meta,
    this.callbackId,
  });

  QuoteFeedParams.fromJson(Map<String, dynamic> json) :
    symbol = json['symbol'],
    period = json['period'],
    interval = json['interval'],
    start = json['start'] ?? json['startDate'],
    end = json['end'] ?? json['endDate'],
    meta = json['meta'],
    callbackId = json['callbackId'];
}
