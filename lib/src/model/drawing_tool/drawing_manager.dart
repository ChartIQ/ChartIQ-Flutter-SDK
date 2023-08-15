import 'package:chart_iq/chartiq_flutter_sdk.dart';

abstract class DrawingManager {
  /// Checks if a drawing tool supports `fill color` setting.
  ///
  /// Returns `true` if the [drawingTool] supports the setting, `false` otherwise.
  Future<bool> isSupportingFillColor(DrawingTool drawingTool);

  /// Checks if a drawing tool supports `line color` setting.
  ///
  /// Returns `true` if the [drawingTool] supports the setting, `false` otherwise.
  Future<bool> isSupportingLineColor(DrawingTool drawingTool);

  /// Checks if a drawing tool supports `line type` setting.
  ///
  /// Returns `true` if the [drawingTool] supports the setting, `false` otherwise.
  Future<bool> isSupportingLineType(DrawingTool drawingTool);

  /// Checks if a drawing tool supports `settings` setting.
  ///
  /// Returns `true` if the [drawingTool] supports the setting, `false` otherwise.
  Future<bool> isSupportingSettings(DrawingTool drawingTool);

  /// Checks if a drawing tool supports `font` setting.
  ///
  /// Returns `true` if the [drawingTool] supports the setting, `false` otherwise.
  Future<bool> isSupportingFont(DrawingTool drawingTool);

  /// Checks if a drawing tool supports `axis label` setting.
  ///
  /// Returns `true` if the [drawingTool] supports the setting, `false` otherwise.
  Future<bool> isSupportingAxisLabel(DrawingTool drawingTool);

  /// Checks if a drawing tool supports `deviations` parameters.
  ///
  /// Returns `true` if the [drawingTool] supports the setting, `false` otherwise.
  Future<bool> isSupportingDeviations(DrawingTool drawingTool);

  /// Checks if a drawing tool supports `Fibonacci` parameters.
  ///
  /// Returns `true` if the [drawingTool] supports the setting, `false` otherwise.
  Future<bool> isSupportingFibonacci(DrawingTool drawingTool);

  /// Checks if a drawing tool supports `VolumeProfile` settings.
  ///
  /// Returns `true` if the [drawingTool] supports the setting, `false` otherwise.
  Future<bool> isSupportingElliottWave(DrawingTool drawingTool);

  /// Checks if a drawing tool supports `Elliot wave` parameters.
  ///
  /// Returns `true` if the [drawingTool] supports the setting, `false` otherwise.
  Future<bool> isSupportingVolumeProfile(DrawingTool drawingTool);
}

