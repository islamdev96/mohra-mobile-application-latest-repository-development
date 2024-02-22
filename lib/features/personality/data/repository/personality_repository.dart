import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/personality/data/model/request/get_avatar_params.dart';
import 'package:starter_application/features/personality/data/model/request/personalityAnswers.dart';
import 'package:starter_application/features/personality/domain/entity/avatar_entity.dart';
import 'package:starter_application/features/personality/domain/entity/has_avatar_entity.dart';
import 'package:starter_application/features/personality/domain/entity/personality_question_entity.dart';
import '../datasource/../../domain/repository/ipersonality_repository.dart';
import '../datasource/ipersonality_remote.dart';
import '../model/request/open_app_request.dart';

@Singleton(as: IPersonalityRepository)
class PersonalityRepository extends IPersonalityRepository {
  final IPersonalityRemoteSource iPersonalityRemoteSource;

  PersonalityRepository(this.iPersonalityRemoteSource);

  @override
  Future<Result<AppErrors, PersonalityQuestionListEntity>> getAllQuestions(
      NoParams params) async {
    final remote = await iPersonalityRemoteSource.getAllQuestions(params);
    return remote.result<PersonalityQuestionListEntity>();
  }

  @override
  Future<Result<AppErrors, AvatarListEntity>> getMyAvatar(
      GetAvatarParams params) async {
    final remote = await iPersonalityRemoteSource.getMyAvatar(params);
    return remote.result<AvatarListEntity>();
  }

  @override
  Future<Result<AppErrors, HasAvatarEntity>> hasAvatar(NoParams params) async {
    final remote = await iPersonalityRemoteSource.hasAvatar(params);
    return remote.result<HasAvatarEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> saveAnswers(
      SavePersonaliityAnswers params) async {
    final remote = await iPersonalityRemoteSource.saveAnswers(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> openApp(
      OpenAppRequest params) async {
    final remote = await iPersonalityRemoteSource.openApp(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> closeApp(
      OpenAppRequest params) async {
    final remote = await iPersonalityRemoteSource.closeApp(params);
    return remote.result<EmptyResponse>();
  }
}
