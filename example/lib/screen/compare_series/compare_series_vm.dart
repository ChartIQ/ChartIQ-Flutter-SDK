import 'package:chart_iq/chart_iq.dart';
import 'package:example/data/model/picker_color.dart';
import 'package:flutter/widgets.dart';

class CompareSeriesVM extends ChangeNotifier {
  CompareSeriesVM({
    required this.chartIQController,
  }) {
    _init();
  }

  void _init() async {
    await _getComparisonSeries();
    _setupColorIndex();
  }

  int currentColorIndex = 0;

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

  Future<void> updateCompareSeries(String name, String parameter, String value) async {
    await chartIQController.setSeriesParameter(name, parameter, value);
    _getComparisonSeries();
  }

  void _setupColorIndex() {
    final color = series?.last.color;
    final index = color != null ? _defaultSeriesColors.indexWhere((c) => c.hexValueWithHash == color) : null;
    if (index != null && index != -1) {
      currentColorIndex = index + 1;
    }
  }

  String nextColor() {
    if (currentColorIndex > _defaultSeriesColors.length - 1) {
      currentColorIndex = 0;
    }
    String nextColor = _defaultSeriesColors[currentColorIndex].hexValueWithHash;
    currentColorIndex++;
    return nextColor;
  }

  static const _defaultSeriesColors = [
    PickerColor("#8ec648"),
    PickerColor("#00afed"),
    PickerColor("#ee652e"),
    PickerColor("#912a8e"),
    PickerColor("#fff126"),
    PickerColor("#e9088c"),
    PickerColor("#ea1d2c"),
    PickerColor("#00a553"),
    PickerColor("#00a99c"),
    PickerColor("#0056a4"),
    PickerColor("#f4932f"),
    PickerColor("#0073ba"),
    PickerColor("#66308f"),
    PickerColor("#323390"),
  ];
}
