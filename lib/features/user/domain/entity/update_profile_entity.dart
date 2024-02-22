import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/account/domain/entity/login_entity.dart';

class UpdateProfileEntity  extends BaseEntity{
  UpdateProfileEntity({
    required this.name,
    required this.surname,
    required this.emailAddress,
    required this.phoneNumber,
    required this.imageUrl,
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
    required this.birthDate,
    required this.userName,
    required this.latitude,
    required this.longitude,
    required this.cover,
    required this.id,
    required this.avatarMonth,
  });

  String? name;
  String? surname;
  String? emailAddress;
  String? phoneNumber;
  String? imageUrl;
  bool? hasAvatar;
  int? gender;
  int? status;
  String? fullName;
  DateTime? creationTime;
  DateTime? lastLoginDate;
  String? code;
  String? countryCode;
  dynamic city;
  List<AddressEntity>? addresses;
  int? paymentsCount;
  String? qrCode;
  DateTime? birthDate;
  String? userName;
  String? cover;
  double? longitude;
  double? latitude;
  int id;
  int avatarMonth;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  String toString() {
    return 'UpdateProfileEntity{name: $name, surname: $surname, emailAddress: $emailAddress, phoneNumber: $phoneNumber, imageUrl: $imageUrl, hasAvatar: $hasAvatar, gender: $gender, status: $status, fullName: $fullName, creationTime: $creationTime, lastLoginDate: $lastLoginDate, code: $code, countryCode: $countryCode, city: $city, addresses: $addresses, paymentsCount: $paymentsCount, qrCode: $qrCode, birthDate: $birthDate, userName: $userName, cover: $cover, longitude: $longitude, latitude: $latitude, id: $id}';
  }
}