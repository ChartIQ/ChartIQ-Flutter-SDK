import 'package:example/data/api/symbols/symbols_api.dart';
import 'package:example/data/api_const.dart';
import 'package:example/data/model/symbol/symbol_full_model.dart';
import 'package:example/data/provider/api_provider.dart';
import 'package:example/data/repository/symbol/symbols_repository_impl.dart';
import 'package:example/screen/symbol_search/symbol_filter_enum.dart';
import 'package:flutter/material.dart';

class SymbolSearchVM extends ChangeNotifier {
  final symbolRepository =
      SymbolsRepositoryImpl(SymbolsApi(ApiProvider(ApiConst.hostSymbols)));

  bool isLoading = false;

  SymbolFilter selectedFilter = SymbolFilter.all;

  List<SymbolFullModel> symbols = <SymbolFullModel>[];

  String searchText = '';

  bool isSearchDirty = false;

  void onFilterSelected(SymbolFilter filter) {
    selectedFilter = filter;
    notifyListeners();
    fetchSymbols();
  }

  void onSearchChanged(String text) {
    isSearchDirty = true;
    searchText = text;
    notifyListeners();
    fetchSymbols();
  }

  void fetchSymbols() async {
    try {
      isLoading = true;
      notifyListeners();
      symbols = await symbolRepository.fetchSymbols(
        searchText,
        filter: selectedFilter.value,
      );
    } catch (e) {
      print(e);
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
