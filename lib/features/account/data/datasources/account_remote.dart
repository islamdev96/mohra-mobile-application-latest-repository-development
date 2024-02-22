import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/all_data_create_model_inteceptor.dart';
import 'package:starter_application/core/net/create_model_interceptor/default_create_model_inteceptor.dart';
import 'package:starter_application/core/net/create_model_interceptor/null_response_model_interceptor.dart';
import 'package:starter_application/core/net/response_validators/default_response_validator.dart';
import 'package:starter_application/core/net/response_validators/prayer_times_response_validator.dart';
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

import 'iaccount_remote.dart';

@Injectable(as: IAccountRemoteSource)
class AccountRemoteSource extends IAccountRemoteSource {
  @override
  Future<Either<AppErrors, RegisterModel>> register(RegisterRequest params) {
    return request(
      converter: (json) {
        return RegisterModel.fromMap(json);
      },
      headers: {
        'content-type': 'application/json',
      },
      method: HttpMethod.POST,
      url: APIUrls.CreateRegister,
      body: params.toMap(),
      createModelInterceptor: const NullResponseModelInterceptor(),
      responseValidator: PrayerTimesResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, LoginModel>> login(LoginRequest loginRequest) {
    print(loginRequest);
    return request(
      converter: (json) {
        return LoginModel.fromMap(json);
      },
      headers: {
        'content-type': 'application/json',
      },
      method: HttpMethod.POST,
      url: APIUrls.Login,
      body: loginRequest.toMap(),

    );
  }

  @override
  Future<Either<AppErrors, LogoutModel>> logout(LogoutRequest LogoutRequest) {
    print(LogoutRequest);
    return request(
      converter: (json) => LogoutModel.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.Logout,
      body: LogoutRequest.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, VerifyModel>> verify(VerifyRequest verifyRequest) {
    print('ddfsfsdfs');
    print(verifyRequest);
    return request(
      converter: (json) {
        return VerifyModel.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.Verify,
      body: verifyRequest.toMap(),
      createModelInterceptor: const NullResponseModelInterceptor(),
      responseValidator: PrayerTimesResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, ForgetPasswordModel>> ForgetPassword(
      ForgetPasswordRequest forgetPasswordRequest) {
    return request(
      converter: (json) {
        return ForgetPasswordModel.fromMap(json);
      },
      headers: {
        'content-type': 'application/json',
      },
      method: HttpMethod.POST,
      url: APIUrls.ForgetPassword,
      body: forgetPasswordRequest.toMap(),
      createModelInterceptor: const NullResponseModelInterceptor(),
      responseValidator: PrayerTimesResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, ForgetPasswordModel>> ConfirmPassword(
      ConfirmPasswordRequest confirmPasswordRequest) {
    return request(
      converter: (json) {
        return ForgetPasswordModel.fromMap(json);
      },
      headers: {
        'content-type': 'application/json',
      },
      method: HttpMethod.POST,
      url: APIUrls.ConfirmPassword,
      body: confirmPasswordRequest.toMap(),
      createModelInterceptor: const NullResponseModelInterceptor(),
      responseValidator: PrayerTimesResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> confirmPasswordCode(
      ConfirmPasswordRequest confirmPasswordRequest) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      headers: {
        'content-type': 'application/json',
      },
      method: HttpMethod.POST,
      url: APIUrls.verifyPasswordCode,
      body: confirmPasswordRequest.toMap(),
      createModelInterceptor: const NullResponseModelInterceptor(),
      responseValidator: PrayerTimesResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, ClientProfileModel>> getClientProfile(
      GetClientProfileParams params) async {
    return request(
        converter: (json) => ClientProfileModel.fromMap(json),
        method: HttpMethod.GET,
        url: APIUrls.GET_CLIENT_PROFILE,
        queryParameters: params.toMap());
  }

  @override
  Future<Either<AppErrors, NearbyClientsModel>> getNearbyClients(
      GetNearbyClientsParams params) {
    return request(
      converter: (json) => NearbyClientsModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.GET_NEARBY_CLIENTS,
      queryParameters: params.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> updateLocation(
      UpdateLocationParams params) {
    return request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.PUT,
        createModelInterceptor: const NullResponseModelInterceptor(),
        url: APIUrls.UPDATE_LOCATION,
        withAuthentication: true,
        body: params.toMap());
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> updateFirebaseToken(
      UpdateFirebaseTokenParams params) {
    return request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.PUT,
        createModelInterceptor: const NullResponseModelInterceptor(),
        url: APIUrls.UPDATE_FIREBASE_TOKEN,
        body: params.toMap());
  }

  @override
  Future<Either<AppErrors, LoginModel>> loginWithGoogle(GoogleLoginParams loginRequest) {
    return request(
      converter: (json) {
        return LoginModel.fromMap(json);
      },
      headers: {
        'content-type': 'application/json',
      },
      method: HttpMethod.POST,
      url: APIUrls.loginWithGoogle,
      queryParameters: loginRequest.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, LoginModel>> registerWithGoogle(GoogleRegisterParams loginRequest) {
    return request(
      converter: (json) {
        return LoginModel.fromMap(json);
      },
      headers: {
        'content-type': 'application/json',
      },
      method: HttpMethod.POST,
      url: APIUrls.registerWithGoogle,
      queryParameters: loginRequest.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> confirmPhoneNumber(ConfirmPhoneNumberParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.confirmPhoneNumber,
      queryParameters: params.toMap(),
      createModelInterceptor: const NullResponseModelInterceptor(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> checkIfPhoneExist(CheckIfPhoneExistParams params) {
    print('12312');
    print(params);
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.checkPhoneNumberIfExist,
      body: params.toMap(),
      createModelInterceptor: NullResponseModelInterceptor(),

    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> checkIfEmailExist(CheckIfEmailExistParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.checkEmailIfExist,
      body: params.toMap(),
      createModelInterceptor: NullResponseModelInterceptor(),

    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> checkIfUsernameExist(CheckIfUsernameExistParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.checkUsernameIfExist,
      body: params.toMap(),
      createModelInterceptor: NullResponseModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> checkDeviceId(CheckDeviceIdParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.checkDeviceId,
      queryParameters: params.toMap(),
      createModelInterceptor: NullResponseModelInterceptor(),
    );
  }
}
