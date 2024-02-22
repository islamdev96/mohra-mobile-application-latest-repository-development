import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/data/model/request/scan_ticket_qr_code_param.dart';
import 'package:starter_application/features/event/domain/repository/ievent_repository.dart';
import 'package:starter_application/features/event_orginizer/data/datasource/ievent_orginizer_remote.dart';
import 'package:starter_application/features/event_orginizer/domain/repository/ievent_orginizer_repository.dart';

@injectable
class ScanTicketQrCodeUseCase
    extends UseCase<EmptyResponse, ScanTicketQrCodeParam> {
  final IEventOrginizerRepository repository;

  ScanTicketQrCodeUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(ScanTicketQrCodeParam param) {
    return repository.scanTicketQrCode(param);
  }
}
