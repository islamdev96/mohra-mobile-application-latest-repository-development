import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/location/data/model/request/get_locations_lite_params.dart';
import 'package:starter_application/features/location/domain/entity/locations_lite_entity.dart';

import '../repository/ilocation_repository.dart';

@injectable
class GetLocationsLiteUseCase
    extends UseCase<LocationsLiteEntity, GetLocationsLiteParams> {
  ILocationRepository iLocationRepository;

  GetLocationsLiteUseCase(this.iLocationRepository);
  @override
  Future<Result<AppErrors, LocationsLiteEntity>> call(
      GetLocationsLiteParams param) {
    return iLocationRepository.getLocationsLite(param);
  }
}
