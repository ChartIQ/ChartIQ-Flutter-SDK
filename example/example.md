# ChartIQ-Flutter-SDK

```dart
import 'package:chart_iq/chart_iq.dart';
```
...
```dart
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

For more please check our [example app](https://github.com/ChartIQ/ChartIQ-Flutter-SDK/tree/main/example).