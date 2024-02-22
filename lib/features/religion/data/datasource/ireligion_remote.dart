import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/nearby_places_model.dart';
import 'package:starter_application/core/params/nearby_places_param.dart';
import 'package:starter_application/features/religion/data/model/request/azkar_param.dart';
import 'package:starter_application/features/religion/data/model/request/pray_time_param.dart';
import 'package:starter_application/features/religion/data/model/response/azkar_model.dart';
import 'package:starter_application/features/religion/data/model/response/pray_time_model.dart';

import '../../../../core/datasources/remote_data_source.dart';

abstract class IReligionRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, PrayTimeModel>> getPrayerTimes(PrayTimeParam param);

  Future<Either<AppErrors, NearbyPlacesModel>> getNearbyMosques(
      nearbyPlacesParam param);

  Future<Either<AppErrors, AzkarModel>> getAzkar(AzkarParam param);
}
