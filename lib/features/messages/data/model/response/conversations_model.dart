import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/messages/domain/entity/conversations_entity.dart';

import 'conversation_model.dart';

class ConversationsModel extends BaseModel<ConversationsEntity> {
  ConversationsModel({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<ConversationModel> items;

  factory ConversationsModel.fromMap(Map<String, dynamic> json) =>
      ConversationsModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: json["items"] == null
            ? []
            : List<ConversationModel>.from(
                json["items"].map((x) => ConversationModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  ConversationsEntity toEntity() {
    return ConversationsEntity(
        items: items.map((e) => e.toEntity()).toList(), totalCount: totalCount);
  }
}
