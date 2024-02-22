import 'package:starter_application/core/entities/base_entity.dart';

class InteractionClientEntity extends BaseEntity {
  InteractionClientEntity({
    required this.imageUrl,
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    this.id,
    this.points,

  });

  final String? imageUrl;
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final int? id;
  final int? points;
  @override
  List<Object?> get props => [];
}
