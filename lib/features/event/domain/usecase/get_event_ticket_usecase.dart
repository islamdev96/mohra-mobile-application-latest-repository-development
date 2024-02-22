import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/data/model/request/get_event_ticket_request.dart';
import 'package:starter_application/features/event/domain/entity/event_ticket_entity.dart';
import 'package:starter_application/features/event/domain/repository/ievent_repository.dart';

@injectable
class GetEventTicketUseCase
    extends UseCase<EventTicketEntity, GetEventTicketRequest> {
  final IEventRepository eventRepository;
  GetEventTicketUseCase(this.eventRepository);

  @override
  Future<Result<AppErrors, EventTicketEntity>> call(
      GetEventTicketRequest param) async {
    return await eventRepository.getEventTicket(param);
  }
}
