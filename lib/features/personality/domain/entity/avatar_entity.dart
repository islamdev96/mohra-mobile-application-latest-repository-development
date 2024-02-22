import 'package:starter_application/core/entities/base_entity.dart';

class AvatarListEntity extends BaseEntity {
  AvatarListEntity({
    required this.myAvatar,
    required this.avatars,
  });

  AvatarEntity? myAvatar;
  List<AvatarEntity> avatars;

  @override
  // TODO: implement props
  List<Object?> get props => [];


}

class AvatarEntity extends BaseEntity {
  AvatarEntity({
    required this.image,
    required this.avatarUrl,
    required this.arDescription,
    required this.enDescription,
    required this.description,
    required this.gender,
    this.month,
    required this.isActive,
    required this.arName,
    required this.enName,
    required this.name,
    required this.id,
  });

  String? image;
  String? avatarUrl;
  String? arDescription;
  String? enDescription;
  String? description;
  int gender;
  int? month;
  bool isActive;
  String? arName;
  String? enName;
  String? name;
  int id;

  @override
  // TODO: implement props
  List<Object?> get props => [];

}
