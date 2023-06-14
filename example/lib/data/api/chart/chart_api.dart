import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../api_const.dart';
import '../../model/chart_model.dart';

part 'chart_api.g.dart';

@RestApi()
abstract class ChartApi {
  factory ChartApi(Dio dio, {String? baseUrl}) => _ChartApi(
        dio,
        baseUrl: ApiConst.hostSimulator,
      );

  @GET('/datafeed')
  Future<List<ChartModel>> fetchDataFeed({
    @Query("identifier") String? identifier,
    @Query("startdate") String? startDate,
    @Query("enddate") String? endDate,
    @Query("interval") String? interval,
    @Query("period") String? period,
    @Query("extended") String? extended = ApiConst.defaultExtended,
    @Query("session") String? session,
  });
}
