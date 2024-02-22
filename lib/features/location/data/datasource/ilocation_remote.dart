import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/features/location/data/model/request/get_locations_lite_params.dart';
import 'package:starter_application/features/location/data/model/response/locations_lite_model.dart';

import '../../../../core/datasources/remote_data_source.dart';

abstract class ILocationRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, LocationsLiteModel>> getLocationsLite(
      GetLocationsLiteParams param);
}
