import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/data/model/request/get_event_tickets_request.dart';
import 'package:starter_application/features/event/domain/entity/event_tickets_entity.dart';
import 'package:starter_application/features/event/domain/repository/ievent_repository.dart';

@injectable
class GetEventTicketsUseCase
    extends UseCase<EventTicketsEntity, GetEventsTicketsRequest> {
  final IEventRepository eventRepository;
  GetEventTicketsUseCase(this.eventRepository);

  @override
  Future<Result<AppErrors, EventTicketsEntity>> call(
      GetEventsTicketsRequest param) async {
    return await eventRepository.getEventTickets(param);
  }
}
