import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/data/model/request/get_all_events_request.dart';
import 'package:starter_application/features/event/domain/entity/events_entity.dart';
import 'package:starter_application/features/event/domain/repository/ievent_repository.dart';
import 'package:starter_application/features/moment/data/model/request/get_all_moments_request.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/moment/domain/repository/imoment_repository.dart';
import 'package:starter_application/features/mylife/data/model/request/get_all_tasks_request.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class GetMomentsUseCase extends UseCase<MomentEntity, GetMomentsRequest> {
  IMomentRepository _iMomentRepository;

  GetMomentsUseCase(this._iMomentRepository);

  @override
  Future<Result<AppErrors, MomentEntity>> call(GetMomentsRequest param) async {
    return await _iMomentRepository.getMoments(param);
  }
}
