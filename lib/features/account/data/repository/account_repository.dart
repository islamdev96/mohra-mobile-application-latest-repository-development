import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/account/data/datasources/iaccount_remote.dart';
import 'package:starter_application/features/account/data/model/request/check_device_id_params.dart';
import 'package:starter_application/features/account/data/model/request/check_exist_email_params.dart';
import 'package:starter_application/features/account/data/model/request/check_exist_phone_params.dart';
import 'package:starter_application/features/account/data/model/request/check_exist_userName_params.dart';
import 'package:starter_application/features/account/data/model/request/confirmPassword_request.dart';
import 'package:starter_application/features/account/data/model/request/confirm_phone_number_params.dart';
import 'package:starter_application/features/account/data/model/request/forgetpassword_request.dart';
import 'package:starter_application/features/account/data/model/request/get_client_profile_request.dart';
import 'package:starter_application/features/account/data/model/request/get_nearby_clients_request.dart';
import 'package:starter_application/features/account/data/model/request/google_login_params.dart';
import 'package:starter_application/features/account/data/model/request/google_register_params.dart';
import 'package:starter_application/features/account/data/model/request/login_request.dart';
import 'package:starter_application/features/account/data/model/request/register_request.dart';
import 'package:starter_application/features/account/data/model/request/update_firebase_token_request.dart';
import 'package:starter_application/features/account/data/model/request/update_location_request.dart';
import 'package:starter_application/features/account/data/model/request/verify_request.dart';
import 'package:starter_application/features/account/data/model/response/forgetPassword_model.dart';
import 'package:starter_application/features/account/data/model/response/login_model.dart';
import 'package:starter_application/features/account/data/model/response/register_model.dart';
import 'package:starter_application/features/account/data/model/response/verify_model.dart';
import 'package:starter_application/features/account/domain/entity/check_exist_phone_entity.dart';
import 'package:starter_application/features/account/domain/entity/client_profile_entity.dart';
import 'package:starter_application/features/account/domain/entity/forgetPassword_entity.dart';
import 'package:starter_application/features/account/domain/entity/login_entity.dart';
import 'package:starter_application/features/account/domain/entity/logout_entity.dart';
import 'package:starter_application/features/account/domain/entity/nearby_clients_entity.dart';
import 'package:starter_application/features/account/domain/entity/register_entity.dart';
import 'package:starter_application/features/account/domain/entity/verify_entity.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@Injectable(as: IAccountRepository)
class AccountRepository extends IAccountRepository {
  final IAccountRemoteSource iAccountRemoteSource;

  AccountRepository(this.iAccountRemoteSource);

  @override
  Future<Result<AppErrors, LoginEntity>> login(
      LoginRequest loginRequest) async {
    final remote = await iAccountRemoteSource.login(loginRequest);
    return execute<LoginModel, LoginEntity>(remoteResult: remote);
  }

  @override
  Future<Result<AppErrors, LogoutEntity>> logout(
      LogoutRequest logoutRequest) async {
    final remote = await iAccountRemoteSource.logout(logoutRequest);
    return remote.result<LogoutEntity>();
  }

  @override
  Future<Result<AppErrors, RegisterEntity>> register(
    RegisterRequest registerRequest,
  ) async {
    final remote = await iAccountRemoteSource.register(registerRequest);
    return execute<RegisterModel, RegisterEntity>(remoteResult: remote);
  }

  @override
  Future<Result<AppErrors, VerifyEntity>> verify(
      VerifyRequest verifyRequest) async {
    final remote = await iAccountRemoteSource.verify(verifyRequest);
    return execute<VerifyModel, VerifyEntity>(remoteResult: remote);
  }

  @override
  Future<Result<AppErrors, ForgetPasswordEntity>> ForgetPassword(
      ForgetPasswordRequest forgetPasswordRequest) async {
    final remote =
        await iAccountRemoteSource.ForgetPassword(forgetPasswordRequest);
    return execute<ForgetPasswordModel, ForgetPasswordEntity>(
        remoteResult: remote);
  }

  @override
  Future<Result<AppErrors, ForgetPasswordEntity>> ConfirmPassword(
      ConfirmPasswordRequest confirmPasswordRequest) async {
    final remote =
        await iAccountRemoteSource.ConfirmPassword(confirmPasswordRequest);
    return execute<ForgetPasswordModel, ForgetPasswordEntity>(
        remoteResult: remote);
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> confirmPasswordCode(
      ConfirmPasswordRequest confirmPasswordRequest) async {
    final remote =
        await iAccountRemoteSource.confirmPasswordCode(confirmPasswordRequest);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, ClientProfileEntity>> getClientProfile(
      GetClientProfileParams params) async {
    final remote = await iAccountRemoteSource.getClientProfile(params);
    return remote.result<ClientProfileEntity>();
  }

  @override
  Future<Result<AppErrors, NearbyClientsEntity>> getNearbyClients(
      GetNearbyClientsParams params) async {
    final remote = await iAccountRemoteSource.getNearbyClients(params);
    return remote.result<NearbyClientsEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> updateLocation(
      UpdateLocationParams params) async {
    final remote = await iAccountRemoteSource.updateLocation(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> updateFirebaseToken(
      UpdateFirebaseTokenParams params) async {
    final remote = await iAccountRemoteSource.updateFirebaseToken(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, LoginEntity>> loginWithGoogle(GoogleLoginParams loginRequest) async {
    final remote = await iAccountRemoteSource.loginWithGoogle(loginRequest);
    return execute<LoginModel, LoginEntity>(remoteResult: remote);
  }

  @override
  Future<Result<AppErrors, LoginEntity>> registerWithGoogle(GoogleRegisterParams loginRequest) async {
    final remote = await iAccountRemoteSource.registerWithGoogle(loginRequest);
    return execute<LoginModel, LoginEntity>(remoteResult: remote);;
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> confirmPhoneNumber(ConfirmPhoneNumberParams params) async {
    final remote = await iAccountRemoteSource.confirmPhoneNumber(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> checkIfPhoneExist(CheckIfPhoneExistParams params) async {
    final remote = await iAccountRemoteSource.checkIfPhoneExist(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> checkIfEmailExist(CheckIfEmailExistParams params)async {
    final remote = await iAccountRemoteSource.checkIfEmailExist(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> checkIfUsernameExist(CheckIfUsernameExistParams params)async {
    final remote = await iAccountRemoteSource.checkIfUsernameExist(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> checkDeviceId(CheckDeviceIdParams params)async {
    final remote = await iAccountRemoteSource.checkDeviceId(params);
    return remote.result<EmptyResponse>();
  }
}
