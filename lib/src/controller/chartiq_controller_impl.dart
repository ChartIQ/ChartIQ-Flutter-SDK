import 'dart:convert';

import 'package:chart_iq/src/model/chart_scale.dart';
import 'package:chart_iq/src/model/chart_theme.dart';
import 'package:chart_iq/src/model/chart_type/chart_aggregation_type.dart';
import 'package:chart_iq/src/model/chart_type/chart_type.dart';
import 'package:chart_iq/src/model/crosshair_hud.dart';
import 'package:chart_iq/src/model/data_method.dart';
import 'package:chart_iq/src/model/drawing_tool/chartiq_drawing_tool.dart';
import 'package:chart_iq/src/model/drawing_tool/chartiq_drawing_tool_impl.dart';
import 'package:chart_iq/src/model/drawing_tool/drawing_manager.dart';
import 'package:chart_iq/src/model/drawing_tool/drawing_manager_impl.dart';
import 'package:chart_iq/src/model/ohlc_params.dart';
import 'package:chart_iq/src/model/series.dart';
import 'package:chart_iq/src/model/signal/chart_iq_signal.dart';
import 'package:chart_iq/src/model/signal/chart_iq_signal_impl.dart';
import 'package:chart_iq/src/model/study/chart_iq_study.dart';
import 'package:chart_iq/src/model/study/chart_iq_study_impl.dart';
import 'package:chart_iq/src/model/time_unit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'chartiq_controller.dart';

/// This is the implementation of controller for the chart.
///
/// This class is used to control the chart.
class ChartIQControllerImpl implements ChartIQController {
  final MethodChannel _channel;
  final Stream<bool> _onChartAvailable;
  final Stream<String> _onMeasureListener;

  ChartIQStudy? _study;
  ChartIQSignal? _signal;
  DrawingManager? _drawingManager;
  ChartIQDrawingTool? _chartIQDrawingTool;

  ChartIQControllerImpl(
      this._channel, this._onChartAvailable, this._onMeasureListener);

  Future<dynamic> executeScript(String script) async {}

  @override
  pullInitialData(List<OHLCParams> params) async {
    await _channel.invokeMethod(
        'pullInitialData', jsonEncode(params.map((e) => e.toJson()).toList()));
  }

  @override
  pullPaginationData(List<OHLCParams> params) async {
    await _channel.invokeMethod('pullPaginationData',
        jsonEncode(params.map((e) => e.toJson()).toList()));
  }

  @override
  pullUpdateData(List<OHLCParams> params) async {
    await _channel.invokeMethod(
        'pullUpdateData', jsonEncode(params.map((e) => e.toJson()).toList()));
  }

  @override
  Future<void> start() {
    return _channel.invokeMethod('start');
  }

  @override
  Stream<bool> addChartAvailableListener() {
    return _onChartAvailable;
  }

  @override
  Stream<String> addMeasureListener() {
    return _onMeasureListener;
  }

  @override
  Future<void> addSeries(Series series, bool isComparison) {
    return _channel
        .invokeMethod('addSeries', [jsonEncode(series.toJson()), isComparison]);
  }

  @override
  Future<void> disableCrosshairs() {
    return _channel.invokeMethod('disableCrosshairs');
  }

  @override
  Future<void> enableCrosshairs() {
    return _channel.invokeMethod('enableCrosshairs');
  }

  @override
  Future<List<Series>> getActiveSeries() async {
    final res = await _channel.invokeMethod('getActiveSeries');
    final List<dynamic> json = jsonDecode(res);
    return json.map((e) => Series.fromJson(e)).toList();
  }

  @override
  Future<ChartAggregationType?> getChartAggregationType() async {
    final String? res = await _channel.invokeMethod('getChartAggregationType');
    return res == null
        ? null
        : ChartAggregationType.values.firstWhere((e) => e.value == res);
  }

  @override
  Future<String> getChartProperty(String property) async {
    final res = await _channel.invokeMethod('getChartProperty', property);
    return res;
  }

  @override
  Future<ChartScale> getChartScale() async {
    final String res = await _channel.invokeMethod('getChartScale');
    return ChartScale.values.firstWhere((e) => e.value == res);
  }

  @override
  Future<ChartType?> getChartType() async {
    final String? res = await _channel.invokeMethod('getChartType');
    return res == null
        ? null
        : ChartType.values.firstWhere((e) => e.value == res);
  }

  @override
  Future<String> getEngineProperty(String property) async {
    final res = await _channel.invokeMethod('getEngineProperty', property);
    return res;
  }

  @override
  Future<bool> getIsExtendedHours() async {
    final bool res = await _channel.invokeMethod('getIsExtendedHours');
    return res;
  }

  @override
  Future<CrosshairHUD> getHUDDetails() async {
    final String res = await _channel.invokeMethod('getHUDDetails');
    return CrosshairHUD.fromJson(jsonDecode(res));
  }

  @override
  Future<String> getInterval() async {
    final String res = await _channel.invokeMethod('getInterval');
    return res;
  }

  @override
  Future<bool> getIsInvertYAxis() async {
    final bool res = await _channel.invokeMethod('getIsInvertYAxis');
    return res;
  }

  @override
  Future<Map<String, String>> getTranslations(String languageCode) async {
    final res = await _channel.invokeMethod('getTranslations', languageCode);
    final Map<String, dynamic> json = jsonDecode(res);
    return json.map((key, value) => MapEntry(key, value.toString()));
  }

  @override
  Future<int> getPeriodicity() async {
    return await _channel.invokeMethod('getPeriodicity');
  }

  @override
  Future<String> getSymbol() async {
    return await _channel.invokeMethod('getSymbol');
  }

  @override
  Future<String> getTimeUnit() async {
    return await _channel.invokeMethod('getTimeUnit');
  }

  @override
  Future<bool> isCrosshairsEnabled() async {
    return await _channel.invokeMethod('isCrosshairsEnabled');
  }

  @override
  Future<void> push(String symbol, List<OHLCParams> data) {
    return _channel.invokeMethod(
        'push', [symbol, jsonEncode(data.map((e) => e.toJson()).toList())]);
  }

  @override
  Future<void> pushUpdate(List<OHLCParams> data, bool useAsLastSale) {
    return _channel.invokeMethod('pushUpdate',
        [jsonEncode(data.map((e) => e.toJson()).toList()), useAsLastSale]);
  }

  @override
  Future<void> removeSeries(String symbolName) {
    return _channel.invokeMethod('removeSeries', symbolName);
  }

  @override
  Future<void> setAggregationType(ChartAggregationType aggregationType) {
    return _channel.invokeMethod(
        'setAggregationType',
        defaultTargetPlatform == TargetPlatform.iOS
            ? aggregationType.iosValue
            : aggregationType.value);
  }

  @override
  Future<void> setChartProperty(String property, dynamic value) {
    return _channel
        .invokeMethod('setChartProperty', [property, jsonEncode(value)]);
  }

  @override
  Future<void> setChartScale(ChartScale scale) {
    return _channel.invokeMethod('setChartScale', scale.value);
  }

  @override
  Future<void> setChartStyle(String obj, String attribute, String value) {
    return _channel.invokeMethod('setChartStyle', [obj, attribute, value]);
  }

  @override
  Future<void> setChartType(ChartType chartType) {
    return _channel.invokeMethod(
      'setChartType',
      defaultTargetPlatform == TargetPlatform.iOS
          ? chartType.iosValue
          : chartType.value,
    );
  }

  @override
  Future<void> setDataMethod(DataMethod dataMethod, String symbol) {
    return _channel.invokeMethod('setDataMethod', [dataMethod.value, symbol]);
  }

  @override
  Future<void> setEngineProperty(String property, dynamic value) {
    return _channel
        .invokeMethod('setEngineProperty', [property, jsonEncode(value)]);
  }

  @override
  Future<void> setExtendedHours(bool extended) {
    return _channel.invokeMethod('setExtendedHours', extended);
  }

  @override
  Future<void> setIsInvertYAxis(bool inverted) {
    return _channel.invokeMethod('setIsInvertYAxis', inverted);
  }

  @override
  Future<void> setLanguage(String languageCode) {
    return _channel.invokeMethod('setLanguage', languageCode);
  }

  @override
  Future<void> setPeriodicity(int period, String interval, TimeUnit timeUnit) {
    return _channel
        .invokeMethod('setPeriodicity', [period, interval, timeUnit.value]);
  }

  @override
  Future<void> setRefreshInterval(int refreshInterval) {
    return _channel.invokeMethod('setRefreshInterval', refreshInterval);
  }

  @override
  Future<void> setSeriesParameter(
      String symbolName, String parameterName, String value) {
    return _channel
        .invokeMethod('setSeriesParameter', [symbolName, parameterName, value]);
  }

  @override
  Future<void> setSymbol(String symbol) {
    return _channel.invokeMethod('setSymbol', symbol);
  }

  @override
  Future<void> setTheme(ChartTheme theme) {
    return _channel.invokeMethod('setTheme', theme.value);
  }

  @override
  ChartIQStudy get study => _study ??= ChartIQStudyImpl(channel: _channel);

  @override
  ChartIQSignal get signal => _signal ??= ChartIQSignalImpl(channel: _channel);

  @override
  DrawingManager get drawingManager =>
      _drawingManager ??= DrawingManagerImpl(channel: _channel);

  @override
  ChartIQDrawingTool get chartIQDrawingTool =>
      _chartIQDrawingTool ??= ChartIQDrawingToolImpl(channel: _channel);
}
