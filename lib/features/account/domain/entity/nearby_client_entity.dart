import 'package:starter_application/core/entities/base_entity.dart';

class NearbyClientEntity extends BaseEntity {
  NearbyClientEntity({
    required this.imageUrl,
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    this.points,
    this.id,
    required this.isFriend,
  });

  final String imageUrl;
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final int? points;
  final int? id;
  final bool isFriend;

  @override
  List<Object?> get props => [];
}
