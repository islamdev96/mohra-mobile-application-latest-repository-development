import 'package:injectable/injectable.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/place/data/model/request/reverse_geocoding_params.dart';
import 'package:starter_application/features/place/domain/entity/reverse_geocoding_entity.dart';
import 'package:starter_application/features/place/domain/repository/iplace_repository.dart';
@injectable
class GetReverseGeocodingUseCase
    extends UseCase<ReverseGeocodingEntity, ReverseGeocodingParam> {
  final IPlaceRepository repository;

  GetReverseGeocodingUseCase(this.repository);
  @override
  Future<Result<AppErrors, ReverseGeocodingEntity>> call(
      ReverseGeocodingParam param) {
    return repository.getReverseGeocoding(param);
  }
}
