import 'package:chart_iq/chart_iq.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const symbol = 'AAPL',
      start = '2020-03-10T16:42:00.000Z',
      end = '2020-03-11T09:32:25.992Z',
      interval = 'minute';
  const period = 3;

  const Map<String, dynamic> quoteFeedParamsJson = {
    'symbol': symbol,
    'startDate': start,
    'endDate': end,
    'interval': interval,
    'period': period,
  };

  group('Quote feed params', () {
    test('Properly parsed from json and filling values', () {
      final quoteFeedParams = QuoteFeedParams.fromJson(quoteFeedParamsJson);

      expect(quoteFeedParams.symbol == symbol, isTrue);
      expect(quoteFeedParams.start == start, isTrue);
      expect(quoteFeedParams.end == end, isTrue);
      expect(quoteFeedParams.interval == interval, isTrue);
      expect(quoteFeedParams.period == period, isTrue);
    });
  });
}
