import 'package:starter_application/core/entities/base_entity.dart';

class CommentClientEntity extends BaseEntity {
  CommentClientEntity({
    required this.imageUrl,
    required this.name,
    required this.fullName,
    required this.phoneNumber,
    required this.emailAddress,
    this.id,
  });

  final String imageUrl;
  final String name;
  final String fullName;
  final String phoneNumber;
  final String emailAddress;
  final int? id;

  @override
  List<Object?> get props => [];
}
