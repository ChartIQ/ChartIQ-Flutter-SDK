import 'dart:convert';
import 'package:chartiq_flutter_sdk/src/model/chart_layer.dart';
import 'package:chartiq_flutter_sdk/src/model/drawing_tool/drawing_parameter_type.dart';
import 'package:chartiq_flutter_sdk/src/model/drawing_tool/drawing_tool.dart';
import 'package:flutter/services.dart';
import 'chartiq_drawing_tool.dart';

class ChartIQDrawingToolImpl implements ChartIQDrawingTool {
  final MethodChannel channel;

  ChartIQDrawingToolImpl({required this.channel});

  @override
  Future<void> clearDrawing() {
    return channel.invokeMethod('clearDrawing');
  }

  @override
  Future<void> cloneDrawing() {
    return channel.invokeMethod('cloneDrawing');
  }

  @override
  Future<void> deleteDrawing() {
    return channel.invokeMethod('deleteDrawing');
  }

  @override
  Future<void> disableDrawing() {
    return channel.invokeMethod('disableDrawing');
  }

  @override
  Future<void> enableDrawing(DrawingTool tool) {
    return channel.invokeMethod('enableDrawing', tool.value);
  }

  @override
  Future<Map<String, dynamic>> getDrawingParameters(DrawingTool tool) async {
    final res = await channel.invokeMethod('getDrawingParameters', tool.value)
        as String;
    return jsonDecode(res);
  }

  @override
  Future<void> manageLayer(ChartLayer layer) {
    return channel.invokeMethod('manageLayer', layer.value);
  }

  @override
  Future<bool> redoDrawing() async {
    final res = await channel.invokeMethod('redoDrawing') as bool;
    return res;
  }

  @override
  Future<void> restoreDefaultDrawingConfig(DrawingTool tool, bool all) {
    return channel
        .invokeMethod('restoreDefaultDrawingConfig', [tool.value, all]);
  }

  @override
  Future<void> setDrawingParameter(
      DrawingParameterType parameter, String value) {
    return setDrawingParameterByName(parameter.value, value);
  }

  @override
  Future<void> setDrawingParameterByName(String parameterName, String value) {
    return channel.invokeMethod('setDrawingParameter', [parameterName, value]);
  }

  @override
  Future<bool> undoDrawing() async {
    final res = await channel.invokeMethod('undoDrawing') as bool;
    return res;
  }
}
