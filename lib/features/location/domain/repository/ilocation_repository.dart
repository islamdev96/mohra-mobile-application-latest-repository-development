import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/location/data/model/request/get_locations_lite_params.dart';
import 'package:starter_application/features/location/domain/entity/locations_lite_entity.dart';

import '../../../../core/repositories/repository.dart';

abstract class ILocationRepository extends Repository {
  Future<Result<AppErrors, LocationsLiteEntity>> getLocationsLite(
      GetLocationsLiteParams param);
}
