import 'package:chart_iq/chart_iq.dart';
import 'package:example/app_preferences.dart';
import 'package:example/data/model/chartiq_language_enum.dart';
import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider(this._locale);
  ChartIQLanguage _locale;

  ChartIQLanguage get appLanguage => _locale;

  Map<String, String> _currentTranslations = {};
  set currentTranslations(Map<String, String> translations) {
    _currentTranslations = translations;
    notifyListeners();
  }

  String translate(String key) {
    return _currentTranslations[key] ?? key;
  }

  void set(ChartIQLanguage language, ChartIQController controller) async {
    AppPreferences.setLanguage(language);
    _locale = language;
    await controller.setLanguage(language.fullCode);
    currentTranslations = await controller.getTranslations(language.fullCode);
    notifyListeners();
  }
}
