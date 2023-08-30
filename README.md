# ChartIQ-Flutter-SDK

Flutter SDK for the [ChartIQ JavaScript library](https://documentation.chartiq.com).

The ChartIQ Flutter SDK supports a basic charting application. The SDK can be extended to support more elaborate implementations by adding code to invoke ChartIQ library functions directly or by creating a bridge file similar to *nativeSdkBridge.js* (in the *mobile/js* folder of your ChartIQ library).

Contact us at <support@chartiq.com> to request sample code and guidance on how to extend the SDK.

## Requirements

- Version 8.8.0 or later of the ChartIQ library

  Go to our <a href="https://cosaic.io/chartiq-sdk-library-download/" target="_blank">download site</a> to obtain a free 30-day trial version of the library, or send us an email at <info@cosaic.io>, and we'll send you an evaluation version.

- Flutter 3.10.6 or later
- Dart 3.0.6 or later
- Android 8.1 Oreo (API level 27) or later
- iOS 10.3 or later

## App

The [demo](https://github.com/ChartIQ/ChartIQ-Flutter-SDK/tree/main/example) folder of this repository contains an app that was built using the SDK. Customize the app to quickly create your own Flutter charting application.

**App screen shots**

<table>
  <tr>
    <td><img src="https://github.com/ChartIQ/ChartIQ-Android-SDK/blob/main/screenshots/Candle_Chart.png?raw=true" alt="Candle chart" width="200" height="440"/></td>
    <td><img src="https://github.com/ChartIQ/ChartIQ-Android-SDK/blob/main/screenshots/Chart_with_Studies.png?raw=true" alt="Chart with studies" width="200" height="440"/></td>
    <td><img src="https://github.com/ChartIQ/ChartIQ-Android-SDK/blob/main/screenshots/Chart_Styles_and_Types.png?raw=true" alt="Chart styles and types" width="200" height="440"/></td>
  </tr>
</table>

## Getting started

Depend on it
Run this command:

With Flutter:

```bash
$ flutter pub add chart_iq
```

This will add a line to your package's pubspec.yaml (and run an implicit flutter pub get):

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

Import it
Now in your Dart code, you can use:

```dart
import 'package:chart_iq/chart_iq.dart';
```

See the [Getting Started on Mobile: Flutter](https://documentation.chartiq.com/tutorial-Starting%20on%20Flutter.html) tutorial for instructions on installing the app and using the SDK.

## API documentation

- [App/SDK](https://documentation.chartiq.com/flutter-sdk/chartiq/)

- [ChartIQ JavaScript library](https://documentation.chartiq.com)

## Questions and support

Contact our development support team at <support@chartiq.com>.

## Contributing to this project

Contribute to this project. Fork it and send us a pull request. We'd love to see what you can do with our charting tools on Flutter!