import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/update_location_request.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@injectable
class UpdateLocationUseCase extends UseCase<EmptyResponse, UpdateLocationParams> {
  final IAccountRepository accountRepository;

  UpdateLocationUseCase(this.accountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(UpdateLocationParams params) async =>
      await accountRepository.updateLocation(params);
}