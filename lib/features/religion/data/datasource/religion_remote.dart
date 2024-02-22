import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/nearby_places_model.dart';
import 'package:starter_application/core/net/create_model_interceptor/all_data_create_model_inteceptor.dart';
import 'package:starter_application/core/net/create_model_interceptor/live_socores_model_intercepter.dart';
import 'package:starter_application/core/net/net.dart';
import 'package:starter_application/core/net/response_validators/live_socores_validator.dart';
import 'package:starter_application/core/net/response_validators/google_search_validator.dart';
import 'package:starter_application/core/net/response_validators/prayer_times_response_validator.dart';
import 'package:starter_application/core/params/nearby_places_param.dart';
import 'package:starter_application/features/religion/data/model/request/azkar_param.dart';
import 'package:starter_application/features/religion/data/model/request/pray_time_param.dart';
import 'package:starter_application/features/religion/data/model/response/azkar_model.dart';
import 'package:starter_application/features/religion/data/model/response/pray_time_model.dart';

import 'ireligion_remote.dart';

@Singleton(as: IReligionRemoteSource)
class ReligionRemoteSource extends IReligionRemoteSource {
  @override
  Future<Either<AppErrors, PrayTimeModel>> getPrayerTimes(PrayTimeParam param) {
    return request(
      converter: (json) => PrayTimeModel.fromMap(json),
      method: HttpMethod.GET,
      url:
          "${APIUrls.PRAYER_TIME_URL}/${DateFormat("dd-MM-yyyy").format(param.time)}",
      queryParameters: param.toMap(),
      responseValidator: PrayerTimesResponseValidator(),
      createModelInterceptor: const AllDataCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, NearbyPlacesModel>> getNearbyMosques(
      nearbyPlacesParam param) {
    return request(
      converter: (json) => NearbyPlacesModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.NEARBY_SEARCH_URL,
      queryParameters: param.toMap(),
      responseValidator: GoogleSearchValidator(),
      createModelInterceptor: const AllDataCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, AzkarModel>> getAzkar(AzkarParam param) {
    return request(
      converter: (json) => AzkarModel.fromJson(json),
      method: HttpMethod.GET,
      queryParameters: param.toMap(),
      url: "${APIUrls.API_AZKAR_OF_CATEGORY}",
      responseValidator: LiveSocoresValidator(),
      createModelInterceptor: LiveSocoresModelIntercepter(),
      cancelToken: param.cancelToken,
    );
  }
}
