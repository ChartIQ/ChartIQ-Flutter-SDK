import 'package:dio/dio.dart';
import 'package:example/data/model/responses/symbol/symbol_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../api_const.dart';

part 'symbols_api.g.dart';

@RestApi()
abstract class SymbolsApi {
  factory SymbolsApi(Dio dio, {String? baseUrl}) => _SymbolsApi(
        dio,
        baseUrl: ApiConst.hostSymbols,
      );

  @GET('/chiq.symbolserver.SymbolLookup.service')
  Future<SymbolResponse> fetchSymbols(
    @Query("t") String symbol, {
    @Query("m") String maxResult = ApiConst.defaultMaxResult,
    @Query("x") String fund = ApiConst.defaultFunds,
    @Query("e") String? filter,
  });
}
