import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:flutter/cupertino.dart';

enum DrawingToolCategory {
  all("all", RemoteLocaleKeys.all),
  favorites("favorites", RemoteLocaleKeys.favorites),
  text("text", RemoteLocaleKeys.text),
  statistics("statistics", RemoteLocaleKeys.statistics),
  technicals("technicals", RemoteLocaleKeys.technicals),
  fibonacci("fibonacci", RemoteLocaleKeys.fibonacci),
  markings("markings", RemoteLocaleKeys.markings),
  lines("lines", RemoteLocaleKeys.lines),
  none("none", RemoteLocaleKeys.none);

  final String value, _translationKey;

  const DrawingToolCategory(this.value, this._translationKey);

  String getTranslatedTitle(BuildContext context) =>
      context.translate(_translationKey);
}
