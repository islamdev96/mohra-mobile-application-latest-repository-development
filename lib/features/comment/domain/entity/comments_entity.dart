import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/comment/domain/entity/comment_entity.dart';

class CommentsEntity extends BaseEntity {
  CommentsEntity({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<CommentEntity> items;

  @override
  List<Object?> get props => [];
}
