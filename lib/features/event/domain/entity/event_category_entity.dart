import 'package:starter_application/core/entities/base_entity.dart';

class EventCategoryEntity extends BaseEntity {
  EventCategoryEntity({
    required this.isActive,
    required this.arName,
    required this.enName,
    required this.name,
    this.id,
  });

  final bool isActive;
  final String arName;
  final String enName;
  final String name;
  final int? id;

  @override
  List<Object?> get props => [];
}
