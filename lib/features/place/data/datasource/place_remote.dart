import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/all_data_create_model_inteceptor.dart';
import 'package:starter_application/core/net/response_validators/google_search_validator.dart';
import 'package:starter_application/features/place/data/model/request/reverse_geocoding_params.dart';
import 'package:starter_application/features/place/data/model/response/reverse_geocoding_model.dart';

import 'iplace_remote.dart';

@Singleton(as: IPlaceRemoteSource)
class PlaceRemoteSource extends IPlaceRemoteSource {
  @override
  Future<Either<AppErrors, ReverseGeocodingModel>> getReverseGeocoding(
      ReverseGeocodingParam param) {
    return request(
      converter: (json) => ReverseGeocodingModel.fromMap(json),
      method: HttpMethod.GET,
      url:APIUrls.API_REVERSE_GEOCODING ,
      
      createModelInterceptor: const AllDataCreateModelInterceptor(),
      responseValidator: GoogleSearchValidator(),
      queryParameters: param.toMap(),
    );
  }
}
