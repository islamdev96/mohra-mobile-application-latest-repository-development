import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/data/model/request/get_event_request.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/event/domain/repository/ievent_repository.dart';

@injectable
class GetEventUseCase extends UseCase<EventEntity, GetEventRequest> {
  IEventRepository _iEventRepository;
  GetEventUseCase(this._iEventRepository);
  @override
  Future<Result<AppErrors, EventEntity>> call(GetEventRequest param) async {
    return await _iEventRepository.getEvent(param);
  }
}
