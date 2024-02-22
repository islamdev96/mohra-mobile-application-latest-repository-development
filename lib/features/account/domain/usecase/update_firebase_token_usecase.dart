import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/update_firebase_token_request.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@injectable
class UpdateFirebaseTokenUseCase
    extends UseCase<EmptyResponse, UpdateFirebaseTokenParams> {
  final IAccountRepository accountRepository;

  UpdateFirebaseTokenUseCase(this.accountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(
          UpdateFirebaseTokenParams params) async =>
      await accountRepository.updateFirebaseToken(params);
}
