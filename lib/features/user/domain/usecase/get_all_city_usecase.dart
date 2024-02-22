import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/domain/entity/city_entity.dart';
import 'package:starter_application/features/user/data/model/request/get_city_params.dart';
import 'package:starter_application/features/user/domain/repository/iuser_repository.dart';

@singleton
class GetAllCityUseCase extends UseCase<CityListEntity, GetCityParams> {
  final IUserRepository iUserRepository ;

  GetAllCityUseCase(this.iUserRepository);

  @override
  Future<Result<AppErrors, CityListEntity>> call(GetCityParams param) {
    return iUserRepository.getAllCity(param);
  }
}