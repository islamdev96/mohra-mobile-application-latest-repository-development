import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/features/moment/data/model/response/moment_model.dart';
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
import 'package:starter_application/features/user/data/model/response/get_city_response.dart';
import 'package:starter_application/features/user/data/model/response/get_profile_response.dart';
import 'package:starter_application/features/user/data/model/response/update_profile_response.dart';
import '../../../../core/datasources/remote_data_source.dart';

abstract class IUserRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, UpdateProfileModel>> updateProfile(UpdateProfileParams params);
  Future<Either<AppErrors, CityListModel>> getAllCity(GetCityParams params);
  Future<Either<AppErrors, AddressListModel>> getAllAddresses(GetAddressParams params);
  Future<Either<AppErrors, GetProfileModel>> getUserProfile(GetProfileParams params);
  Future<Either<AppErrors, EmptyResponse>> changePassword(ChangePasswordParams params);
  Future<Either<AppErrors, EmptyResponse>> deleteAddress(DeleteAddressParams params);
  Future<Either<AppErrors, EmptyResponse>> addAddress(CreateAddressParams params);
  Future<Either<AppErrors, AddressModel>> updateAddress(CreateAddressParams params);
  Future<Either<AppErrors, EmptyResponse>> deleteAccount(DeleteAccountParams params);
  Future<Either<AppErrors, EmptyResponse>> changeEmail(ChangeEmailParams params);
  Future<Either<AppErrors, EmptyResponse>> selectAddress(SelectAddressParams params);
  Future<Either<AppErrors, MomentModel>> getMyFriendMoments(GetMyFriendMomentsParams params);

}
