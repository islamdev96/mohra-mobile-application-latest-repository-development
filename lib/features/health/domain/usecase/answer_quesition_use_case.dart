import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/health/data/model/request/answer_params.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class AnswerQuestionUsecase extends UseCase<EmptyResponse, AnswerParams> {
  final IHealthRepository iHealthRepository;

  AnswerQuestionUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(AnswerParams param) {
    return iHealthRepository.answerQuestion(param);
  }
}