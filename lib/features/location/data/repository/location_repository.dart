import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/location/data/model/request/get_locations_lite_params.dart';
import 'package:starter_application/features/location/domain/entity/locations_lite_entity.dart';

import '../datasource/../../domain/repository/ilocation_repository.dart';
import '../datasource/ilocation_remote.dart';

@Singleton(as: ILocationRepository)
class LocationRepository extends ILocationRepository {
  final ILocationRemoteSource iLocationRemoteSource;

  LocationRepository(this.iLocationRemoteSource);

  @override
  Future<Result<AppErrors, LocationsLiteEntity>> getLocationsLite(
      GetLocationsLiteParams param) async {
    final remoteResult = await iLocationRemoteSource.getLocationsLite(param);
    return remoteResult.result<LocationsLiteEntity>();
  }
}
