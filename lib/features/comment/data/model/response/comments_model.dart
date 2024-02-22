import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/comment/data/model/response/comment_model.dart';
import 'package:starter_application/features/comment/domain/entity/comments_entity.dart';

class CommentsModel extends BaseModel<CommentsEntity> {
  CommentsModel({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<CommentModel> items;

  factory CommentsModel.fromMap(Map<String, dynamic> json) => CommentsModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: json["items"] == null
            ? []
            : List<CommentModel>.from(
                json["items"].map((x) => CommentModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  CommentsEntity toEntity() {
    return CommentsEntity(items: items.map((e) => e.toEntity()).toList());
  }
}
