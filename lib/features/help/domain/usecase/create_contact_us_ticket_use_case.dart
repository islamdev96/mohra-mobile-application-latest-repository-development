import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/friend/data/model/request/add_friend_by_qrcode_param.dart';
import 'package:starter_application/features/friend/domain/repository/ifriend_repository.dart';
import 'package:starter_application/features/help/data/model/request/create_contact_us_ticket_params.dart';
import 'package:starter_application/features/help/domain/entity/faq_entity.dart';
import 'package:starter_application/features/help/domain/repository/ihelp_repository.dart';

import '../../../../core/params/no_params.dart';
@injectable
class CreateContactUSTicketUseCase extends UseCase<EmptyResponse, CreateContactUsTicketParams> {
  final IHelpRepository repository;

  CreateContactUSTicketUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(CreateContactUsTicketParams param) {
    return repository.createContactUsTicket(param);
  }
}
