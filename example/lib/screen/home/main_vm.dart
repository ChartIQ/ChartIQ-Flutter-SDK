import 'dart:async';
import 'dart:ui';

import 'package:chart_iq/chartiq_flutter_sdk.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:example/app_preferences.dart';
import 'package:example/data/api/chart/chart_api.dart';
import 'package:example/data/model/chart_style_item_type_model.dart';
import 'package:example/data/model/drawing_tool/drawing_tool_item_model.dart';
import 'package:example/data/model/interval.dart';
import 'package:example/data/model/symbol/symbol_model.dart';
import 'package:example/screen/chart_type/chart_type_extension.dart';
import 'package:example/screen/home/widgets/crosshairs/extensions/hud_extension.dart';
import 'package:flutter/material.dart';

class MainVM extends ChangeNotifier {
  final ChartApi _chartApi;
  List<Study> activeStudies = [];
  ChartIQController? _chartIQController;

  final StreamController<bool> isInternetAvailableStreamController =
      StreamController<bool>.broadcast();

  ChartIQController? get chartIQController => _chartIQController;

  bool isAppBarCollapsed = true;

  MainVM(this._chartApi);

  Future<void> init() async {
    onDrawingToolSelected(AppPreferences.getDrawingTool());

    onPlatformBrightnessChanged(PlatformDispatcher.instance.platformBrightness);

    await Future.wait([
      _getChartType(),
      _getSelectedSymbol(),
      _getSelectedInterval(),
      _checkCrosshairEnabled(),
    ]);

    notifyListeners();
  }

  SymbolModel? selectedSymbol;

  onSymbolSelected(SymbolModel? symbol) async {
    if (symbol == null) return;
    selectedSymbol = symbol;
    await chartIQController?.setSymbol(symbol.symbol);
    await Future.wait([_getSelectedSymbol(), _getSelectedInterval()]);
    notifyListeners();
  }

  ChartInterval? selectedInterval;

  onIntervalSelected(ChartInterval? interval) {
    if (interval == null) return;
    selectedInterval = interval;
    chartIQController?.setPeriodicity(
      interval.period,
      interval.interval.toString(),
      TimeUnit.values.firstWhere(
        (e) => e.name == interval.getSafeTimeUnit().name,
      ),
    );
    notifyListeners();
  }

  ChartTypeItemModel? selectedChartStyle;

  onChartStyleSelected(ChartTypeItemModel? chartType) {
    if (chartType == null) return;
    selectedChartStyle = chartType;
    if (ChartType.values.any((e) => e.value == chartType.name)) {
      _chartIQController?.setChartType(
          ChartType.values.firstWhere((e) => e.value == chartType.name));
    } else if (ChartAggregationType.values
        .any((e) => e.value == chartType.name)) {
      _chartIQController?.setAggregationType(ChartAggregationType.values
          .firstWhere((e) => e.value == chartType.name));
    }

    notifyListeners();
  }

  DrawingToolItemModel? selectedDrawingTool;
  bool isDrawingToolReset = false;

  onDrawingToolSelected(DrawingToolItemModel? drawingTool) async {
    AppPreferences.setDrawingTool(drawingTool);
    selectedDrawingTool = drawingTool;
    if (drawingTool != null && drawingTool.tool != DrawingTool.none) {
      _chartIQController?.chartIQDrawingTool.enableDrawing(drawingTool.tool);
      collapseAppBar(value: false);
    } else {
      _chartIQController?.chartIQDrawingTool.disableDrawing();
    }
    notifyListeners();
  }

  onRestoreDefaultDrawingParameters() {
    _chartIQController?.chartIQDrawingTool
        .restoreDefaultDrawingConfig(DrawingTool.line, true);
    isDrawingToolReset = !isDrawingToolReset;
    notifyListeners();
  }

  onClearExistingDrawings() {
    _chartIQController?.chartIQDrawingTool.clearDrawing();
    onDrawingToolSelected(null);
  }

  onUndoDrawing() {
    _chartIQController?.chartIQDrawingTool.undoDrawing();
  }

  onRedoDrawing() {
    _chartIQController?.chartIQDrawingTool.redoDrawing();
  }

  bool isCrosshairEnabled = false;
  CrosshairHUD? crosshairHUDData;

  Future<void> onCrossHairEnabledChanged(bool value) async {
    isCrosshairEnabled = value;

    if (value) {
      await chartIQController?.enableCrosshairs();
      Timer.periodic(
        const Duration(milliseconds: 300),
        _crosshairTimerAction,
      );
    } else {
      chartIQController?.disableCrosshairs();
      Future.delayed(const Duration(milliseconds: 300), () {
        crosshairHUDData = null;
      });
    }
    notifyListeners();
  }

  Future<void> _crosshairTimerAction(Timer timer) async {
    if (isCrosshairEnabled) {
      final newData = await chartIQController?.getHUDDetails();
      if (!(crosshairHUDData?.isEqual(newData) ?? false)) {
        crosshairHUDData = newData;
        notifyListeners();
      }
    } else {
      timer.cancel();
    }
  }

  Future<void> onChartIQViewCreated(ChartIQController chartIQController) async {
    _chartIQController = chartIQController;
    await _chartIQController?.start();
    await init();
    notifyListeners();
  }

  collapseAppBar({bool? value, bool? disableDrawingTool}) async {
    isAppBarCollapsed = value ?? !isAppBarCollapsed;
    isCrosshairEnabled = false;
    await chartIQController?.disableCrosshairs();
    if(disableDrawingTool ?? false) {
      onDrawingToolSelected(null);
    }
    notifyListeners();
  }

  onPlatformBrightnessChanged(Brightness brightness) {
    _chartIQController?.setTheme(
        brightness == Brightness.light ? ChartTheme.day : ChartTheme.night);
  }

  onPullInitialData(QuoteFeedParams params) async {
    try {
      final result = await _chartApi.fetchDataFeed(
        identifier: params.symbol,
        startDate: params.start,
        endDate: params.end,
        interval: params.interval,
        period: params.period?.toString(),
        session: AppPreferences.getApplicationId(),
      );
      _chartIQController
          ?.pullInitialData(result.map((e) => e.toOHLCParams()).toList());
    } on DioError catch (_) {
      checkInternetAvailability();
    }
  }

  onPullUpdateData(QuoteFeedParams params) async {
    try {
      final result = await _chartApi.fetchDataFeed(
        identifier: params.symbol,
        startDate: params.start,
        endDate: params.end,
        interval: params.interval,
        period: params.period?.toString(),
        session: AppPreferences.getApplicationId(),
      );
      _chartIQController
          ?.pullUpdateData(result.map((e) => e.toOHLCParams()).toList());
    } on DioError catch (_) {
      checkInternetAvailability();
    }
  }

  onPullPaginationData(QuoteFeedParams params) async {
    try {
      final result = await _chartApi.fetchDataFeed(
        identifier: params.symbol,
        startDate: params.start,
        endDate: params.end,
        interval: params.interval,
        period: params.period?.toString(),
        session: AppPreferences.getApplicationId(),
      );
      _chartIQController
          ?.pullPaginationData(result.map((e) => e.toOHLCParams()).toList());
    } on DioError catch (_) {
      checkInternetAvailability();
    }
  }

  Future<void> _getChartType() async {
    return await _chartIQController!
        .getChartAggregationType()
        .then((value) async {
      if (value != null) {
        selectedChartStyle = value.toModel();
      } else {
        selectedChartStyle =
            (await _chartIQController!.getChartType())!.toModel();
      }
    });
  }

  Future<void> _getSelectedSymbol() async => selectedSymbol = SymbolModel(
        symbol: await _chartIQController!.getSymbol(),
      );

  Future<void> _getSelectedInterval() async {
    final futures = await Future.wait([
      _chartIQController!.getPeriodicity(),
      _chartIQController!.getInterval(),
      _chartIQController!.getTimeUnit(),
    ]);

    selectedInterval = ChartInterval.createInterval(
      futures[0] as int,
      futures[1] as String,
      futures[2].toString(),
    );
  }

  Future<void> _checkCrosshairEnabled() async => onCrossHairEnabledChanged(
        await _chartIQController!.isCrosshairsEnabled(),
      );

  Future<bool> checkInternetAvailability() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    switch (connectivityResult) {
      case ConnectivityResult.ethernet:
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        isInternetAvailableStreamController.add(true);
        return true;
      default:
        isInternetAvailableStreamController.add(false);
        return false;
    }
  }
}
