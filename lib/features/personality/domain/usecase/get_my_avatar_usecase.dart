import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/personality/data/model/request/get_avatar_params.dart';
import 'package:starter_application/features/personality/domain/entity/avatar_entity.dart';
import 'package:starter_application/features/personality/domain/entity/personality_question_entity.dart';
import 'package:starter_application/features/personality/domain/repository/ipersonality_repository.dart';

@singleton
class GetMyAvatarUsecase extends UseCase<AvatarListEntity, GetAvatarParams> {
  final IPersonalityRepository iPersonalityRepository;

  GetMyAvatarUsecase(this.iPersonalityRepository);

  @override
  Future<Result<AppErrors, AvatarListEntity>> call(GetAvatarParams param) {
    return iPersonalityRepository.getMyAvatar(param);
  }
}