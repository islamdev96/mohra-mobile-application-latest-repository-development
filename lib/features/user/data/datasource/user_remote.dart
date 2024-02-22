import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/default_create_model_inteceptor.dart';
import 'package:starter_application/core/net/response_validators/default_response_validator.dart';
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
import 'package:starter_application/features/user/data/model/response/all_addresses_response.dart'
    as AllAddresses;
import 'package:starter_application/features/user/data/model/response/all_addresses_response.dart';
import 'package:starter_application/features/user/data/model/response/get_city_response.dart';
import 'package:starter_application/features/user/data/model/response/get_profile_response.dart';
import 'package:starter_application/features/user/data/model/response/update_profile_response.dart';

import 'iuser_remote.dart';

@Singleton(as: IUserRemoteSource)
class UserRemoteSource extends IUserRemoteSource {
  @override
  Future<Either<AppErrors, CityListModel>> getAllCity(GetCityParams params) {
    return request(
      converter: (json) {
        return CityListModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getAllCities,
      queryParameters: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, AddressModel>> updateAddress(
      CreateAddressParams params) {
    return request(
      converter: (json) {
        return AddressModel.fromMap(json);
      },
      method: HttpMethod.PUT,
      url: APIUrls.updateAddress,
      body: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, AddressListModel>> getAllAddresses(
      GetAddressParams params) {
    return request(
      converter: (json) {
        return AddressListModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getAllAddresses,
      queryParameters: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, GetProfileModel>> getUserProfile(
      GetProfileParams params) {
    return request(
      converter: (json) {
        return GetProfileModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getUserProfile,
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, UpdateProfileModel>> updateProfile(
      UpdateProfileParams params) {
    return request(
      converter: (json) {
        return UpdateProfileModel.fromMap(json);
      },
      method: HttpMethod.PUT,
      url: APIUrls.updateUserProfile,
      body: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> addAddress(
      CreateAddressParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.createAddress,
      body: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> changePassword(
      ChangePasswordParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.changePassword,
      body: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deleteAddress(
      DeleteAddressParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.DELETE,
      url: APIUrls.deleteAddress,
      queryParameters: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deleteAccount(DeleteAccountParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.DELETE,
      url: APIUrls.deleteAccount,
      queryParameters: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> changeEmail(ChangeEmailParams params) {
    return request(
    converter: (json) {
    return EmptyResponse.fromMap(json);
    },
    method: HttpMethod.POST,
    url: APIUrls.changeEmail,
    queryParameters: params.toMap(),
    responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> selectAddress(SelectAddressParams params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.selectAddress,
      queryParameters: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, MomentModel>> getMyFriendMoments(GetMyFriendMomentsParams params) {
    return request(
      converter: (json) {
        return MomentModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getMyFriendMoments,
      queryParameters: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }
}
