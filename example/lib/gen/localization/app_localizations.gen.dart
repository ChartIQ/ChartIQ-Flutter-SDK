import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.gen.dart';
import 'app_localizations_de.gen.dart';
import 'app_localizations_en.gen.dart';
import 'app_localizations_es.gen.dart';
import 'app_localizations_fr.gen.dart';
import 'app_localizations_hu.gen.dart';
import 'app_localizations_it.gen.dart';
import 'app_localizations_ja.gen.dart';
import 'app_localizations_pt.gen.dart';
import 'app_localizations_ru.gen.dart';
import 'app_localizations_zh.gen.dart';

/// Callers can lookup localized strings with an instance of L
/// returned by `L.of(context)`.
///
/// Applications need to include `L.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.gen.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L.localizationsDelegates,
///   supportedLocales: L.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L.supportedLocales
/// property.
abstract class L {
  L(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L of(BuildContext context) {
    return Localizations.of<L>(context, L)!;
  }

  static const LocalizationsDelegate<L> delegate = _LDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hu'),
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh')
  ];

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @chartPreferences.
  ///
  /// In en, this message translates to:
  /// **'Chart Preferences'**
  String get chartPreferences;

  /// No description provided for @languagePreferences.
  ///
  /// In en, this message translates to:
  /// **'Language Preferences'**
  String get languagePreferences;

  /// No description provided for @settingsOptions.
  ///
  /// In en, this message translates to:
  /// **'{option, select, logScale {Log Scale} invertYAxis {Invert Y-Axis} extendHours {Extend Hours} other {-}}'**
  String settingsOptions(String option);

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @intervals.
  ///
  /// In en, this message translates to:
  /// **'Intervals'**
  String get intervals;

  /// No description provided for @pageSettingsInputLanguage.
  ///
  /// In en, this message translates to:
  /// **'{locale, select, en {English} de {German} fr {French} ru {Russian} it {Italian} es {Spanish} pt {Portuguese} hu {Hungarian} zh {Chinese} ja {Japanese} ar {Arabic} other {-}}'**
  String pageSettingsInputLanguage(String locale);

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @typeToStartSearching.
  ///
  /// In en, this message translates to:
  /// **'Type to start searching'**
  String get typeToStartSearching;

  /// No description provided for @symbolsNotFound.
  ///
  /// In en, this message translates to:
  /// **'Symbols not found'**
  String get symbolsNotFound;

  /// No description provided for @tryAnotherSymbolOrApplyCurrent.
  ///
  /// In en, this message translates to:
  /// **'Try another symbol to type in or apply current request'**
  String get tryAnotherSymbolOrApplyCurrent;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @symbolFilter.
  ///
  /// In en, this message translates to:
  /// **'{filter, select, all {All} stocks {Stocks} forex {Forex} indexes {Indexes} funds {Funds} futures {Futures} other {-}}'**
  String symbolFilter(String filter);

  /// No description provided for @timeUnits.
  ///
  /// In en, this message translates to:
  /// **'{time, select, day {day} minute {minute} month {month} week {week} second {second} hour {hour} other {-}}'**
  String timeUnits(String time);

  /// No description provided for @timeUnitsShort.
  ///
  /// In en, this message translates to:
  /// **'{time, select, day {D} minute {m} month {M} week {W} second {s} hour {H} other {-}}'**
  String timeUnitsShort(String time);

  /// No description provided for @compareSymbols.
  ///
  /// In en, this message translates to:
  /// **'Compare Symbols'**
  String get compareSymbols;

  /// No description provided for @noSymbolsToCompare.
  ///
  /// In en, this message translates to:
  /// **'No Symbols to compare yet'**
  String get noSymbolsToCompare;

  /// No description provided for @addSymbol.
  ///
  /// In en, this message translates to:
  /// **'Add Symbol'**
  String get addSymbol;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @selectColor.
  ///
  /// In en, this message translates to:
  /// **'Select Color'**
  String get selectColor;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @clone.
  ///
  /// In en, this message translates to:
  /// **'Clone'**
  String get clone;

  /// No description provided for @chartStyle.
  ///
  /// In en, this message translates to:
  /// **'Chart Style'**
  String get chartStyle;

  /// No description provided for @drawingToolCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'{category, select, all {All} favorites {Favourites} text {Text} statistics {Statistics} technicals {Technicals} fibonacci {Fibonacci} markings {Markings} lines {Lines} other {-}}'**
  String drawingToolCategoryTitle(String category);

  /// No description provided for @drawingToolSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'{category, select, main {Main tools} other {Other tools}}'**
  String drawingToolSectionTitle(String category);

  /// No description provided for @selectLineType.
  ///
  /// In en, this message translates to:
  /// **'Select Line Type'**
  String get selectLineType;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;
}

class _LDelegate extends LocalizationsDelegate<L> {
  const _LDelegate();

  @override
  Future<L> load(Locale locale) {
    return SynchronousFuture<L>(lookupL(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'de', 'en', 'es', 'fr', 'hu', 'it', 'ja', 'pt', 'ru', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_LDelegate old) => false;
}

L lookupL(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return LAr();
    case 'de': return LDe();
    case 'en': return LEn();
    case 'es': return LEs();
    case 'fr': return LFr();
    case 'hu': return LHu();
    case 'it': return LIt();
    case 'ja': return LJa();
    case 'pt': return LPt();
    case 'ru': return LRu();
    case 'zh': return LZh();
  }

  throw FlutterError(
    'L.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
