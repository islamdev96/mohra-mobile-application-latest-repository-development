import 'package:injectable/injectable.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/religion/data/model/request/pray_time_param.dart';
import 'package:starter_application/features/religion/domain/entity/pray_time_entity.dart';
import 'package:starter_application/features/religion/domain/repository/ireligion_repository.dart';

@singleton
class GetPrayerTimesUsecase extends UseCase<PrayTimeEntity, PrayTimeParam> {
  final IReligionRepository repository;

  GetPrayerTimesUsecase(this.repository);
  @override
  Future<Result<AppErrors, PrayTimeEntity>> call(PrayTimeParam params) {
    return repository.getPrayerTimes(params);
  }
}
