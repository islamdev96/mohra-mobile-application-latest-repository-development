import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/personality/data/model/request/get_avatar_params.dart';
import 'package:starter_application/features/personality/data/model/request/personalityAnswers.dart';
import 'package:starter_application/features/personality/domain/entity/avatar_entity.dart';
import 'package:starter_application/features/personality/domain/entity/personality_question_entity.dart';
import 'package:starter_application/features/personality/domain/repository/ipersonality_repository.dart';
import 'package:starter_application/features/salary_count/data/model/request/create_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/delete_time_table_params.dart';
import 'package:starter_application/features/salary_count/data/model/request/get_all_time_table_params.dart';
import 'package:starter_application/features/salary_count/domain/entity/time_table_list_entity.dart';
import 'package:starter_application/features/salary_count/domain/repository/isalary_count_repository.dart';

@singleton
class DeleteTimeTableUsecase extends UseCase<EmptyResponse, DeleteTimeTableParams> {
  final ISalaryCountRepository iSalaryCountRepository;

  DeleteTimeTableUsecase(this.iSalaryCountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(DeleteTimeTableParams param) {
    return iSalaryCountRepository.deleteTimeTable(param);
  }
}