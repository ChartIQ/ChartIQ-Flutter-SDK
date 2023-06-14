import 'package:chartiq_flutter_sdk/src/model/chart_layer.dart';
import 'package:chartiq_flutter_sdk/src/model/chart_theme.dart';
import 'package:chartiq_flutter_sdk/src/model/drawing_tool/drawing_tool.dart';
import 'package:chartiq_flutter_sdk/src/model/ohlc_params.dart';
import 'package:chartiq_flutter_sdk/src/model/study/study_parameter_model.dart';

abstract class ScriptManager {
  String getDetermineOSScript();

  String getNativeQuoteFeedScript();

  String getAddDrawingListenerScript();

  String getAddLayoutListenerScript();

  String getAddMeasureListener();

  String getGetSymbolScript();

  String getGetIntervalScript();

  String getGetTimeUnitScript();

  String getGetPeriodicityScript();

  String getSetSymbolScript(String symbol);

  String getDateFromTickScript();

  String getLoadChartScript();

  String getSetAccessibilityModeScript();

  String getIsChartAvailableScript();

  String getSetPeriodicityScript(int period, String interval, String timeUnit);

  String getPushDataScript(String symbol, List<OHLCParams> data);

  String getPushUpdateScript(List<OHLCParams> data, bool useAsLastSale);

  String getSetChartTypeScript(String chartType);

  String getSetRefreshIntervalScript(int refreshInterval);

  String getChartTypeScript();

  String getAggregationTypeScript();

  String getResizeChartScript();

  String getClearChartScript();

  String getChartScaleScript();

  String getSetChartScaleScript(String scale);

  String getAddStudyScript(
      String studyName, String inputs, String outputs, String parameters);

  String getRemoveStudyScript(String studyName);

  String getRemoveAllStudiesScript();

  String getEnableCrosshairScript(bool value);

  String getIsCrosshairsEnabledScript();

  String getGetCrosshairHUDDetailsScript();

  String getEnableDrawingScript(DrawingTool type);

  String getDisableDrawingScript();

  String getClearDrawingScript();

  String getSetDrawingParameterScript(String parameter, String value);

  String getSetStyleScript(String obj, String parameter, String value);

  String getSetThemeScript(ChartTheme theme);

  String getGetStudyListScript();

  String getGetActiveStudiesScript();

  String getGetActiveSignalsListScript();

  String getAddStudyAsSignalScript(String signalName);

  String getRemoveSignalScript(String signalName);

  String getToggleSignalScript(String signalName);

  String getSaveSignalScript(
      String studyName, String signalParams, bool editMode);

  String getSetAggregationTypeScript(String aggregationType);

  String getStudyInputParametersScript(String studyName);

  String getStudyOutputParametersScript(String studyName);

  String getStudyParametersScript(String studyName);

  String getSetStudyParametersScript(
      String name, List<StudyParameterModel> parameters);

  String getSetStudyParameterScript(
      String studyName, StudyParameterModel parameter);

  String getGetDrawingParametersScript(String? drawingName);

  String getSetChartStyleScript(String obj, String attribute, String value);

  String getSetChartPropertyScript(String property, dynamic value);

  String getGetChartPropertyScript(String property);

  String getSetEnginePropertyScript(String property, dynamic value);

  String getGetEnginePropertyScript(String property);

  String getParseDataScript(List<OHLCParams> data, String callbackId,
      bool moreAvailable, bool upToDate);

  String getInvertYAxisScript();

  String getSetInvertYAxisScript(bool inverted);

  String getIsExtendedHoursScript();

  String getSetExtendedHoursScript(bool extended);

  String getUndoDrawingScript();

  String getRedoDrawingScript();

  String getDeleteDrawingScript();

  String getCloneDrawingScript();

  String getLayerManagementScript(ChartLayer layer);

  String getGetTranslationsScript(String languageCode);

  String getSetLanguageScript(String languageCode);

  String getRestoreDefaultDrawingConfigScript(DrawingTool tool, bool all);

  String getGetActiveSeriesScript();

  String getAddSeriesScript(String symbol, String color, bool isComparison);

  String getRemoveSeriesScript(String symbol);

  String getSetSeriesParameterScript(String symbol, String field, String value);
}
