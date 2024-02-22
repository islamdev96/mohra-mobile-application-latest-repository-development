import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/personality/data/model/request/get_avatar_params.dart';
import 'package:starter_application/features/personality/data/model/request/personalityAnswers.dart';
import 'package:starter_application/features/personality/domain/entity/avatar_entity.dart';
import 'package:starter_application/features/personality/domain/entity/has_avatar_entity.dart';
import 'package:starter_application/features/personality/domain/entity/personality_question_entity.dart';

import '../../../../core/repositories/repository.dart';
import '../../data/model/request/open_app_request.dart';

abstract class IPersonalityRepository extends Repository {
  Future<Result<AppErrors, PersonalityQuestionListEntity>> getAllQuestions(NoParams params);
  Future<Result<AppErrors, AvatarListEntity>> getMyAvatar(GetAvatarParams params);
  Future<Result<AppErrors, HasAvatarEntity>> hasAvatar(NoParams params);
  Future<Result<AppErrors, EmptyResponse>> saveAnswers(SavePersonaliityAnswers params);
  Future<Result<AppErrors, EmptyResponse>> openApp(OpenAppRequest params);
  Future<Result<AppErrors, EmptyResponse>> closeApp(OpenAppRequest params);
}

