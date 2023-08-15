import 'package:chart_iq/chartiq_flutter_sdk.dart';
import 'package:example/common/const/locale_keys.dart';
import 'package:flutter/material.dart';

import 'settings_model.dart';

class SettingsVM extends ChangeNotifier {
  final ChartIQController? chartIQController;

  SettingsVM({
    required this.chartIQController,
  }) {
    _getSettings();
  }

  bool isLoading = true;

  final logScale = SettingsModel(
    RemoteLocaleKeys.logScale,
  );

  final invertYAxis = SettingsModel(
    RemoteLocaleKeys.invertYAxis,
  );

  final extendHours = SettingsModel(
    RemoteLocaleKeys.extendHours,
  );

  Future<void> _getSettings() async {
    await Future.wait([
      _getChartScale(),
      _getIsInvertYAxis(),
      _getExtendedHours(),
    ]);
    isLoading = false;
    notifyListeners();
  }

  Future<void> _getChartScale() async {
    final scale = await chartIQController?.getChartScale();
    logScale.switchSelected(value: scale == ChartScale.log);
  }

  Future<void> _getIsInvertYAxis() async {
    final isInverted = await chartIQController?.getIsInvertYAxis();

    invertYAxis.switchSelected(value: isInverted);
  }

  Future<void> _getExtendedHours() async {
    final isExtendedHours = await chartIQController?.getIsExtendedHours();
    extendHours.switchSelected(value: isExtendedHours);
  }

  Future<void> setChartScale() async {
    final scale = logScale.selected ? ChartScale.linear : ChartScale.log;
    await chartIQController?.setChartScale(scale);
    logScale.switchSelected();
    notifyListeners();
  }

  Future<void> setIsInvertYAxis() async {
    final isInverted = invertYAxis.selected;
    await chartIQController?.setIsInvertYAxis(!isInverted);
    invertYAxis.switchSelected();
    notifyListeners();
  }

  Future<void> setExtendHours() async {
    final isExtendedHours = extendHours.selected;
    await chartIQController?.setExtendedHours(!isExtendedHours);
    extendHours.switchSelected();
    notifyListeners();
  }
}
