import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/confirm_phone_number_params.dart';
import 'package:starter_application/features/account/data/model/request/google_login_params.dart';
import 'package:starter_application/features/account/domain/entity/login_entity.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@singleton
class LoginWithGoogleUsecase extends UseCase<LoginEntity, GoogleLoginParams> {
  final IAccountRepository iAccountRepository ;

  LoginWithGoogleUsecase(this.iAccountRepository);

  @override
  Future<Result<AppErrors, LoginEntity>> call(GoogleLoginParams param) {
    return iAccountRepository.loginWithGoogle(param);
  }
}