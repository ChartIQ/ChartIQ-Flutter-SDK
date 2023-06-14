import 'package:chartiq_flutter_sdk/chartiq_flutter_sdk.dart';

extension HUDExtension on CrosshairHUD {
  bool isEqual(CrosshairHUD? o) {
    if (o == null) return false;

    return price == o.price &&
        volume == o.volume &&
        open == o.open &&
        high == o.high &&
        close == o.close &&
        low == o.low;
  }
}
