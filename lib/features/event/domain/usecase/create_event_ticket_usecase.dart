import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/data/model/request/create_ticket_request.dart';
import 'package:starter_application/features/event/domain/entity/create_event_ticket_entity.dart';
import 'package:starter_application/features/event/domain/repository/ievent_repository.dart';

@injectable
class CreateEventTicketUseCase
    extends UseCase<CreateEventTicketEntity, CreateEventTicketRequest> {
  final IEventRepository eventRepository;
  CreateEventTicketUseCase(this.eventRepository);

  @override
  Future<Result<AppErrors, CreateEventTicketEntity>> call(
      CreateEventTicketRequest param) async {
    return await eventRepository.createEventTicket(param);
  }
}
