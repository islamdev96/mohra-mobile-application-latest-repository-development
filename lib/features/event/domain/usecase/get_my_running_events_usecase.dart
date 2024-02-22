import 'package:injectable/injectable.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/data/model/request/get_my_running_events_param.dart';
import 'package:starter_application/features/event/domain/entity/my_running_events_list_entity.dart';
import 'package:starter_application/features/event/domain/repository/ievent_repository.dart';

@injectable
class GetMyRunningEventsUsecase
    extends UseCase<MyRunningEventsListEntity, GetMyRunningEventsParam> {
  final IEventRepository repository;

  GetMyRunningEventsUsecase(this.repository);

  @override
  Future<Result<AppErrors, MyRunningEventsListEntity>> call(
      GetMyRunningEventsParam param) {
    return repository.getMyRunningEvents(param);
  }
}
