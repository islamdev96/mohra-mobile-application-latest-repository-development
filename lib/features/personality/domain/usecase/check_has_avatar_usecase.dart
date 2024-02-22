import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/personality/domain/entity/has_avatar_entity.dart';
import 'package:starter_application/features/personality/domain/repository/ipersonality_repository.dart';

@singleton
class CheckHasAvatarUsecase extends UseCase<HasAvatarEntity, NoParams> {
  final IPersonalityRepository iPersonalityRepository;

  CheckHasAvatarUsecase(this.iPersonalityRepository);

  @override
  Future<Result<AppErrors, HasAvatarEntity>> call(NoParams param) {
    return iPersonalityRepository.hasAvatar(param);
  }
}