import 'package:starter_application/core/errors/app_errors.dart';
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
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart';
import 'package:starter_application/features/user/domain/entity/get_profile_entity.dart';
import 'package:starter_application/features/user/domain/entity/update_profile_entity.dart';

import '../../../../core/repositories/repository.dart';

abstract class IUserRepository extends Repository {
  Future<Result<AppErrors, UpdateProfileEntity>> updateProfile(UpdateProfileParams params);
  Future<Result<AppErrors, CityListEntity>> getAllCity(GetCityParams params);
  Future<Result<AppErrors, AddressEntity>> updateAddress(CreateAddressParams params);
  Future<Result<AppErrors, AddressListEntity>> getAllAddresses(GetAddressParams params);
  Future<Result<AppErrors, GetProfileEntity>> getUserProfile(GetProfileParams params);
  Future<Result<AppErrors, EmptyResponse>> changePassword(ChangePasswordParams params);
  Future<Result<AppErrors, EmptyResponse>> deleteAddress(DeleteAddressParams params);
  Future<Result<AppErrors, EmptyResponse>> addAddress(CreateAddressParams params);
  Future<Result<AppErrors, EmptyResponse>> deleteAccount(DeleteAccountParams params);
  Future<Result<AppErrors, EmptyResponse>> changeEmail(ChangeEmailParams params);
  Future<Result<AppErrors, EmptyResponse>> selectAddress(SelectAddressParams params);
  Future<Result<AppErrors, MomentEntity>> getMyFriendMoments(GetMyFriendMomentsParams params);

}
