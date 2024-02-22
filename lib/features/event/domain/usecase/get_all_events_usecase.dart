import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/data/model/request/get_all_events_request.dart';
import 'package:starter_application/features/event/domain/entity/events_entity.dart';
import 'package:starter_application/features/event/domain/repository/ievent_repository.dart';

@injectable
class GetEventsUseCase extends UseCase<EventsEntity, GetEventsRequest> {
  IEventRepository _iEventRepository;
  GetEventsUseCase(this._iEventRepository);
  @override
  Future<Result<AppErrors, EventsEntity>> call(GetEventsRequest param) async {
    return await _iEventRepository.getAllEvents(param);
  }
}
