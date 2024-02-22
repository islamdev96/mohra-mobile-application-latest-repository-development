import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/personality/domain/entity/avatar_entity.dart';

class EventClientEntity extends BaseEntity {
  EventClientEntity({
    required this.imageUrl,
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    this.points,
    this.avatar,
    this.id,
  });

  final String imageUrl;
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final int? points;
  final ClinetAvatarEntity? avatar;
  final int? id;

  @override
  List<Object?> get props => [
        id,
        name,avatar
      ];
}

class ClinetAvatarEntity extends BaseEntity {
  ClinetAvatarEntity({this.image,
    this.avatarUrl,
    this.arDescription,
    this.enDescription,
    this.description,
    this.gender,
    this.month,
    this.isActive,
    this.arName,
    this.enName,
    this.name,
    this.id});

  String? image;
  String? avatarUrl;
  String? arDescription;
  String? enDescription;
  String? description;
  int? gender;
  int? month;
  bool? isActive;
  String? arName;
  String? enName;
  String? name;
  int? id;

  @override
  List<Object?> get props => [
    id,
    name,
  ];
}
