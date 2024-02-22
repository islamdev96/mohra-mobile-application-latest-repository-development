import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/domain/repository/ievent_repository.dart';

import '../../../../core/params/create_payment.dart';

@injectable
class CreatePaymentUseCase extends UseCase<EmptyResponse, CreatePaymentParam> {
  final IEventRepository repository;

  CreatePaymentUseCase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(CreatePaymentParam param) {
    return repository.createPayment(param);
  }
}
