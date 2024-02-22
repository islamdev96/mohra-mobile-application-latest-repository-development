import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/messages/domain/entity/group_entity.dart';

class GroupsEntity extends BaseEntity {
  GroupsEntity({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<GroupEntity> items;

  @override
  List<Object?> get props => [];
}
