import 'package:example/common/const/locale_keys.dart';
import 'package:example/common/utils/extensions.dart';
import 'package:flutter/material.dart';

enum SymbolFilter {
  all(value: null, title: RemoteLocaleKeys.allCaps),
  stocks(value: "STOCKS", title: RemoteLocaleKeys.stocks),
  fx(value: "FOREX", title: RemoteLocaleKeys.fx),
  indexes(value: "INDEXES", title: RemoteLocaleKeys.indexes),
  funds(value: "FUNDS", title: RemoteLocaleKeys.funds),
  futures(value: "FUTURES", title: RemoteLocaleKeys.futures);

  final String title;
  final String? value;

  const SymbolFilter({
    this.value,
    required this.title,
  });

  String getTranslatedTitle(BuildContext context) =>
      context.translate(title).capitalize();
}
