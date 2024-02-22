import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/health/data/model/request/answer_params.dart';
import 'package:starter_application/features/personality/domain/entity/personality_question_entity.dart';
import 'package:starter_application/features/personality/domain/repository/ipersonality_repository.dart';

@singleton
class GetPersonalityQuestionUsecase extends UseCase<PersonalityQuestionListEntity, NoParams> {
  final IPersonalityRepository iPersonalityRepository;

  GetPersonalityQuestionUsecase(this.iPersonalityRepository);

  @override
  Future<Result<AppErrors, PersonalityQuestionListEntity>> call(NoParams param) {
    return iPersonalityRepository.getAllQuestions(param);
  }
}