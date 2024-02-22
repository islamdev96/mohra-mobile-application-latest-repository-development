import 'package:starter_application/core/entities/nearby_places_entity.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/nearby_places_param.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/religion/data/model/request/azkar_param.dart';
import 'package:starter_application/features/religion/data/model/request/pray_time_param.dart';
import 'package:starter_application/features/religion/domain/entity/azkar_entity.dart';
import 'package:starter_application/features/religion/domain/entity/pray_time_entity.dart';

import '../../../../core/repositories/repository.dart';

abstract class IReligionRepository extends Repository {
  Future<Result<AppErrors, PrayTimeEntity>> getPrayerTimes(PrayTimeParam param);

  Future<Result<AppErrors, NearbyPlacesEntity>> getNearbyMosques(
      nearbyPlacesParam param);

  Future<Result<AppErrors, AzkarEntity>> getAzkarByCategory(AzkarParam param);
}
