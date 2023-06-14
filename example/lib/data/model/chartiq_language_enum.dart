import 'dart:ui';

enum ChartIQLanguage {
  en("English", "en", "US"),
  de("German", "de", "DE"),
  fr("French", "fr", "FR"),
  ru("Russian", "ru", "RU"),
  it("Italian", "it", "IT"),
  es("Spanish", "es", "ES"),
  pt("Portuguese", "pt", "PT"),
  hu("Hungarian", "hu", "HU"),
  zh("Chinese", "zh", "CN"),
  ja("Japanese", "ja", "JP"),
  ar("Arabic", "ar", "EG");

  final String name, languageCode, countryCode;

  const ChartIQLanguage(this.name, this.languageCode, this.countryCode);

  Locale get locale => Locale(languageCode, countryCode);

  String get fullCode => '$languageCode-$countryCode';

  static ChartIQLanguage fromLanguageCode(String? languageCode) {
    return values.firstWhere(
      (e) => e.languageCode == languageCode,
      orElse: () => en,
    );
  }
}
