import Flutter
import UIKit

public class ChartiqFlutterSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "chartiq_flutter_sdk", binaryMessenger: registrar.messenger())
    let instance = ChartiqFlutterSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    let factory = FLNativeViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "plugins.com.chartiq.chart_flutter_sdk/chartiqwebview")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
