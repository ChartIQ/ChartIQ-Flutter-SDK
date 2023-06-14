import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String volume = '843k',
      high = '96.59',
      open = '95.66',
      close = '95.79',
      low = '95.49';

  const Map<String, dynamic> crosshairHudJson = {
    'volume': volume,
    'high': high,
    'open': open,
    'close': close,
    'low': low,
  };

  group('Crosshair HUD', () {
    test('==(equals) operator works properly', () {
      final crosshairHud1 = CrosshairHUD.fromJson(crosshairHudJson);
      final crosshairHud2 = CrosshairHUD.fromJson(crosshairHudJson);

      expect(crosshairHud1 == crosshairHud2, isTrue);
    });

    test('Properly parsed from json and filling values', () {
      final crosshairHud = CrosshairHUD.fromJson(crosshairHudJson);

      expect(crosshairHud.volume == volume, isTrue);
      expect(crosshairHud.high == high, isTrue);
      expect(crosshairHud.open == open, isTrue);
      expect(crosshairHud.close == close, isTrue);
      expect(crosshairHud.low == low, isTrue);
    });
  });
}
