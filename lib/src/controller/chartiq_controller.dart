import 'package:chart_iq/chart_iq.dart';
import 'package:chart_iq/src/model/data_method.dart';
import 'package:chart_iq/src/model/drawing_tool/chartiq_drawing_tool.dart';
import 'package:chart_iq/src/model/drawing_tool/drawing_manager.dart';
import 'package:chart_iq/src/model/study/chart_iq_study.dart';

/// This is the controller for the chart.
///
/// This class is used to control the chart.
abstract class ChartIQController {
  /// Starts a ChartIQ WebClient initialization.
  Future<void> start();

  /// This method is used for pulling initial chart data.
  pullInitialData(List<OHLCParams> params);

  /// This method is used for pulling update chart data.
  pullUpdateData(List<OHLCParams> params);

  /// This method is used for pulling pagination chart data.
  pullPaginationData(List<OHLCParams> params);

  /// Gets the chart's symbol
  Future<String> getSymbol();

  /// Gets the chart's interval
  Future<String> getInterval();

  /// Gets the chart's time unit
  Future<String> getTimeUnit();

  /// Gets the chart's periodicity
  Future<int> getPeriodicity();

  /// Sets a symbol to the chart
  Future<void> setSymbol(String symbol);

  /// Sets data method and symbol to the chart
  Future<void> setDataMethod(DataMethod dataMethod, String symbol);

  /// Enables crosshairs
  Future<void> enableCrosshairs();

  /// Disables crosshairs
  Future<void> disableCrosshairs();

  /// Checks if crosshair is enabled
  Future<bool> isCrosshairsEnabled();

  /// Sets periodicity to the chart
  /// [period] A number of elements from masterData to roll-up together into one data point on the chart.
  /// [interval] An interval is a numeric portion of the time unit.
  /// [timeUnit] A particular time interval that represents a time unit. If not set, will default to "minute". *`hour` is NOT a valid timeUnit. Use `timeUnit:"minute", interval:60` instead.
  Future<void> setPeriodicity(int period, String interval, TimeUnit timeUnit);

  /// Sets an Aggregation type for charts
  Future<void> setAggregationType(ChartAggregationType aggregationType);

  /// Sets an chart style for charts
  /// [obj] The object whose style you wish to change (stx_grid, stx_xaxis, etc).
  /// [attribute] The style name of the object you wish to change (color, border, etc).
  /// [value] The value to assign to the attribute.
  Future<void> setChartStyle(String obj, String attribute, String value);

  /// Sets an chart type for charts
  /// [chartType] A selected chart type
  Future<void> setChartType(ChartType chartType);

  /// Sets ChartIQ quotefeed refresh interval.
  /// [refreshInterval] The ChartIQ refresh Interval in seconds.
  Future<void> setRefreshInterval(int refreshInterval);

  /// Gets a selected chart type
  Future<ChartType?> getChartType();

  /// Gets a selected aggregation chart type
  Future<ChartAggregationType?> getChartAggregationType();

  /// Gets a selected chart scale
  Future<ChartScale> getChartScale();

  /// Sets an chart scale for charts
  /// [scale] A selected chart scale
  Future<void> setChartScale(ChartScale scale);

  /// Gets a property off the chart engine object
  /// [property] the property to look for on the chart engine object
  Future<String> getEngineProperty(String property);

  /// Sets a value on the selected chart engine property
  /// [property] the property to look for on the chart engine object
  /// [value] the value to change on the chart engine property
  Future<void> setEngineProperty(String property, dynamic value);

  /// Gets a property off the chart object
  /// [property] the property to look for on the chart object
  Future<String> getChartProperty(String property);

  /// Sets a value on the selected chart property
  /// [property] the property to look for on the chart object
  /// [value] the value to change on the chart property
  Future<void> setChartProperty(String property, dynamic value);

  /// Gets a selected chart Y axis invertion
  Future<bool> getIsInvertYAxis();

  /// Setting to true causes the y-axis and all linked drawings, series and studies to display inverted (flipped) from its previous state
  /// [inverted]  A selected invertion value. if true, Y axis is inverted
  Future<void> setIsInvertYAxis(bool inverted);

  /// Gets a selected extended-hours visualization
  /// If true, a chart uses extended hours
  Future<bool> getIsExtendedHours();

  /// Sets to turn on/off the extended-hours visualization.
  /// [extended]  A selected boolean extended hours value. if true, extended hours are applied
  Future<void> setExtendedHours(bool extended);

  /// Get HUD details
  Future<CrosshairHUD> getHUDDetails();

  /// Returns a map of translations for a given language
  /// [languageCode] A selected language code in the  ISO 639-1 format
  Future<Map<String, String>> getTranslations(String languageCode);

  /// Sets a language that should be used within the app
  /// [languageCode] A selected language code in the  ISO 639-1 format
  Future<void> setLanguage(String languageCode);

  /// Adds a measure listener
  Stream<String> addMeasureListener();

  /// Adds chart available listener
  Stream<bool> addChartAvailableListener();

  /// Sets a theme to the chart
  /// [theme] A theme [ChartTheme] to be applied to the chart
  Future<void> setTheme(ChartTheme theme);

  /// Gets all active series on the chart.
  Future<List<Series>> getActiveSeries();

  /// Adds the symbol from the series to the chart with its color.
  /// [series] A series to add.
  /// [isComparison] A boolean telling the chart whether the symbol should be compared to the main symbol.
  Future<void> addSeries(Series series, bool isComparison);

  /// Removes a selected symbol from the chart's series.
  /// [symbolName] The symbol to remove OR the series object itself.
  Future<void> removeSeries(String symbolName);

  /// Modifies a property of an existing series.
  /// [symbolName] A symbol to set.
  /// [parameterName] The property you want to change.
  /// [value] The value to change to property to.
  Future<void> setSeriesParameter(
      String symbolName, String parameterName, String value);

  /// Modifies a property of an existing series.
  /// [symbol] The string symbol you want to display on the chart.
  /// [data] An array of properly formatted OHLC quote objects to load into the chart.
  Future<void> push(String symbol, List<OHLCParams> data);

  /// Modifies a property of an existing series.
  /// [data] An array of properly formatted OHLC quote objects to load into the chart.
  /// [useAsLastSale] A boolean value that forces the data sent to be used as the last sale price.
  Future<void> pushUpdate(List<OHLCParams> data, bool useAsLastSale);

  /// Get [ChartIQStudy] instance.
  ChartIQStudy get study;

  /// Get [DrawingManager] instance.
  DrawingManager get drawingManager;

  /// Get [ChartIQDrawingTool] instance.
  ChartIQDrawingTool get chartIQDrawingTool;

  /// Get [ChartIQSignal] instance.
  ChartIQSignal get signal;
}
