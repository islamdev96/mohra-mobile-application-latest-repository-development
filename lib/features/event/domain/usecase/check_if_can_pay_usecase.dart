import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/data/model/request/scan_ticket_qr_code_param.dart';
import 'package:starter_application/features/event/domain/repository/ievent_repository.dart';

import '../../data/model/request/create_ticket_request.dart';

@injectable
class CheckIfCanPayUseCase
    extends UseCase<EmptyResponse, CreateEventTicketRequest> {
  final IEventRepository repository;

  CheckIfCanPayUseCase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      CreateEventTicketRequest param) {
    return repository.checkIfCanPay(param);
  }
}
