import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/health/data/model/request/answer_params.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';
import 'package:starter_application/features/user/data/model/request/get_city_params.dart';
import 'package:starter_application/features/user/data/model/request/get_profile_params.dart';
import 'package:starter_application/features/user/data/model/request/update_profile_params.dart';
import 'package:starter_application/features/user/domain/entity/get_profile_entity.dart';
import 'package:starter_application/features/user/domain/entity/update_profile_entity.dart';
import 'package:starter_application/features/user/domain/repository/iuser_repository.dart';

@singleton
class GetUserProfileUseCase extends UseCase<GetProfileEntity, GetProfileParams> {
  final IUserRepository iUserRepository ;

  GetUserProfileUseCase(this.iUserRepository);

  @override
  Future<Result<AppErrors, GetProfileEntity>> call(GetProfileParams param) {
    return iUserRepository.getUserProfile(param);
  }
}