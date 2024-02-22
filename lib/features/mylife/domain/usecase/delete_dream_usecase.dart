import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/data/model/request/check_tast_request.dart';
import 'package:starter_application/features/mylife/data/model/request/delete_dream_params.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class DeleteDreamUsecase extends UseCase<EmptyResponse, DeleteDreamParams> {
  IMylifeRepository _iMylifeRepository;

  DeleteDreamUsecase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      DeleteDreamParams param) async {
    return await _iMylifeRepository.deleteDream(param);
  }
}
