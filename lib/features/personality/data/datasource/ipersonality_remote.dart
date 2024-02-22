import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/personality/data/model/request/get_avatar_params.dart';
import 'package:starter_application/features/personality/data/model/request/personalityAnswers.dart';
import 'package:starter_application/features/personality/data/model/response/get_my_avatar_response.dart';
import 'package:starter_application/features/personality/data/model/response/get_ppersonallity_questions_response.dart';
import 'package:starter_application/features/personality/data/model/response/has_avatar_response.dart';
import '../../../../core/datasources/remote_data_source.dart';
import '../model/request/open_app_request.dart';

abstract class IPersonalityRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, PersonalityQuestionListModel>> getAllQuestions(NoParams params);
  Future<Either<AppErrors, AvatarListModel>> getMyAvatar(GetAvatarParams params);
  Future<Either<AppErrors, HasAvatarModel>> hasAvatar(NoParams params);
  Future<Either<AppErrors, EmptyResponse>> saveAnswers(SavePersonaliityAnswers params);
  Future<Either<AppErrors, EmptyResponse>> openApp(OpenAppRequest params);
  Future<Either<AppErrors, EmptyResponse>> closeApp(OpenAppRequest params);
}
