# ChartIQ-Flutter-SDK

Flutter SDK for the [ChartIQ JavaScript library](https://documentation.chartiq.com).

The ChartIQ Flutter SDK supports a basic charting application. The SDK can be extended to support more elaborate implementations by adding code to invoke ChartIQ library functions directly or by creating a bridge file similar to *nativeSdkBridge.js* (in the *mobile/js* folder of your ChartIQ library).

Contact us at <support@chartiq.com> to request sample code and guidance on how to extend the SDK.

## Requirements

- A copy of the ChartIQ JavaScript library (works best with version 9.5.0).
  - If you do not have a copy of the library or need a different version, please contact your account manager or visit our <a href="https://pages.marketintelligence.spglobal.com/ChartIQ-Follow-up-Request.html" target="_blank">Request Follow-Up Site</a>.

- Flutter 3.10.6 or later
- Dart 3.0.6 or later
- Android 8.1 Oreo (API level 27) or later
- iOS 10.3 or later

## App

The [example](https://github.com/ChartIQ/ChartIQ-Flutter-SDK/tree/main/example) folder of this repository contains both Android and iOS app that was built using the SDK. Customize the apps to quickly create your own Flutter charting application.

**App screen shots**

<table>
  <tr>
    <td><img src="https://github.com/ChartIQ/ChartIQ-Android-SDK/blob/main/screenshots/Candle_Chart.png?raw=true" alt="Candle chart" width="200" height="440"/></td>
    <td><img src="https://github.com/ChartIQ/ChartIQ-Android-SDK/blob/main/screenshots/Chart_with_Studies.png?raw=true" alt="Chart with studies" width="200" height="440"/></td>
    <td><img src="https://github.com/ChartIQ/ChartIQ-Android-SDK/blob/main/screenshots/Chart_Styles_and_Types.png?raw=true" alt="Chart styles and types" width="200" height="440"/></td>
  </tr>
</table>

## Getting started

With Flutter:

```bash
$ flutter pub add chart_iq
```

This will add a line to your package's pubspec.yaml (and run an implicit flutter pub get).

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

Now in your Dart code, you can use:

```dart
import 'package:chart_iq/chart_iq.dart';

ChartIQView(
  chartIQUrl: _chartIQUrl, // url to ChartIQ library
  onPullInitialData: (dataCallback) {
    // Provide initial data for chart
  },
  onPullUpdateData: (dataCallback) {
    // Provide update data for chart
  },
  onPullPaginationData: (dataCallback) {
    // Provide pagination data for chart
  },
  onChartIQViewCreated: (controller) {
    // ChartIQView created and ready to use
  },
)
```

## IOS installation additional step

Go to the example/ios folder and run pod install

```sh
cd example/ios
pod install
```

## API documentation

The Flutter sdk utilizes the existing mobile sdk that we have to offer.

- [Flutter SDK](https://pub.dev/documentation/chart_iq/latest/)

- [Android SDK](https://documentation.chartiq.com/android-sdk/)

- [iOS SDK](https://documentation.chartiq.com/ios-sdk/)

- [ChartIQ JavaScript library](https://documentation.chartiq.com)

## Questions and support

Contact our development support team at <support@chartiq.com>.

## Contributing

See the [contributing guide](https://github.com/ChartIQ/ChartIQ-Flutter-SDK/tree/main/CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

Apache2