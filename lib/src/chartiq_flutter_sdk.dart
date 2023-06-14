
import 'chartiq_flutter_sdk_platform_interface.dart';

class ChartiqFlutterSdk {
  Future<String?> getPlatformVersion() {
    return ChartiqFlutterSdkPlatform.instance.getPlatformVersion();
  }
}
