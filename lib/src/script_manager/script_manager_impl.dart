import 'dart:convert';

import 'package:chartiq_flutter_sdk/src/model/chart_layer.dart';
import 'package:chartiq_flutter_sdk/src/model/chart_theme.dart';
import 'package:chartiq_flutter_sdk/src/model/drawing_tool/drawing_tool.dart';
import 'package:chartiq_flutter_sdk/src/model/ohlc_params.dart';
import 'package:chartiq_flutter_sdk/src/model/study/study_parameter_model.dart';
import 'script_manager.dart';

class ScriptManagerImpl implements ScriptManager {
  final String mobileBridgeNameSpace = 'CIQ.MobileBridge';
  final String chartIqJsObject = 'stxx';

  @override
  String getAddDrawingListenerScript() {
    return '$mobileBridgeNameSpace.addDrawingListener();';
  }

  @override
  String getAddLayoutListenerScript() {
    return '$mobileBridgeNameSpace.addLayoutListener()';
  }

  @override
  String getAddMeasureListener() {
    return '$mobileBridgeNameSpace.addMeasureListener();';
  }

  @override
  String getAddSeriesScript(String symbol, String color, bool isComparison) {
    return '$chartIqJsObject.addSeries("$symbol", {display:"$symbol", color: "$color", isComparison:"$isComparison"});';
  }

  @override
  String getAddStudyAsSignalScript(String signalName) {
    return '$mobileBridgeNameSpace.addStudyAsSignal("$signalName");';
  }

  @override
  String getAddStudyScript(
      String studyName, String inputs, String outputs, String parameters) {
    return '$mobileBridgeNameSpace.addStudy("$studyName", "$inputs", "$outputs", "$parameters");';
  }

  @override
  String getAggregationTypeScript() {
    return '$chartIqJsObject.layout.aggregationType';
  }

  @override
  String getChartScaleScript() {
    return '$chartIqJsObject.layout.chartScale';
  }

  @override
  String getChartTypeScript() {
    return '$chartIqJsObject.layout.chartType';
  }

  @override
  String getClearChartScript() {
    return '$chartIqJsObject.destroy();';
  }

  @override
  String getClearDrawingScript() {
    return '$chartIqJsObject.clearDrawings();';
  }

  @override
  String getCloneDrawingScript() {
    return '$mobileBridgeNameSpace.cloneDrawing();';
  }

  @override
  String getDateFromTickScript() {
    return '$mobileBridgeNameSpace.getDateFromTick()';
  }

  @override
  String getDeleteDrawingScript() {
    return '$mobileBridgeNameSpace.deleteDrawing();';
  }

  @override
  String getDetermineOSScript() {
    return '$mobileBridgeNameSpace.determineOs()';
  }

  @override
  String getDisableDrawingScript() {
    return getEnableDrawingScript(DrawingTool.none);
  }

  @override
  String getEnableCrosshairScript(bool value) {
    return '$mobileBridgeNameSpace.enableCrosshairs($value);';
  }

  @override
  String getEnableDrawingScript(DrawingTool type) {
    final String setVarScript = type.value != null
        ? 'currentDrawing = "${type.value}";'
        : 'currentDrawing = null;';
    return '$setVarScript$chartIqJsObject.changeVectorType(currentDrawing);';
  }

  @override
  String getGetActiveSeriesScript() {
    return '$mobileBridgeNameSpace.getAllSeries()';
  }

  @override
  String getGetActiveSignalsListScript() {
    return '$mobileBridgeNameSpace.getActiveSignals()';
  }

  @override
  String getGetActiveStudiesScript() {
    return '$mobileBridgeNameSpace.getActiveStudies();';
  }

  @override
  String getGetChartPropertyScript(String property) {
    return '$mobileBridgeNameSpace.getChartProperty("${property.asSafeScriptParameter}");';
  }

  @override
  String getGetCrosshairHUDDetailsScript() {
    return '$mobileBridgeNameSpace.getHudDetails();';
  }

  @override
  String getGetDrawingParametersScript(String? drawingName) {
    return '$mobileBridgeNameSpace.getDrawingParameters("$drawingName");';
  }

  @override
  String getGetEnginePropertyScript(String property) {
    return '$mobileBridgeNameSpace.getEngineProperty("${property.asSafeScriptParameter}");';
  }

  @override
  String getGetIntervalScript() {
    return '$chartIqJsObject.chart.interval';
  }

  @override
  String getGetPeriodicityScript() {
    return '$chartIqJsObject.chart.periodicity';
  }

  @override
  String getGetStudyListScript() {
    return '$mobileBridgeNameSpace.getStudyList();';
  }

  @override
  String getGetSymbolScript() {
    return '$chartIqJsObject.chart.symbol';
  }

  @override
  String getGetTimeUnitScript() {
    return '$chartIqJsObject.chart.timeUnit';
  }

  @override
  String getGetTranslationsScript(String languageCode) {
    return '$mobileBridgeNameSpace.getTranslations("${languageCode.asSafeScriptParameter}");';
  }

  @override
  String getInvertYAxisScript() {
    return '$mobileBridgeNameSpace.getLayoutProperty("flipped");';
  }

  @override
  String getIsChartAvailableScript() {
    return 'if ($mobileBridgeNameSpace.isChartAvailable() == true) { "true" } else { "false" }';
  }

  @override
  String getIsCrosshairsEnabledScript() {
    return 'if ($chartIqJsObject.layout.crosshair == true) { "true" } else { "false" }';
  }

  @override
  String getIsExtendedHoursScript() {
    return '$mobileBridgeNameSpace.getLayoutProperty("extended");';
  }

  @override
  String getLayerManagementScript(ChartLayer layer) {
    return '$mobileBridgeNameSpace.layerDrawing("${layer.value}");';
  }

  @override
  String getLoadChartScript() {
    return '$mobileBridgeNameSpace.loadChart();';
  }

  @override
  String getNativeQuoteFeedScript() {
    return '$mobileBridgeNameSpace.nativeQuoteFeed(parameters, cb)';
  }

  @override
  String getParseDataScript(List<OHLCParams> data, String callbackId,
      bool moreAvailable, bool upToDate) {
    return '$mobileBridgeNameSpace.parseData(\'${jsonEncode(data)}\', "$callbackId", $moreAvailable, $upToDate)';
  }

  @override
  String getPushDataScript(String symbol, List<OHLCParams> data) {
    return '$mobileBridgeNameSpace.loadChart("$symbol", \'${jsonEncode(data)}\');';
  }

  @override
  String getPushUpdateScript(List<OHLCParams> data, bool useAsLastSale) {
    return '$mobileBridgeNameSpace.parseData(\'${jsonEncode(data)}\', null, null, null, $useAsLastSale);';
  }

  @override
  String getRedoDrawingScript() {
    return '$mobileBridgeNameSpace.redo();';
  }

  @override
  String getRemoveAllStudiesScript() {
    return '$mobileBridgeNameSpace.removeAllStudies();';
  }

  @override
  String getRemoveSeriesScript(String symbol) {
    return '$mobileBridgeNameSpace.removeSeries("$symbol");';
  }

  @override
  String getRemoveSignalScript(String signalName) {
    return '$mobileBridgeNameSpace.removeSignal("$signalName");';
  }

  @override
  String getRemoveStudyScript(String studyName) {
    return '$mobileBridgeNameSpace.removeStudy("$studyName");';
  }

  @override
  String getResizeChartScript() {
    return '$chartIqJsObject.resizeChart();';
  }

  @override
  String getRestoreDefaultDrawingConfigScript(DrawingTool tool, bool all) {
    String toolName = '';
    if (!all) {
      toolName = tool.value ?? '';
    }
    return '$mobileBridgeNameSpace.restoreDefaultDrawingConfig("$toolName", $all);';
  }

  @override
  String getSaveSignalScript(
      String studyName, String signalParams, bool editMode) {
    return '$mobileBridgeNameSpace.saveSignal("$studyName", \'$signalParams\', "$editMode");';
  }

  @override
  String getSetAccessibilityModeScript() {
    return '$mobileBridgeNameSpace.accessibilityMode();';
  }

  @override
  String getSetAggregationTypeScript(String aggregationType) {
    return '$chartIqJsObject.setAggregationType("$aggregationType");';
  }

  @override
  String getSetChartPropertyScript(String property, value) {
    final safeProperty = property.asSafeScriptParameter;
    if (value is String) {
      return '$chartIqJsObject.chart.$safeProperty = "${value.asSafeScriptParameter}";';
    } else {
      return '$chartIqJsObject.chart.$safeProperty = $value;';
    }
  }

  @override
  String getSetChartScaleScript(String scale) {
    return '$chartIqJsObject.setChartScale("$scale");';
  }

  @override
  String getSetChartStyleScript(String obj, String attribute, String value) {
    return '$chartIqJsObject.setStyle("$obj", "$attribute", "$value");';
  }

  @override
  String getSetChartTypeScript(String chartType) {
    return '$mobileBridgeNameSpace.setChartType("$chartType");';
  }

  @override
  String getSetDrawingParameterScript(String parameter, String value) {
    return '$mobileBridgeNameSpace.setDrawingParameters("$parameter", "$value");';
  }

  @override
  String getSetEnginePropertyScript(String property, dynamic value) {
    final safeProperty = property.asSafeScriptParameter;
    if (value is String) {
      return '$chartIqJsObject.$safeProperty = "${value.asSafeScriptParameter}";';
    } else {
      return '$chartIqJsObject.$safeProperty = $value;';
    }
  }

  @override
  String getSetExtendedHoursScript(bool extended) {
    return '$chartIqJsObject.extendedHours.set($extended);';
  }

  @override
  String getSetInvertYAxisScript(bool inverted) {
    return '$chartIqJsObject.flipChart($inverted);';
  }

  @override
  String getSetLanguageScript(String languageCode) {
    return '$mobileBridgeNameSpace.setLanguage("${languageCode.asSafeScriptParameter}");';
  }

  @override
  String getSetPeriodicityScript(int period, String interval, String timeUnit) {
    return '$mobileBridgeNameSpace.setPeriodicity($period, $interval, "$timeUnit");';
  }

  @override
  String getSetRefreshIntervalScript(int refreshInterval) {
    return '$mobileBridgeNameSpace.setRefreshInterval($refreshInterval);';
  }

  @override
  String getSetSeriesParameterScript(
      String symbol, String field, String value) {
    return '$mobileBridgeNameSpace.modifySeries("$symbol", "$field", "$value");';
  }

  @override
  String getSetStudyParameterScript(
      String studyName, StudyParameterModel parameter) {
    return '$mobileBridgeNameSpace.setStudy("$studyName", "${parameter.fieldName.asSafeScriptParameter}", "${parameter.fieldSelectedValue.asSafeScriptParameter}");';
  }

  @override
  String getSetStudyParametersScript(
      String name, List<StudyParameterModel> parameters) {
    final scriptList = parameters
        .map((parameter) => getUpdateStudyParametersScript(
            parameter.fieldName, parameter.fieldSelectedValue))
        .toList();
    return "${getStudyDescriptorScript(name)}var helper = new CIQ.Studies.DialogHelper({\n\tsd: selectedSd,\n\tstx: $chartIqJsObject\n});\nvar isFound = false;\nvar newInputParameters = {};\nvar newOutputParameters = {};\nvar newParameters = {};${scriptList.join(' ')}helper.updateStudy({\n\tinputs: newInputParameters,\n\toutputs: newOutputParameters,\n\tparameters: newParameters\n});\nconsole.log(JSON.stringify(newInputParameters));\nconsole.log(JSON.stringify(newOutputParameters));\nconsole.log(JSON.stringify(newParameters));CIQ.MobileBridge.getSlimSd(helper.sd.name);";
  }

  String getStudyDescriptorScript(String name) {
    final safeStudyName = name.asSafeScriptParameter;
    return "var s = $chartIqJsObject.layout.studies;\nvar selectedSd = {};\nfor (var n in s) {\n\tvar sd = s[n];\n\tif (sd.name === \"$safeStudyName\") {\n\t\tselectedSd = sd;\n\t}\n}";
  }

  String getUpdateStudyParametersScript(String key, String value) {
    final safeStudyParameter = key.asSafeScriptParameter;
    final safeStudyValue = value.asSafeScriptParameter;
    final script =
        "for (x in helper.inputs) {   var input = helper.inputs[x];    if (input[\"name\"] === \"$safeStudyParameter\") {        isFound = true;        if (input[\"type\"] === \"text\" || input[\"type\"] === \"select\") {            newInputParameters[\"$safeStudyParameter\"] = \"$safeStudyValue\";        } else if (input[\"type\"] === \"number\") {            newInputParameters[\"$safeStudyParameter\"] = parseFloat(\"$safeStudyValue\");        } else if (input[\"type\"] === \"checkbox\") {            newInputParameters[\"$safeStudyParameter\"] = (\"$safeStudyValue\" == \"false\" || \"$safeStudyValue\" == \"0\" ? false : true);        }    } } if (isFound == false) {    for (x in helper.outputs) {        var output = helper.outputs[x];        if (output[\"name\"] === \"$safeStudyParameter\") {            newOutputParameters[\"$safeStudyParameter\"] = \"$safeStudyValue\";        }    } } if (isFound == false) {    if(\"$safeStudyParameter\".includes(\"Color\")) {        newParameters[\"$safeStudyParameter\"] = \"$safeStudyValue\";    } else if(\"$safeStudyParameter\".includes(\"Enabled\")) {        newParameters[\"$safeStudyParameter\"] = (\"$safeStudyValue\" == \"false\" || \"$safeStudyValue\" == \"0\" ? false : true);    } else {        newParameters[\"$safeStudyParameter\"] = parseFloat(\"$safeStudyValue\");    } } isFound = false; ";
    return script;
  }

  @override
  String getSetStyleScript(String obj, String parameter, String value) {
    return '$mobileBridgeNameSpace.setStyle("$obj", "$parameter", "$value");';
  }

  @override
  String getSetSymbolScript(String symbol) {
    return '$mobileBridgeNameSpace.setSymbol("$symbol")';
  }

  @override
  String getSetThemeScript(ChartTheme theme) {
    return '$mobileBridgeNameSpace.setTheme("${theme.value}");';
  }

  @override
  String getStudyInputParametersScript(String studyName) {
    return '$mobileBridgeNameSpace.getStudyParameters("$studyName", "inputs");';
  }

  @override
  String getStudyOutputParametersScript(String studyName) {
    return '$mobileBridgeNameSpace.getStudyParameters("$studyName", "outputs");';
  }

  @override
  String getStudyParametersScript(String studyName) {
    return '$mobileBridgeNameSpace.getStudyParameters("$studyName", "parameters");';
  }

  @override
  String getToggleSignalScript(String signalName) {
    return '$mobileBridgeNameSpace.toggleSignalStudy("$signalName");';
  }

  @override
  String getUndoDrawingScript() {
    return '$mobileBridgeNameSpace.undo();';
  }
}

extension on String {
  String get asSafeScriptParameter {
    return replaceAll('(?i)(<.?s+)on.?(>.*?)', '\$1\$2');
  }
}
