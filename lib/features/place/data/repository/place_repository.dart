import 'package:injectable/injectable.dart';
import 'package:starter_application/features/place/domain/entity/reverse_geocoding_entity.dart';
import 'package:starter_application/features/place/data/model/request/reverse_geocoding_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/errors/app_errors.dart';

import '../datasource/../../domain/repository/iplace_repository.dart';
import '../datasource/iplace_remote.dart';
import '/core/common/extensions/either_error_model_extension.dart';

@Singleton(as: IPlaceRepository)
class PlaceRepository extends IPlaceRepository {
  final IPlaceRemoteSource iPlaceRemoteSource;

  PlaceRepository(this.iPlaceRemoteSource);

  @override
  Future<Result<AppErrors, ReverseGeocodingEntity>> getReverseGeocoding(
      ReverseGeocodingParam param) async {
    final remoteResult = await iPlaceRemoteSource.getReverseGeocoding(param);
    return remoteResult.result<ReverseGeocodingEntity>();
  }
}
