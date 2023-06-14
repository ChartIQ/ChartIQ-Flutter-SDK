import 'package:intl/intl.dart' as intl;

import 'app_localizations.gen.dart';

/// The translations for Spanish Castilian (`es`).
class LEs extends L {
  LEs([String locale = 'es']) : super(locale);

  @override
  String get settings => 'Settings';

  @override
  String get cancel => 'Cancel';

  @override
  String get chartPreferences => 'Chart Preferences';

  @override
  String get languagePreferences => 'Language Preferences';

  @override
  String settingsOptions(String option) {
    String _temp0 = intl.Intl.selectLogic(
      option,
      {
        'logScale': 'Log Scale',
        'invertYAxis': 'Invert Y-Axis',
        'extendHours': 'Extend Hours',
        'other': '-',
      },
    );
    return '$_temp0';
  }

  @override
  String get language => 'Language';

  @override
  String get intervals => 'Intervals';

  @override
  String pageSettingsInputLanguage(String locale) {
    String _temp0 = intl.Intl.selectLogic(
      locale,
      {
        'en': 'English',
        'de': 'German',
        'fr': 'French',
        'ru': 'Russian',
        'it': 'Italian',
        'es': 'Spanish',
        'pt': 'Portuguese',
        'hu': 'Hungarian',
        'zh': 'Chinese',
        'ja': 'Japanese',
        'ar': 'Arabic',
        'other': '-',
      },
    );
    return '$_temp0';
  }

  @override
  String get search => 'Search';

  @override
  String get typeToStartSearching => 'Type to start searching';

  @override
  String get symbolsNotFound => 'Symbols not found';

  @override
  String get tryAnotherSymbolOrApplyCurrent => 'Try another symbol to type in or apply current request';

  @override
  String get apply => 'Apply';

  @override
  String symbolFilter(String filter) {
    String _temp0 = intl.Intl.selectLogic(
      filter,
      {
        'all': 'All',
        'stocks': 'Stocks',
        'forex': 'Forex',
        'indexes': 'Indexes',
        'funds': 'Funds',
        'futures': 'Futures',
        'other': '-',
      },
    );
    return '$_temp0';
  }

  @override
  String timeUnits(String time) {
    String _temp0 = intl.Intl.selectLogic(
      time,
      {
        'day': 'day',
        'minute': 'minute',
        'month': 'month',
        'week': 'week',
        'second': 'second',
        'hour': 'hour',
        'other': '-',
      },
    );
    return '$_temp0';
  }

  @override
  String timeUnitsShort(String time) {
    String _temp0 = intl.Intl.selectLogic(
      time,
      {
        'day': 'D',
        'minute': 'm',
        'month': 'M',
        'week': 'W',
        'second': 's',
        'hour': 'H',
        'other': '-',
      },
    );
    return '$_temp0';
  }

  @override
  String get compareSymbols => 'Compare Symbols';

  @override
  String get noSymbolsToCompare => 'No Symbols to compare yet';

  @override
  String get addSymbol => 'Add Symbol';

  @override
  String get add => 'Add';

  @override
  String get remove => 'Remove';

  @override
  String get selectColor => 'Select Color';

  @override
  String get delete => 'Delete';

  @override
  String get clone => 'Clone';

  @override
  String get chartStyle => 'Chart Style';

  @override
  String drawingToolCategoryTitle(String category) {
    String _temp0 = intl.Intl.selectLogic(
      category,
      {
        'all': 'All',
        'favorites': 'Favourites',
        'text': 'Text',
        'statistics': 'Statistics',
        'technicals': 'Technicals',
        'fibonacci': 'Fibonacci',
        'markings': 'Markings',
        'lines': 'Lines',
        'other': '-',
      },
    );
    return '$_temp0';
  }

  @override
  String drawingToolSectionTitle(String category) {
    String _temp0 = intl.Intl.selectLogic(
      category,
      {
        'main': 'Main tools',
        'other': 'Other tools',
      },
    );
    return '$_temp0';
  }

  @override
  String get selectLineType => 'Select Line Type';

  @override
  String get save => 'Save';
}
