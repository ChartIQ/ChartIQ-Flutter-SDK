import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const symbolName = "AAPL",
      color = "#00ff00";

  const Map<String, dynamic> seriesJson = {
    'symbolName': symbolName,
    'color': color,
  };

  group('Series', () {
    test('==(equals) operator works properly', () {
      final series1 = Series.fromJson(seriesJson);
      final series2 = Series.fromJson(seriesJson);

      expect(series1 == series2, isTrue);
    });

    test('Properly parsed from json and filling values', () {
      final series = Series.fromJson(seriesJson);

      expect(series.symbolName == symbolName, isTrue);
      expect(series.color == color, isTrue);
    });
  });
}