import 'package:example/data/api/symbols/symbols_api.dart';
import 'package:example/data/model/symbol/symbol_full_model.dart';
import 'package:example/data/repository/symbol/symbols_repository.dart';

class SymbolsRepositoryImpl extends SymbolsRepository {
  final SymbolsApi symbolsApi;

  SymbolsRepositoryImpl(this.symbolsApi);

  @override
  Future<List<SymbolFullModel>> fetchSymbols(
    String symbol, {
    String? filter,
  }) async {
    try {
      final response = await symbolsApi.fetchSymbols(symbol, filter: filter);
      return response.payload.symbols
          .map((e) => SymbolFullModel.fromString(e))
          .toList();
    } on TypeError catch (_) {
      return [];
    }
  }
}
