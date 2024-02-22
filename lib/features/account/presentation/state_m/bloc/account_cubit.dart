import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/di/service_locator.dart';
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
import 'package:starter_application/features/account/domain/usecase/ConfirmPassword_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/check_device_id_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/check_exist_email_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/check_exist_phone_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/check_exist_username_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/confirm_password_code_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/confirm_phone_number_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/forgetPassword_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/get_client_profile_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/get_nearby_clients_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/login_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/login_with_google_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/logout_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/register_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/register_with_google_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/update_firebase_token_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/update_location_usecase.dart';
import 'package:starter_application/features/account/domain/usecase/verify_usecase.dart';
import 'package:starter_application/features/personality/domain/entity/has_avatar_entity.dart';
import 'package:starter_application/features/personality/domain/usecase/check_has_avatar_usecase.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../../../main.dart';

part 'account_cubit.freezed.dart';
part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountState.accountInit());

  void login(LoginRequest body) async {
    emit(AccountState.accountLoading());

    final result = await getIt<LoginUseCase>()(body);

    result.pick(
      onData: (data) async {
        try {
          await logEvent("af_login", null);
        } catch (e) {}
        emit(AccountState.loginLoaded(data));
      },
      onError: (error) {
        emit(AccountState.accountError(error, () => this.login(body)));
      },
    );
  }

  void logout(LogoutRequest body) async {
    emit(AccountState.accountLoading());

    final result = await getIt<LogoutUseCase>()(body);

    result.pick(
      onData: (data) async {
        emit(AccountState.logoutLoaded(data));
      },
      onError: (error) {
        emit(AccountState.accountError(error, () => this.logout(body)));
      },
    );
  }

  getClientProfile(GetClientProfileParams params) async {
    emit(const AccountState.accountLoading());

    final result = await getIt<GetClientProfileUseCase>()(params);

    result.pick(
      onData: (data) {
        emit(AccountState.clientProfileLoadedState(data));
      },
      onError: (error) {
        emit(AccountState.accountError(
            error, () => this.getClientProfile(params)));
      },
    );
  }

  void register(RegisterRequest body) async {
    emit(AccountState.accountLoading());

    final result = await getIt<RegisterUseCase>()(body);

    result.pick(
      onData: (data) async {
        try {
          await logEvent(
              "af_complete_registration", {"af_registration_method": "email"});
        } catch (e) {}
        emit(AccountState.registerLoaded(result.data!));
      },
      onError: (error) {
        emit(AccountState.accountError(error, () => this.register(body)));
      },
    );
  }

  void verify(VerifyRequest body) async {
    emit(AccountState.accountLoading());

    final result = await getIt<VerifyUseCase>()(body);

    result.pick(
      onData: (data) {
        emit(AccountState.verifyLoaded(data));
      },
      onError: (error) {
        emit(AccountState.accountError(error, () => this.verify(body)));
      },
    );
  }

  void ForgetPassword(ForgetPasswordRequest body) async {
    emit(const AccountState.accountLoading());

    final result = await getIt<ForgetPasswordUseCase>()(body);

    result.pick(
      onData: (data) {
        emit(AccountState.forgetpasswordLoaded(data));
      },
      onError: (error) {
        emit(AccountState.accountError(error, () => this.ForgetPassword(body)));
      },
    );
  }

  void ConfirmPassword(ConfirmPasswordRequest body) async {
    emit(const AccountState.accountLoading());

    final result = await getIt<ConfirmPasswordUseCase>()(body);

    result.pick(
      onData: (data) {
        emit(AccountState.forgetpasswordLoaded(data));
      },
      onError: (error) {
        emit(
            AccountState.accountError(error, () => this.ConfirmPassword(body)));
      },
    );
  }

  void ConfirmPasswordCode(ConfirmPasswordRequest body) async {
    emit(const AccountState.accountLoading());

    final result = await getIt<ConfirmPasswordCodeUseCase>()(body);

    result.pick(
      onData: (data) {
        emit(AccountState.passwordCodeVerified());
      },
      onError: (error) {
        emit(AccountState.accountError(error, () => this.ConfirmPasswordCode));
      },
    );
  }

  void checkHasAvatar(NoParams params) async {
    emit(const AccountState.getAvatar());
    final result = await getIt<CheckHasAvatarUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(AccountState.hasAvatarChecked(data)),
      onError: (error) => emit(
        AccountState.accountError(error, () => this.checkHasAvatar(params)),
      ),
    );
  }

  getNearbyClients(GetNearbyClientsParams params) async {
    emit(const AccountState.accountLoading());
    final result = await getIt<GetNearbyClientsUseCase>()(params);
    result.pick(
      onData: (data) => emit(AccountState.nearbyClientsLoadedState(data)),
      onError: (error) => emit(
        AccountState.accountError(error, () => this.getNearbyClients(params)),
      ),
    );
  }

  updateLocation(UpdateLocationParams params) async {
    emit(const AccountState.accountLoading());
    final result = await getIt<UpdateLocationUseCase>()(params);
    result.pick(
      onData: (data) => emit(AccountState.locationUpdatedState(data)),
      onError: (error) => emit(
        AccountState.accountError(error, () => this.updateLocation(params)),
      ),
    );
  }

  updateFirebaseToken(UpdateFirebaseTokenParams params) async {
    emit(const AccountState.accountLoading());
    final result = await getIt<UpdateFirebaseTokenUseCase>()(params);
    print("Firesbase${params.token}");
    result.pick(
      onData: (data) => emit(AccountState.locationUpdatedState(data)),
      onError: (error) => emit(
        AccountState.accountError(
            error, () => this.updateFirebaseToken(params)),
      ),
    );
  }

  void loginWithGoogle(GoogleLoginParams params) async {
    emit(const AccountState.accountLoading());
    final result = await getIt<LoginWithGoogleUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(AccountState.loginWithGoogleDone(data)),
      onError: (error) => emit(
        AccountState.accountError(error, () => this.loginWithGoogle(params)),
      ),
    );
  }

  void registerWithGoogle(GoogleRegisterParams params) async {
    emit(const AccountState.accountLoading());
    final result = await getIt<RegisterWithGoogleUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(AccountState.registerWithGoogleDone(data)),
      onError: (error) => emit(
        AccountState.accountError(error, () => this.registerWithGoogle(params)),
      ),
    );
  }

  void confirmPhoneNumber(ConfirmPhoneNumberParams params) async {
    emit(const AccountState.accountLoading());
    final result = await getIt<ConfirmPhoneNumberUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(AccountState.phoneNumberConfirmed(data)),
      onError: (error) => emit(
        AccountState.accountError(error, () => this.confirmPhoneNumber(params)),
      ),
    );
  }

  void checkExistPhoneNumber(CheckIfPhoneExistParams params) async {
    emit(const AccountState.checkPhoneNumberExistLoading());
    final result = await getIt<CheckIfPhoneExistUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(AccountState.checkPhoneNumberExistDone(data)),
      onError: (error) => emit(
        AccountState.checkPhoneNumberExistError(error),
      ),
    );
  }

  void checkExistEmail(CheckIfEmailExistParams params) async {
    emit(const AccountState.checkEmailExistLoading());
    final result = await getIt<CheckIfEmailExistUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(AccountState.checkEmailExistDone(data)),
      onError: (error) => emit(
        AccountState.checkEmailExistError(error),
      ),
    );
  }

  void checkExistUsername(CheckIfUsernameExistParams params) async {
    emit(const AccountState.checkUsernameExistLoading());
    final result = await getIt<CheckIfUsernameExistUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(AccountState.checkUsernameExistDone(data)),
      onError: (error) => emit(
        AccountState.checkUsernameExistError(error),
      ),
    );
  }

  Future<void> checkDeviceId(CheckDeviceIdParams params) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      emit(AccountState.checkDeviceIdDone(
          EmptyResponse(message: '', succeed: false)));
    } else {
      emit(const AccountState.checkUsernameExistLoading());
      final result = await getIt<CheckDeviceIdUsecase>()(params);
      print('aassd');
      result.pick(
          onData: (data) => emit(AccountState.checkDeviceIdDone(data)),
          onError: (error) {
            error.maybeMap(
                unauthorizedError: (e) {},
                unknownError: (e){},
                forbiddenError: (e){},
                timeoutError: (e){
                  checkDeviceId(params);
                },
                cancelError: (e){
                  checkDeviceId(params);
                },
                netError: (e){
                  checkDeviceId(params);
                },
                orElse: () {

                });
            emit(
              AccountState.accountError(
                  error, () => this.checkDeviceId(params)),
            );
          });
    }
  }
}
