import 'package:injectable/injectable.dart';
import 'package:starter_application/core/entities/nearby_places_entity.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/nearby_places_param.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/religion/data/model/request/azkar_param.dart';
import 'package:starter_application/features/religion/domain/entity/azkar_entity.dart';
import 'package:starter_application/features/religion/domain/repository/ireligion_repository.dart';

@injectable
class GetAzkarByCategoryUsecase extends UseCase<AzkarEntity, AzkarParam> {
  final IReligionRepository repository;

  GetAzkarByCategoryUsecase(this.repository);

  @override
  Future<Result<AppErrors, AzkarEntity>> call(AzkarParam param) {
    var result=repository.getAzkarByCategory(param);
    print("usecase${result}");
    return repository.getAzkarByCategory(param);
  }
}
