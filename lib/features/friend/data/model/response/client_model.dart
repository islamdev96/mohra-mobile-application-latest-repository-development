import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/address_model.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/core/models/city_model.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/moment/data/model/response/moment_model.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/features/personality/data/model/response/get_my_avatar_response.dart';

class ClientModel extends BaseModel<ClientEntity> {
  ClientModel({
    required this.name,
    required this.surname,
    required this.emailAddress,
    required this.phoneNumber,
    required this.imageUrl,
    this.status,
    required this.fullName,
    this.creationTime,
    this.lastLoginDate,
    required this.code,
    this.city,
    required this.addresses,
    this.paymentsCount,
    this.id,
    required this.hasAvatar,
    this.gender,
    this.coverImage,
    this.userName,
    this.moments,
    this.hasFriendRequest  =false,
    required this.countryCode,
    required this.qrCode,
    required this.avatarModel,
  });

  final String name;
  final String surname;
  final String emailAddress;
  final String phoneNumber;
  final String imageUrl;
  final String? coverImage;
  final String? userName;
  final int? status;
  final String fullName;
  final DateTime? creationTime;
  final DateTime? lastLoginDate;
  final String code;
  final CityModel? city;
  final List<AddressModel> addresses;
  final int? paymentsCount;
  final int? id;
  final bool hasAvatar;
  final bool hasFriendRequest;
  final int? gender;
  final String countryCode;
  List<MomentItem>? moments;
  final String qrCode;
  final AvatarModel? avatarModel;

  factory ClientModel.fromMap(Map<String, dynamic> json) => ClientModel(
        name: stringV(json["name"]),
        surname: stringV(json["surname"]),
        emailAddress: stringV(json["emailAddress"]),
        phoneNumber: stringV(json["phoneNumber"]),
        imageUrl: stringV(json["imageUrl"]),
        status: json["status"] == null ? null : json["status"],
        fullName: stringV(json["fullName"]),
        creationTime: json["creationTime"] == null
            ? null
            : DateTime.parse(json["creationTime"]),
        lastLoginDate: json["lastLoginDate"] == null
            ? null
            : DateTime.parse(json["lastLoginDate"]),
        code: stringV(json["code"]),
        city: json["city"] == null ? null : CityModel.fromMap(json["city"]),
        addresses: json["addresses"] == null
            ? []
            : List<AddressModel>.from(
                json["addresses"].map((x) => AddressModel.fromMap(x))),
        paymentsCount:
            json["paymentsCount"] == null ? null : json["paymentsCount"],
        id: json["id"] == null ? null : json["id"],
        gender: json["gender"] == null ? null : json["gender"],
        coverImage: json["cover"] == null ? null : json["cover"],
        hasAvatar: boolV(json["hasAvatar"]),
      hasFriendRequest: boolV(json["hasFriendRequest"]),
        countryCode: stringV(json["countryCode"]),
        qrCode: stringV(json["qrCode"]),
        userName:  stringV(json["userName"]),
      avatarModel:json["avatar"] == null ? null:  AvatarModel.fromMap(json["avatar"]),
    moments: json['moments'] == null ? []
        : List<MomentItem>.from(
        json["moments"].map((x) => MomentItem.fromMap(x)))
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "surname": surname,
        "emailAddress": emailAddress,
        "phoneNumber": phoneNumber,
        "imageUrl": imageUrl,
        "status": status == null ? null : status,
        "fullName": fullName,
        "creationTime":
            creationTime == null ? null : creationTime?.toIso8601String(),
        "lastLoginDate":
            lastLoginDate == null ? null : lastLoginDate?.toIso8601String(),
        "code": code,
        "city": city == null ? null : city?.toMap(),
        "addresses": List<dynamic>.from(addresses.map((x) => x.toMap())),
        "paymentsCount": paymentsCount == null ? null : paymentsCount,
        "id": id == null ? null : id,
        "gender": gender == null ? null : gender,
        "hasAvatar": hasAvatar,
        "countryCode": countryCode,
        "qrCode": qrCode,
        "userName": userName,
        "hasFriendRequest": hasFriendRequest,
      };

  @override
  ClientEntity toEntity() {
    return ClientEntity(
      name: name,
      surname: surname,
      emailAddress: emailAddress,
      phoneNumber: phoneNumber,
      imageUrl: imageUrl,
      fullName: fullName,
      code: code,
      addresses: addresses.map((e) => e.toEntity()).toList(),
      city: city?.toEntity(),
      id: id,
      creationTime: creationTime,
      status: status,
      lastLoginDate: lastLoginDate,
      paymentsCount: paymentsCount,
      countryCode: countryCode,
      hasAvatar: hasAvatar,
      qrCode: qrCode,
      gender: gender,
      coverImage: coverImage,
      userName: userName,
      hasFriendRequest: hasFriendRequest,
      moments:  moments!.toListEntity(),
      avatarEntity: avatarModel == null ? null : avatarModel!.toEntity()

    );
  }
}

