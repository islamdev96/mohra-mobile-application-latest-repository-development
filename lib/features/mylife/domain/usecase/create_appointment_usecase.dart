import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/data/model/request/get_all_events_request.dart';
import 'package:starter_application/features/event/domain/entity/events_entity.dart';
import 'package:starter_application/features/event/domain/repository/ievent_repository.dart';
import 'package:starter_application/features/mylife/data/model/request/create_appointment_params.dart';
import 'package:starter_application/features/mylife/data/model/request/create_task_request.dart';
import 'package:starter_application/features/mylife/data/model/request/get_all_tasks_request.dart';
import 'package:starter_application/features/mylife/domain/entity/appointment_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class CreateAppointmentUseCase
    extends UseCase<AppointmentItemEntity, CreateAppointmentRequest> {
  IMylifeRepository _iMylifeRepository;

  CreateAppointmentUseCase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, AppointmentItemEntity>> call(
      CreateAppointmentRequest param) async {
    return await _iMylifeRepository.createAppointment(param);
  }
}
