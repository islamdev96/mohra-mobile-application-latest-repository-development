import 'package:starter_application/core/entities/address_entity.dart';
import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/core/entities/city_entity.dart';
import 'package:starter_application/features/moment/data/model/response/moment_model.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/personality/domain/entity/avatar_entity.dart';

class ClientEntity extends BaseEntity {
  ClientEntity({
    required this.name,
    required this.surname,
    required this.emailAddress,
    required this.phoneNumber,
     this.imageUrl,
    this.status,
    required this.fullName,
    this.creationTime,
    this.lastLoginDate,
    required this.code,
    this.city,
    required this.addresses,
    this.paymentsCount,
    this.id,
    this.gender,
    required this.qrCode,
    required this.countryCode,
    required this.hasAvatar,
     this.coverImage,
     this.userName,
     this.moments,
     this.avatarEntity,
     this.hasFriendRequest = false,
  });

  final String name;
  final String surname;
  final String emailAddress;
  final String phoneNumber;
  final String? imageUrl;
  final String? coverImage;
  final int? status;
  final String fullName;
  final DateTime? creationTime;
  final DateTime? lastLoginDate;
  final String code;
  final CityEntity? city;
  final List<AddressEntity> addresses;
  final int? paymentsCount;
  final int? id;
  final bool hasAvatar;
  final bool? hasFriendRequest;
  final int? gender;
  final String countryCode;
  final String qrCode;
  final String? userName;
  List<MomentItemEntity>? moments;
  final AvatarEntity? avatarEntity;


  @override
  List<Object?> get props => [];
}
