import 'package:starter_application/core/entities/base_entity.dart';

class GetProfileEntity extends BaseEntity {
  GetProfileEntity({
    required this.name,
    required this.surname,
    required this.emailAddress,
    required this.phoneNumber,
    required this.imageUrl,
    required this.cover,
    required this.longitude,
    required this.latitude,
    required this.hasAvatar,
    required this.gender,
    required this.status,
    required this.fullName,
    required this.creationTime,
    required this.lastLoginDate,
    required this.code,
    required this.countryCode,
    required this.city,
    required this.addresses,
    required this.paymentsCount,
    required this.qrCode,
     this.birthDate,
    required this.userName,
    required this.personalityQuestions,
    required this.id,
    required this.points,
  });

  String name;
  String surname;
  String emailAddress;
  String phoneNumber;
  String? imageUrl;
  String? cover;
  double? longitude;
  double? latitude;
  bool hasAvatar;
  int gender;
  int status;
  String fullName;
  DateTime? creationTime;
  DateTime? lastLoginDate;
  String? code;
  String? countryCode;
  dynamic city;
  List<GetProfileAddressEntity> addresses;
  int paymentsCount;
  int points;
  String? qrCode;
  DateTime? birthDate;
  String userName;
  dynamic personalityQuestions;
  int id;

  @override
  // TODO: implement props
  List<Object?> get props => [];


}

class GetProfileAddressEntity extends BaseEntity {
  GetProfileAddressEntity({
    required this.cityId,
    required this.city,
    required this.street,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.id,
  });

  int cityId;
  String? city;
  String? street;
  String? description;
  double? latitude;
  double? longitude;
  int id;

  @override
  // TODO: implement props
  List<Object?> get props => [];

}