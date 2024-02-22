import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/health/domain/entity/question_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class GetQuestionsUsecase extends UseCase<QuestionsEntity , NoParams >{

  final IHealthRepository iHealthRepository;
  GetQuestionsUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, QuestionsEntity>> call(NoParams param) {
    return iHealthRepository.getAllQuestions(param);
  }

}
