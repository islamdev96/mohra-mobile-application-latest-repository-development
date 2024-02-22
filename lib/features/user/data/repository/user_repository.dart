import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/models/empty_response.dart';

import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/account/domain/entity/city_entity.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
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
import 'package:starter_application/features/user/data/model/response/all_addresses_response.dart';
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart';
import 'package:starter_application/features/user/domain/entity/get_profile_entity.dart';
import 'package:starter_application/features/user/domain/entity/update_profile_entity.dart';
import '../datasource/../../domain/repository/iuser_repository.dart';
import '../datasource/iuser_remote.dart';

@Singleton(as: IUserRepository)
class UserRepository extends IUserRepository {
  final IUserRemoteSource iUserRemoteSource;

  UserRepository(this.iUserRemoteSource);



  @override
  Future<Result<AppErrors, CityListEntity>> getAllCity(GetCityParams params) async {
    final remote = await iUserRemoteSource.getAllCity(params);
    return remote.result<CityListEntity>();
  }

  @override
  Future<Result<AppErrors, AddressEntity>> updateAddress(CreateAddressParams params) async {
    final remote = await iUserRemoteSource.updateAddress(params);
    return remote.result<AddressEntity>();
  }

  @override
  Future<Result<AppErrors, AddressListEntity>> getAllAddresses(GetAddressParams params) async {
    final remote = await iUserRemoteSource.getAllAddresses(params);
    return remote.result<AddressListEntity>();
  }

  @override
  Future<Result<AppErrors, UpdateProfileEntity>> updateProfile(UpdateProfileParams params) async {
    final remote = await iUserRemoteSource.updateProfile(params);
    return remote.result<UpdateProfileEntity>();
  }

  @override
  Future<Result<AppErrors, GetProfileEntity>> getUserProfile(GetProfileParams params) async {
    final remote = await iUserRemoteSource.getUserProfile(params);
    return remote.result<GetProfileEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> addAddress(CreateAddressParams params) async{
    final remote = await iUserRemoteSource.addAddress(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> changePassword(ChangePasswordParams params) async{
    final remote = await iUserRemoteSource.changePassword(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> deleteAddress(DeleteAddressParams params) async{
    final remote = await iUserRemoteSource.deleteAddress(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> deleteAccount(DeleteAccountParams params) async {
    final remote = await iUserRemoteSource.deleteAccount(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> changeEmail(ChangeEmailParams params) async {
    final remote = await iUserRemoteSource.changeEmail(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> selectAddress(SelectAddressParams params) async {
    final remote = await iUserRemoteSource.selectAddress(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, MomentEntity>> getMyFriendMoments(GetMyFriendMomentsParams params) async {
    final remote = await iUserRemoteSource.getMyFriendMoments(params);
    return remote.result<MomentEntity>();
  }
}
