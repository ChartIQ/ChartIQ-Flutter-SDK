import 'package:example/data/model/chartiq_language_enum.dart';
import 'package:example/data/model/drawing_tool/drawing_tool_item_model.dart';
import 'package:example/screen/drawing_tools/default_drawing_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AppPreferences {
  AppPreferences._();

  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  static const _localeKey = 'locale';
  static const _drawingToolKey = 'drawing_tool';
  static const _favouriteDrawingToolsKey = 'favourite_drawing_tools';
  static const _applicationIdKey = 'application_id';

  static ChartIQLanguage getLanguage() {
    final code = _instance.getString(_localeKey);
    return ChartIQLanguage.fromLanguageCode(code);
  }

  static void setLanguage(ChartIQLanguage locale) {
    _instance.setString(_localeKey, locale.languageCode);
  }

  static DrawingToolItemModel? getDrawingTool() {
    final tool = _instance.getString(_drawingToolKey);
    if (tool == null) return null;
    return DefaultDrawingTools.fromToolName(tool);
  }

  static void setDrawingTool(DrawingToolItemModel? model) {
    if (model == null) {
      _instance.remove(_drawingToolKey);
      return;
    }
    _instance.setString(_drawingToolKey, model.tool.name);
  }

  static List<DrawingToolItemModel> getFavouriteDrawingTools() {
    final tools = _instance.getStringList(_favouriteDrawingToolsKey);
    if (tools == null) return [];
    return tools.map((e) => DefaultDrawingTools.fromToolName(e)).toList();
  }

  static void setFavouriteDrawingTools(List<DrawingToolItemModel> models) {
    final tools = models.map((e) => e.tool.name).toList();
    _instance.setStringList(_favouriteDrawingToolsKey, tools);
  }

  static String getApplicationId() {
    final storedId = _instance.getString(_applicationIdKey);
    if (storedId != null) return storedId;

    final newId = const Uuid().v4();
    _instance.setString(_applicationIdKey, newId);
    return newId;
  }
}
