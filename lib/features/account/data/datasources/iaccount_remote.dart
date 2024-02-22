import 'package:dartz/dartz.dart';
import 'package:starter_application/core/datasources/remote_data_source.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
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
import 'package:starter_application/features/account/data/model/response/check_phone_exist_model.dart';
import 'package:starter_application/features/account/data/model/response/client_profile_model.dart';
import 'package:starter_application/features/account/data/model/response/forgetPassword_model.dart';
import 'package:starter_application/features/account/data/model/response/login_model.dart';
import 'package:starter_application/features/account/data/model/response/logout_model.dart';
import 'package:starter_application/features/account/data/model/response/nearby_clients_model.dart';
import 'package:starter_application/features/account/data/model/response/register_model.dart';
import 'package:starter_application/features/account/data/model/response/verify_model.dart';

abstract class IAccountRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, LoginModel>> login(LoginRequest loginRequest);

  Future<Either<AppErrors, LogoutModel>> logout(LogoutRequest LogoutRequest);

  Future<Either<AppErrors, RegisterModel>> register(
      RegisterRequest registerRequest);
  Future<Either<AppErrors, VerifyModel>> verify(VerifyRequest verifyRequest);

  Future<Either<AppErrors, ForgetPasswordModel>> ForgetPassword(
      ForgetPasswordRequest forgetPasswordRequest);
  Future<Either<AppErrors, ForgetPasswordModel>> ConfirmPassword(
      ConfirmPasswordRequest confirmPasswordRequest);

  Future<Either<AppErrors, EmptyResponse>> confirmPasswordCode(
      ConfirmPasswordRequest confirmPasswordRequest);

  Future<Either<AppErrors, ClientProfileModel>> getClientProfile(
      GetClientProfileParams params);

  Future<Either<AppErrors, NearbyClientsModel>> getNearbyClients(
      GetNearbyClientsParams params);

  Future<Either<AppErrors, EmptyResponse>> updateLocation(
      UpdateLocationParams params);

  Future<Either<AppErrors, EmptyResponse>> updateFirebaseToken(
      UpdateFirebaseTokenParams params);

  Future<Either<AppErrors, LoginModel>> loginWithGoogle(GoogleLoginParams loginRequest);
  Future<Either<AppErrors, LoginModel>> registerWithGoogle(GoogleRegisterParams loginRequest);
  Future<Either<AppErrors, EmptyResponse>> confirmPhoneNumber(
      ConfirmPhoneNumberParams params);

  Future<Either<AppErrors, EmptyResponse>> checkIfPhoneExist(
      CheckIfPhoneExistParams params);


  Future<Either<AppErrors, EmptyResponse>> checkIfEmailExist(
      CheckIfEmailExistParams params);

  Future<Either<AppErrors, EmptyResponse>> checkIfUsernameExist(
      CheckIfUsernameExistParams params);

  Future<Either<AppErrors, EmptyResponse>> checkDeviceId(
      CheckDeviceIdParams params);

}
