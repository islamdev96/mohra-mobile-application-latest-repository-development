import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/features/place/data/model/request/reverse_geocoding_params.dart';
import 'package:starter_application/features/place/data/model/response/reverse_geocoding_model.dart';

import '../../../../core/datasources/remote_data_source.dart';

abstract class IPlaceRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, ReverseGeocodingModel>> getReverseGeocoding(ReverseGeocodingParam param);
}
