import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/domain/entity/city_entity.dart';
import 'package:starter_application/features/health/data/model/request/image_params.dart';
import 'package:starter_application/features/health/domain/entity/image_urls_entity.dart';
import 'package:starter_application/features/health/domain/usecase/upload_image_usecase.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/personality/data/model/request/get_avatar_params.dart';
import 'package:starter_application/features/personality/domain/entity/avatar_entity.dart';
import 'package:starter_application/features/personality/domain/usecase/get_my_avatar_usecase.dart';
import 'package:starter_application/features/user/data/model/request/change_email_params.dart';
import 'package:starter_application/features/user/data/model/request/change_password_params.dart';
import 'package:starter_application/features/user/data/model/request/create_address_params.dart';
import 'package:starter_application/features/user/data/model/request/delete_account_params.dart';
import 'package:starter_application/features/user/data/model/request/delete_address_params.dart';
import 'package:starter_application/features/user/data/model/request/get_address_params.dart';
import 'package:starter_application/features/user/data/model/request/get_city_params.dart';
import 'package:starter_application/features/user/data/model/request/get_my_friend_moments_params.dart';
import 'package:starter_application/features/user/data/model/request/get_profile_params.dart';
import 'package:starter_application/features/user/data/model/request/select_address_params.dart';
import 'package:starter_application/features/user/data/model/request/update_profile_params.dart';
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart';
import 'package:starter_application/features/user/domain/entity/get_profile_entity.dart';
import 'package:starter_application/features/user/domain/entity/update_profile_entity.dart';
import 'package:starter_application/features/user/domain/usecase/add_address_usecase.dart';
import 'package:starter_application/features/user/domain/usecase/change_email_usecase.dart';
import 'package:starter_application/features/user/domain/usecase/change_password_usecase.dart';
import 'package:starter_application/features/user/domain/usecase/delete_account_usecase.dart';
import 'package:starter_application/features/user/domain/usecase/delete_address_usecase.dart';
import 'package:starter_application/features/user/domain/usecase/get_all_addresses_usecase.dart';
import 'package:starter_application/features/user/domain/usecase/get_all_city_usecase.dart';
import 'package:starter_application/features/user/domain/usecase/get_my_friend_moments_usecase.dart';
import 'package:starter_application/features/user/domain/usecase/get_user_profile_usecase.dart';
import 'package:starter_application/features/user/domain/usecase/select_address_usecase.dart';
import 'package:starter_application/features/user/domain/usecase/update_address_usecase.dart';
import 'package:starter_application/features/user/domain/usecase/update_profile_use_case.dart';
import '../../../../../core/errors/app_errors.dart';

part 'user_state.dart';

part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState.userInitState());

  void updateProfile(UpdateProfileParams params) async {
    emit(const UserState.updateProfile());
    final result = await getIt<UpdateUserProfileUseCase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(UserState.updateProfileDone(data)),
      onError: (error) => emit(
        UserState.userErrorState(error, () => this.updateProfile(params)),
      ),
    );
  }

  void uploadImage(ImageParams params) async {
    emit(const UserState.uploadImage());
    final result = await getIt<UploadImageUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(UserState.uploadImageDone(data)),
      onError: (error) => emit(
        UserState.userErrorState(error, () => this.uploadImage(params)),
      ),
    );
  }

  void getAllCity(GetCityParams params) async {
    emit(const UserState.userLoadingState());
    final result = await getIt<GetAllCityUseCase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(UserState.getCityDone(data)),
      onError: (error) => emit(
        UserState.userErrorState(error, () => this.getAllCity(params)),
      ),
    );
  }

  void updateAddress(CreateAddressParams params) async {
    emit(const UserState.updateAddress());
    final result = await getIt<UpdateAddressUseCase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(UserState.updateAddressDone(data)),
      onError: (error) => emit(
        UserState.userErrorState(error, () => this.updateAddress(params)),
      ),
    );
  }

  void getAllAddresses(GetAddressParams params) async {
    emit(const UserState.userLoadingState());
    final result = await getIt<GetAllAddressesUseCase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(UserState.getAddressesDone(data)),
      onError: (error) => emit(
        UserState.userErrorState(error, () => this.getAllAddresses(params)),
      ),
    );
  }

  void getProfile(GetProfileParams params) async {
    emit(const UserState.userLoadingState());
    final result = await getIt<GetUserProfileUseCase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(UserState.getProfileDone(data)),
      onError: (error) => emit(
        UserState.userErrorState(error, () => this.getProfile(params)),
      ),
    );
  }

  void changePassword(ChangePasswordParams params) async {
    emit(const UserState.userLoadingState());
    final result = await getIt<ChangePasswordUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(UserState.changePasswordDone()),
      onError: (error) => emit(
        UserState.userErrorState(error, () => this.changePassword(params)),
      ),
    );
  }

  void addAddress(CreateAddressParams params) async {
    emit(const UserState.userLoadingState());
    final result = await getIt<AddAddressUseCase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(UserState.addAddressDone()),
      onError: (error) => emit(
        UserState.userErrorState(error, () => this.addAddress(params)),
      ),
    );
  }

  void deleteAddress(DeleteAddressParams params) async {
    emit(const UserState.userLoadingState());
    final result = await getIt<DeleteAddressUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(UserState.addressDeleted()),
      onError: (error) => emit(
        UserState.userErrorState(error, () => this.deleteAddress(params)),
      ),
    );
  }

  void getMyAvatar(GetAvatarParams params) async {
    final result = await getIt<GetMyAvatarUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(UserState.avatarLoaded(data)),
      onError: (error) => emit(
        UserState.userErrorState(
            error, () => this.getMyAvatar(params)),
      ),
    );
  }


  void deleteAccount(DeleteAccountParams params) async {
    emit(const UserState.userLoadingState());
    final result = await getIt<DeleteAccountUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(UserState.deleteAccountDone()),
      onError: (error) => emit(
        UserState.userErrorState(error, () => this.deleteAccount(params)),
      ),
    );
  }

  void changeEmail(ChangeEmailParams params) async {
    emit(const UserState.userLoadingState());
    final result = await getIt<ChangeEmailUseCase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(UserState.emailChanged()),
      onError: (error) => emit(
        UserState.userErrorState(error, () => this.changeEmail(params)),
      ),
    );
  }

  void selectAddress(SelectAddressParams params) async {
    emit(const UserState.setSelectAddress());
    final result = await getIt<SelectAddressUsecase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(const UserState.addressSelectedDone()),
      onError: (error) => emit(
        UserState.userErrorState(error, () => this.selectAddress(params)),
      ),
    );
  }

  void getMyFriendMometns(GetMyFriendMomentsParams params) async {
    emit(const UserState.userLoadingState());
    final result = await getIt<GetMyFriendMomentsUseCase>()(params);
    print('aassd');
    result.pick(
      onData: (data) => emit(UserState.getFriendMomentsDone(data)),
      onError: (error) => emit(
        UserState.userErrorState(error, () => this.getMyFriendMometns(params)),
      ),
    );
  }
}
