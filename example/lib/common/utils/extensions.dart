import 'package:example/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension CustomExtensions on String {
  bool toBool() {
    return toLowerCase() == "true" || toLowerCase() == "1";
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String capitalizeAll() {
    return split(' ').map((str) => str.capitalize()).join(' ');
  }
}

extension IterableExtension<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension RemoteTranslateExtension on BuildContext {
  String translate(String key) {
    return read<LocaleProvider>().translate(key);
  }

  String translateWatch(String key) {
    return watch<LocaleProvider>().translate(key);
  }
}