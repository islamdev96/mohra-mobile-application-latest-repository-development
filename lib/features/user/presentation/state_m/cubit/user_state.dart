part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.userInitState() = UserInitState;

  const factory UserState.userLoadingState() = UserLoadingState;

  const factory UserState.userErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = UserErrorState;

  const factory UserState.updateProfile() = UpdateProfile;

  const factory UserState.updateProfileDone(
      UpdateProfileEntity updateProfileEntity) = UpdateProfileDone;

  const factory UserState.uploadImageDone(ImageUrlsEntity imageUrlsEntity) =
      UploadImageDone;

  const factory UserState.uploadImage() = UploadImage;

  const factory UserState.getCityDone(CityListEntity cityListEntity) =
      GetCityDone;

  const factory UserState.updateAddress() = UpdateAddress;

  const factory UserState.updateAddressDone(AddressEntity addressEntity) =
      UpdateAddressDone;

  const factory UserState.getAddressesDone(AddressListEntity allAddressesEntity) =
  GetAddressesDone;

  const factory UserState.getProfileDone(GetProfileEntity getProfileEntity) =
  GetProfileDone;

  const factory UserState.changePasswordDone() =
  ChangePasswordDone;

  const factory UserState.addressDeleted() =
  AddressDeleted;

  const factory UserState.avatarLoaded(
      AvatarListEntity avatarListEntity
      ) = AvatarLoaded;

  const factory UserState.addAddressDone() =
  AddAddressDone;

  const factory UserState.deleteAccountDone() =
  DeleteAccountDone;

  const factory UserState.emailChanged() =
  EmailChanged;

  const factory UserState.setSelectAddress() =
  SetSelectAddress;

  const factory UserState.addressSelectedDone() =
  AddressSelectedDone;

  const factory UserState.getFriendMomentsDone(MomentEntity momentEntity) = GetFriendMomentsDone;

}
