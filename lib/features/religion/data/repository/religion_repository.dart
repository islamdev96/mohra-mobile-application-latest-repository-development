import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/entities/nearby_places_entity.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/nearby_places_model.dart';
import 'package:starter_application/core/params/nearby_places_param.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/religion/data/model/request/azkar_param.dart';
import 'package:starter_application/features/religion/data/model/request/pray_time_param.dart';
import 'package:starter_application/features/religion/domain/entity/azkar_entity.dart';
import 'package:starter_application/features/religion/domain/entity/pray_time_entity.dart';

import '../datasource/../../domain/repository/ireligion_repository.dart';
import '../datasource/ireligion_remote.dart';

@Singleton(as: IReligionRepository)
class ReligionRepository extends IReligionRepository {
  final IReligionRemoteSource iReligionRemoteSource;

  ReligionRepository(this.iReligionRemoteSource);

  @override
  Future<Result<AppErrors, PrayTimeEntity>> getPrayerTimes(
      PrayTimeParam param) async {
    final remote = await iReligionRemoteSource.getPrayerTimes(param);
    return remote.result<PrayTimeEntity>();
  }

  @override
  Future<Result<AppErrors, NearbyPlacesEntity>> getNearbyMosques(
      nearbyPlacesParam param) async {
    final remote = await iReligionRemoteSource.getNearbyMosques(param);
    return remote.result<NearbyPlacesEntity>();
  }

  @override
  Future<Result<AppErrors, AzkarEntity>> getAzkarByCategory(
      AzkarParam param) async {
    final remote = await iReligionRemoteSource.getAzkar(param);
    print("reppppo${remote.result().data}");
    return remote.result<AzkarEntity>();
  }
}
