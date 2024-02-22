import 'package:starter_application/features/place/domain/entity/reverse_geocoding_entity.dart';

import 'package:starter_application/features/place/data/model/request/reverse_geocoding_params.dart';

import 'package:starter_application/core/results/result.dart';

import 'package:starter_application/core/errors/app_errors.dart';

import '../../../../core/repositories/repository.dart';

abstract class IPlaceRepository extends Repository {
  Future<Result<AppErrors, ReverseGeocodingEntity>> getReverseGeocoding(
      ReverseGeocodingParam param);
}
