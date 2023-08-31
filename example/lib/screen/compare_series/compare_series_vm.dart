import 'package:chart_iq/chart_iq.dart';
import 'package:flutter/widgets.dart';

class CompareSeriesVM extends ChangeNotifier {
  CompareSeriesVM({
    required this.chartIQController,
  }) {
    _getComparisonSeries();
  }

  final ChartIQController chartIQController;

  List<Series>? series = [];

  Future<void> _getComparisonSeries() async {
    series = await chartIQController.getActiveSeries();
    notifyListeners();
  }

  Future<void> addCompareSeries(Series series) async {
    await chartIQController.addSeries(series, true);
    _getComparisonSeries();
  }

  Future<void> removeCompareSeries(Series series) async {
    await chartIQController.removeSeries(series.symbolName);
    _getComparisonSeries();
  }

  Future<void> updateCompareSeries(
      String name, String parameter, String value) async {
    await chartIQController.setSeriesParameter(name, parameter, value);
    _getComparisonSeries();
  }
}
