import 'dart:convert';

import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:starter_application/core/constants/enums/user_type.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/features/account/data/model/response/login_model.dart';
import 'package:starter_application/features/account/domain/entity/login_entity.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/features/user/domain/entity/get_profile_entity.dart';
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart'
    as AddressUpdated;

class UserSessionDataModel {
  static String accessToken = '';
  static int userId = 0;
  static int? shopId;
  static UserType userType = UserType.OTHER;
  static String fullName = '';
  static String birthday = '';
  static String name = '';
  static String surname = '';
  static String emailAddress = '';
  static bool isEmailConfirmed = true;
  static String phoneNumber = '';
  static bool isPhoneNumberConfirmed = true;
  static int? cityId;
  static String? imageUrl;
  static String? coverPhoto;
  static String? countryCode;
  static String? code;
  static int? points;
  static int? status;
  static int? gender;
  static String? userName;
  static AddressEntity? addressEntity;
  static String? qrCode;
  static int storyId = 1;
  static String? provider;
  static int? avatarMonth;

  static AddressUpdated.AddressEntity? updateAddress;

  static saveProfile(
      String access_Token,
      int user_Id,
      int? shop_Id,
      int user_Type,
      String full_Name,
      String name_,
      String? birthday_,
      String sur_name,
      String email_Address,
      bool is_Email_Confirmed,
      String phone_Number,
      bool is_PhoneNumber_Confirmed,
      int? city_Id,
      String? image_Url,
      String? cover_photo,
      String? code_,
      int? points_,
      int? status_,
      int? gender_,
      String? user_Name,
      AddressEntity? addressEntity_,
      String? qrCode_,
      String? countryCode_,
      int? avatarMonth_) async {
    accessToken = access_Token;
    userId = user_Id;
    shopId = shop_Id;
    userType = int2UserType(user_Type);
    fullName = full_Name;
    name = name_;
    surname = sur_name;
    emailAddress = email_Address;
    isEmailConfirmed = is_Email_Confirmed;
    phoneNumber = phone_Number;
    isPhoneNumberConfirmed = is_PhoneNumber_Confirmed;
    cityId = city_Id;
    imageUrl = image_Url;
    coverPhoto = cover_photo;
    code = code_;
    points = points_;
    status = status_;
    userName = user_Name;
    gender = gender_;
    birthday = DateTimeHelper.getStringDateInEnglish(birthday_);
    addressEntity = addressEntity_;
    qrCode = qrCode_;
    countryCode = countryCode_;
    avatarMonth = avatarMonth_;
    await _saveInSP();
  }

  static getFromSP() async {
    var sp = await SpUtil.getInstance();
    accessToken = sp.get('accessToken') ?? '';
    userId = sp.get('user_Id') ?? 0;
    shopId = sp.get('shopId');
    userType = int2UserType(sp.getInt('userType') ?? -1);
    cityId = sp.get('cityId');
    points = sp.get('points');
    status = sp.get('status');
    gender = sp.get('gender');
    fullName = sp.get(
          'fullName',
        ) ??
        '';
    provider = sp.get('provider') ?? 'normal';
    countryCode = sp.get('countryCode') ?? '';
    coverPhoto = sp.get('coverPhoto') ?? '';
    name = sp.get('first_name') ?? '';
    birthday = sp.get('birthday') ?? '';
    surname = sp.get('surname') ?? '';
    emailAddress = sp.get('emailAddress') ?? '';
    phoneNumber = sp.get('phoneNumber') ?? '';
    imageUrl = sp.get('imageUrl');
    code = sp.get('code');
    qrCode = sp.get('qrCode');
    userName = sp.get('userName');
    isEmailConfirmed = sp.get('isEmailConfirmed') ?? false;
    isPhoneNumberConfirmed = sp.get('isPhoneNumberConfirmed') ?? false;
    String? addressString = sp.getString('userAddress');
    print('sssssssssssssss + ${addressString}');
    print(addressString == null);
    if (addressString != null) {
      String addressJson = jsonDecode(addressString);
      AddressEntity addressEntityFromJson =
          AddressModel.fromJson(addressJson).toEntity();
      addressEntity = addressEntityFromJson;
    }
  }

  static updateProfileSP(
    String new_name,
    String new_lastName,
    String new_fullName,
    String? new_date,
    int new_gender,
    String? new_image,
    String new_email,
    int avatarMonth_,
  ) async {
    fullName = new_fullName;
    name = new_name;
    surname = new_lastName;
    emailAddress = new_email;
    imageUrl = new_image;
    gender = new_gender;
    avatarMonth = avatarMonth_;
    birthday =
        new_date != null ? DateTimeHelper.getStringDateInEnglish(new_date) : "";
    var sp = await SpUtil.getInstance();
    sp.putInt('gender', gender ?? -1);
    sp.putString('fullName', fullName);
    sp.putString('birthday', birthday);
    sp.putInt('avatarMonth', avatarMonth!);
    sp.putString('first_name', name);
    sp.putString('surname', surname);
    sp.putString('emailAddress', emailAddress);
    sp.putString('imageUrl', imageUrl ?? '');
  }

  static updateCoverPhoto(String imageUrl) async {
    coverPhoto = imageUrl;
    var sp = await SpUtil.getInstance();
    sp.putString('coverPhoto', coverPhoto ?? '');
  }

  static getUserCityStreet() {
    if (addressEntity == null) {
      return '';
    }
    if (addressEntity!.city == null) {
      return '';
    }
    return '${addressEntity!.city!.text!} , ${addressEntity!.street}';
  }

  static updateUserAddress(AddressEntity addressEntity_) async {
    var sp = await SpUtil.getInstance();
    addressEntity = addressEntity_;
    if (addressEntity != null) {
      String addressJson = jsonEncode(addressEntity?.toJson());
      sp.putString('userAddress', addressJson);
    }
  }

  static updateName(
      String firstName1, String lastName1, String fullName1) async {
    var sp = await SpUtil.getInstance();
    fullName = fullName1;
    name = firstName1;
    surname = lastName1;
    sp.putString('fullName', fullName);
    sp.putString('first_name', name);
    sp.putString('surname', surname);
  }

  static Future<void> updateProfileData(
      GetProfileEntity getProfileEntity) async {
    name = getProfileEntity.name;
    surname = getProfileEntity.surname;
    fullName = getProfileEntity.fullName;
    gender = getProfileEntity.gender;
    status = getProfileEntity.status;
    birthday = getProfileEntity.birthDate != null
        ? DateTimeHelper.getFormatedDate(getProfileEntity.birthDate)
        : null;
    emailAddress = getProfileEntity.emailAddress;
    phoneNumber = getProfileEntity.phoneNumber;
    code = getProfileEntity.code;
    imageUrl = getProfileEntity.imageUrl;
    coverPhoto = getProfileEntity.cover;
    points = getProfileEntity.points;
    countryCode = getProfileEntity.countryCode;
    await _saveInSP();
  }

  static updatePhoneNumber(String phone, String code) async {
    phoneNumber = phone;
    countryCode = code;
    var sp = await SpUtil.getInstance();
    sp.putString('countryCode', countryCode ?? '');
    sp.putString('phoneNumber', phoneNumber);
  }

  static updateBirthDate(String? date) async {
    birthday = date ?? "";
    var sp = await SpUtil.getInstance();
    sp.putString('birthday', birthday);
  }

  static _saveInSP() async {
    var sp = await SpUtil.getInstance();
    sp.putString('accessToken', accessToken);
    sp.putInt('user_Id', userId);
    sp.putInt('shopId', shopId ?? -1);
    sp.putInt('userType', userType2Int(userType));
    sp.putInt('cityId', cityId ?? -1);
    sp.putInt('points', points ?? -1);
    sp.putInt('status', status ?? -1);
    sp.putInt('gender', gender ?? -1);
    sp.putString('fullName', fullName);
    sp.putString('birthday', birthday);
    sp.putString('first_name', name);
    sp.putString('surname', surname);
    sp.putString('emailAddress', emailAddress);
    sp.putString('phoneNumber', phoneNumber);
    sp.putString('imageUrl', imageUrl ?? '');
    sp.putString('coverPhoto', coverPhoto ?? '');
    sp.putString('code', code ?? '');
    sp.putString('provider', provider ?? 'normal');
    sp.putString('qrCode', qrCode ?? '');
    sp.putString('userName', userName ?? '');
    sp.putInt('avatarMonth', avatarMonth ?? 0);
    sp.putString('countryCode', countryCode ?? '');
    sp.putBool('isEmailConfirmed', isEmailConfirmed);
    sp.putBool('isPhoneNumberConfirmed', isPhoneNumberConfirmed);
    if (addressEntity != null) {
      print('noooooooooooot');
      String addressJson = jsonEncode(addressEntity?.toJson());
      sp.putString('userAddress', addressJson);
    }
  }

  static removeAll() async {
    var sp = await SpUtil.getInstance();
    sp.remove('');
    sp.remove('accessToken');
    sp.remove('user_Id');
    sp.remove('shopId');
    sp.remove('userType');
    sp.remove('cityId');
    sp.remove('points');
    sp.remove('status');
    sp.remove('gender');
    sp.remove('fullName');
    sp.remove('provider');
    sp.remove('countryCode');
    sp.remove('coverPhoto');
    sp.remove('first_name');
    sp.remove('birthday');
    sp.remove('surname');
    sp.remove('emailAddress');
    sp.remove('phoneNumber');
    sp.remove('imageUrl');
    sp.remove('code');
    sp.remove('qrCode');
    sp.remove('userName');
    sp.remove('isEmailConfirmed');
    sp.remove('isPhoneNumberConfirmed');
    sp.remove('userAddress');
  }

  static saveForLogout(
      {required String devicedId,
      required int devicedType,
      required double lat,
      required double long,
      required int id}) async {
    var sp = await SpUtil.getInstance();
    sp.putString('devicedId', devicedId);
    sp.putInt('devicedType', devicedType);
    sp.putDouble('lat', lat);
    sp.putDouble('long', long);
    sp.putInt('userIdNumber', id);
  }

  static convertDateformatToEnglish(String dateTime) {
    var formatter = DateFormat("yyyy-MM-dd", "en_US");
    DateTime formatedDate = formatter.parse(dateTime);
    return formatedDate.toString();
  }
}
