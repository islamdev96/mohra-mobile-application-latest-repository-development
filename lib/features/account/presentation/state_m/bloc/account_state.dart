part of 'account_cubit.dart';

@freezed
class AccountState with _$AccountState {
  const factory AccountState.accountInit() = AccountInit;
  const factory AccountState.accountLoading() = AccountLoading;
  const factory AccountState.loginLoaded(LoginEntity loginEntity) =AccLoginLoaded;
  const factory AccountState.logoutLoaded(LogoutEntity loginEntity) =AccLogoutLoaded;
  const factory AccountState.registerLoaded(RegisterEntity registerEntity) =
      AccRegisterLoaded;
  const factory AccountState.accountError(
      AppErrors error, VoidCallback callback) = AccountError;
  const factory AccountState.verifyLoaded(VerifyEntity verifyEntity) =
      VerifyLoaded;
  const factory AccountState.forgetpasswordLoaded(
      ForgetPasswordEntity forgetPasswordEntity) = ForgetpasswordLoaded;
  const factory AccountState.clientProfileLoadedState(
      ClientProfileEntity clientProfileEntity) = ClientProfileLoadedState;

  const factory AccountState.passwordCodeVerified() = PasswordCodeVerified;

  const factory AccountState.getAvatar() = GetAvatar;
  const factory AccountState.nearbyClientsLoadedState(
      NearbyClientsEntity nearbyClientsEntity) = NearbyClientsLoadedState;
  const factory AccountState.locationUpdatedState(EmptyResponse emptyResponse) =
      LocationUpdatedState;
  const factory AccountState.firebaseTokenUpdated(EmptyResponse emptyResponse) =
      FirebaseTokenUpdated;
  const factory AccountState.hasAvatarChecked(HasAvatarEntity hasAvatarEntity) =
      HasAvatarChecked;

  const factory AccountState.loginWithGoogleDone(LoginEntity loginEntity) =
  LoginWithGoogleDone;

  const factory AccountState.registerWithGoogleDone(LoginEntity loginEntity) =
  RegisterWithGoogleDone;

  const factory AccountState.phoneNumberConfirmed(EmptyResponse emptyResponse) =
  PhoneNumberConfirmed;

  const factory AccountState.checkPhoneNumberExistLoading() =
  CheckPhoneNumberExistLoading;

  const factory AccountState.checkPhoneNumberExistError(AppErrors error) =
  CheckPhoneNumberExistError;

  const factory AccountState.checkPhoneNumberExistDone(EmptyResponse emptyResponse) =
  CheckPhoneNumberExistDone;

  const factory AccountState.checkUsernameExistLoading() =
  CheckUsernameExistLoading;

  const factory AccountState.checkUsernameExistError(AppErrors error) =
  CheckUsernameExistError;

  const factory AccountState.checkUsernameExistDone(EmptyResponse emptyResponse) =
  CheckUsernameExistDone;

  const factory AccountState.checkEmailExistLoading() =
  CheckEmailExistLoading;

  const factory AccountState.checkEmailExistError(AppErrors error) =
  CheckEmailExistError;

  const factory AccountState.checkEmailExistDone(EmptyResponse emptyResponse) =
  CheckEmailExistDone;

  const factory AccountState.checkDeviceIdDone(EmptyResponse emptyResponse) =
  CheckDeviceIdDone;

}
