import '../chart_layer.dart';
import 'drawing_parameter_type.dart';
import 'drawing_tool.dart';

abstract class ChartIQDrawingTool {

  /// Clears all the drawings from the chart canvas
  Future<void> clearDrawing();

  /// Activates a selected drawing [DrawingTool]
  /// A [DrawingTool] to be selected
  Future<void> enableDrawing(DrawingTool tool);

  /// Deactivates drawing mode
  Future<void> disableDrawing();

  /// Sets a value for the drawing tool parameter
  /// [parameterName] A parameter to update the value of
  /// [value] A new value to be set to the parameter
  Future<void> setDrawingParameterByName(String parameterName, String value);

  /// Sets a value for the drawing tool parameter
  /// [parameter] A [DrawingParameterType] to update the value of
  /// [value] A new value to be set to the parameter
  Future<void> setDrawingParameter(DrawingParameterType parameter, String value);

  /// Get a map of current parameters and settings for the requested drawing tool [tool]
  /// [tool] A [DrawingTool] of parameters and settings to get
  Future<Map<String, dynamic>> getDrawingParameters(DrawingTool tool);

  /// Deletes the drawing that is selected on the chart
  Future<void> deleteDrawing();

  /// Clones the drawing that is selected on the chart
  Future<void> cloneDrawing();

  /// Changes the layer of the drawing that is selected on the chart
  /// [layer]  A [ChartLayer] to assign to the drawing
  Future<void> manageLayer(ChartLayer layer);

  /// Undoes the last drawing change
  Future<bool> undoDrawing();

  /// Redoes the last drawing change
  Future<bool> redoDrawing();

  /// Restores the drawing tool to its default settings
  /// [tool] A [DrawingTool] to restore the settings of
  /// [all] Set to true if you want to restore all drawings configs
  Future<void> restoreDefaultDrawingConfig(DrawingTool tool, bool all);
}