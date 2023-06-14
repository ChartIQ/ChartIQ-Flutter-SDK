import 'package:chartiq_flutter_sdk/src/model/drawing_tool/drawing_manager.dart';
import 'package:chartiq_flutter_sdk/src/model/drawing_tool/drawing_tool.dart';
import 'package:flutter/services.dart';

class DrawingManagerImpl implements DrawingManager {
  final MethodChannel channel;

  DrawingManagerImpl({required this.channel});

  @override
  Future<bool> isSupportingAxisLabel(DrawingTool drawingTool) async {
    final res =
        await channel.invokeMethod('isSupportingAxisLabel', drawingTool.value);
    return res;
  }

  @override
  Future<bool> isSupportingDeviations(DrawingTool drawingTool) async {
    final res =
        await channel.invokeMethod('isSupportingDeviations', drawingTool.value);
    return res;
  }

  @override
  Future<bool> isSupportingElliottWave(DrawingTool drawingTool) async {
    final res = await channel.invokeMethod(
        'isSupportingElliottWave', drawingTool.value);
    return res;
  }

  @override
  Future<bool> isSupportingFibonacci(DrawingTool drawingTool) async {
    final res =
        await channel.invokeMethod('isSupportingFibonacci', drawingTool.value);
    return res;
  }

  @override
  Future<bool> isSupportingFillColor(DrawingTool drawingTool) async {
    final res =
        await channel.invokeMethod('isSupportingFillColor', drawingTool.value);
    return res;
  }

  @override
  Future<bool> isSupportingFont(DrawingTool drawingTool) async {
    final res =
        await channel.invokeMethod('isSupportingFont', drawingTool.value);
    return res;
  }

  @override
  Future<bool> isSupportingLineColor(DrawingTool drawingTool) async {
    final res =
        await channel.invokeMethod('isSupportingLineColor', drawingTool.value);
    return res;
  }

  @override
  Future<bool> isSupportingLineType(DrawingTool drawingTool) async {
    final res =
        await channel.invokeMethod('isSupportingLineType', drawingTool.value);
    return res;
  }

  @override
  Future<bool> isSupportingSettings(DrawingTool drawingTool) async {
    final res =
        await channel.invokeMethod('isSupportingSettings', drawingTool.value);
    return res;
  }

  @override
  Future<bool> isSupportingVolumeProfile(DrawingTool drawingTool) async {
    final res = await channel.invokeMethod(
        'isSupportingVolumeProfile', drawingTool.value);
    return res;
  }
}
