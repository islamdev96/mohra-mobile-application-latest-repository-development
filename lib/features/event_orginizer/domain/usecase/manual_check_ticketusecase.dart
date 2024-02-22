import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event_orginizer/data/model/request/event_details_params.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/event_tickets_entity.dart';
import 'package:starter_application/features/friend/data/model/request/add_friend_by_qrcode_param.dart';
import 'package:starter_application/features/friend/domain/repository/ifriend_repository.dart';
import 'package:starter_application/features/help/domain/entity/faq_entity.dart';
import 'package:starter_application/features/help/domain/repository/ihelp_repository.dart';

import '../../../../core/params/no_params.dart';
import '../../data/model/request/manual_event_check_params.dart';
import '../entity/my_running_events_entity.dart';
import '../repository/ievent_orginizer_repository.dart';
@injectable
class ManualCheckTicketUsecase
    extends UseCase<EmptyResponse, ManualCheckEventParams> {
  final IEventOrginizerRepository repository;

  ManualCheckTicketUsecase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(ManualCheckEventParams param) {
    return repository.manualCheckingEventTicket(param);
  }


}
