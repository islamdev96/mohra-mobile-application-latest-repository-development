import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/net/net.dart';
import 'package:starter_application/features/location/data/model/request/get_locations_lite_params.dart';
import 'package:starter_application/features/location/data/model/response/locations_lite_model.dart';

import 'ilocation_remote.dart';

@Singleton(as: ILocationRemoteSource)
class LocationRemoteSource extends ILocationRemoteSource {
  @override
  Future<Either<AppErrors, LocationsLiteModel>> getLocationsLite(
      GetLocationsLiteParams param) {
    return request(
        converter: (json) => LocationsLiteModel.fromMap(json),
        method: HttpMethod.GET,
        queryParameters: param.toMap(),
        url: APIUrls.API_GET_LOCATIONS_LITE);
  }
}
