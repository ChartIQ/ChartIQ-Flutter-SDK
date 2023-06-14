import 'package:example/data/model/symbol/symbol_full_model.dart';

abstract class SymbolsRepository {
  Future<List<SymbolFullModel>> fetchSymbols(
    String symbol, {
    String? filter,
  });
}
