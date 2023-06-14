import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'chartiq_flutter_sdk_method_channel.dart';

abstract class ChartiqFlutterSdkPlatform extends PlatformInterface {
  /// Constructs a ChartiqFlutterSdkPlatform.
  ChartiqFlutterSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static ChartiqFlutterSdkPlatform _instance = MethodChannelChartiqFlutterSdk();

  /// The default instance of [ChartiqFlutterSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelChartiqFlutterSdk].
  static ChartiqFlutterSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ChartiqFlutterSdkPlatform] when
  /// they register themselves.
  static set instance(ChartiqFlutterSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
