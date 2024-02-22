import 'package:injectable/injectable.dart';
import 'package:starter_application/core/entities/nearby_places_entity.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/nearby_places_param.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/religion/domain/repository/ireligion_repository.dart';

@injectable
class GetNearbyMosquesUsecase
    extends UseCase<NearbyPlacesEntity, nearbyPlacesParam> {
  final IReligionRepository repository;

  GetNearbyMosquesUsecase(this.repository);

  @override
  Future<Result<AppErrors, NearbyPlacesEntity>> call(nearbyPlacesParam param) {
    return repository.getNearbyMosques(param.copyWith(type:param.type ?? "mosque"));
  }
}
