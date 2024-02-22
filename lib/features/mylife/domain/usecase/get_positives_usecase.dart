import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/data/model/request/get_all_events_request.dart';
import 'package:starter_application/features/event/domain/entity/events_entity.dart';
import 'package:starter_application/features/event/domain/repository/ievent_repository.dart';
import 'package:starter_application/features/mylife/data/model/request/get_all_tasks_request.dart';
import 'package:starter_application/features/mylife/data/model/request/get_positive_request.dart';
import 'package:starter_application/features/mylife/domain/entity/DreamListEntity.dart';
import 'package:starter_application/features/mylife/domain/entity/PositiveListEntity.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class GetPositivesUseCase
    extends UseCase<PositiveListEntity, GetPositiveRequest> {
  IMylifeRepository _iMylifeRepository;

  GetPositivesUseCase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, PositiveListEntity>> call(GetPositiveRequest param) {
    return _iMylifeRepository.getAllPositives(param);
  }
}
