import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/repositories/repository.dart';
import 'package:starter_application/core/results/result.dart';
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
import 'package:starter_application/features/account/domain/entity/check_exist_phone_entity.dart';
import 'package:starter_application/features/account/domain/entity/client_profile_entity.dart';
import 'package:starter_application/features/account/domain/entity/forgetPassword_entity.dart';
import 'package:starter_application/features/account/domain/entity/login_entity.dart';
import 'package:starter_application/features/account/domain/entity/logout_entity.dart';
import 'package:starter_application/features/account/domain/entity/nearby_clients_entity.dart';
import 'package:starter_application/features/account/domain/entity/register_entity.dart';
import 'package:starter_application/features/account/domain/entity/verify_entity.dart';

abstract class IAccountRepository extends Repository {
  Future<Result<AppErrors, LoginEntity>> login(LoginRequest loginRequest);

  Future<Result<AppErrors, LogoutEntity>> logout(LogoutRequest LogoutRequest);

  Future<Result<AppErrors, RegisterEntity>> register(
      RegisterRequest registerRequest);

  Future<Result<AppErrors, VerifyEntity>> verify(VerifyRequest verifyRequest);

  Future<Result<AppErrors, ForgetPasswordEntity>> ForgetPassword(
      ForgetPasswordRequest forgetPasswordRequest);

  Future<Result<AppErrors, ForgetPasswordEntity>> ConfirmPassword(
      ConfirmPasswordRequest confirmPasswordRequest);

  Future<Result<AppErrors, EmptyResponse>> confirmPasswordCode(
      ConfirmPasswordRequest confirmPasswordRequest);

  Future<Result<AppErrors, ClientProfileEntity>> getClientProfile(
      GetClientProfileParams params);

  Future<Result<AppErrors, EmptyResponse>> updateLocation(
      UpdateLocationParams params);

  Future<Result<AppErrors, NearbyClientsEntity>> getNearbyClients(
      GetNearbyClientsParams params);
  Future<Result<AppErrors, EmptyResponse>> updateFirebaseToken(
      UpdateFirebaseTokenParams params);

  Future<Result<AppErrors, LoginEntity>> loginWithGoogle(GoogleLoginParams loginRequest);
  Future<Result<AppErrors, LoginEntity>> registerWithGoogle(GoogleRegisterParams loginRequest);
  Future<Result<AppErrors, EmptyResponse>> confirmPhoneNumber(ConfirmPhoneNumberParams params);
  Future<Result<AppErrors, EmptyResponse>> checkIfPhoneExist(
      CheckIfPhoneExistParams params);

  Future<Result<AppErrors, EmptyResponse>> checkIfEmailExist(
      CheckIfEmailExistParams params);

  Future<Result<AppErrors, EmptyResponse>> checkIfUsernameExist(
      CheckIfUsernameExistParams params);

  Future<Result<AppErrors, EmptyResponse>> checkDeviceId(
      CheckDeviceIdParams params);

}
