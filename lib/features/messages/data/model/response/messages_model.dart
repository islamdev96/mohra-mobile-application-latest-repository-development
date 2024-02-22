import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/messages/domain/entity/messages_entity.dart';

import 'message_model.dart';

class MessagesModel extends BaseModel<MessagesEntity> {
  MessagesModel({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<MessageModel> items;

  factory MessagesModel.fromMap(Map<String, dynamic> json) => MessagesModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: json["items"] == null
            ? []
            : List<MessageModel>.from(
                json["items"].map((x) => MessageModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  MessagesEntity toEntity() {
    return MessagesEntity(
        items: items.map((e) => e.toEntity()).toList(), totalCount: totalCount);
  }
}
