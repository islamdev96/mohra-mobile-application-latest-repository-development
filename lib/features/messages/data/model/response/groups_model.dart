import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/messages/data/model/response/group_model.dart';
import 'package:starter_application/features/messages/domain/entity/groups_entity.dart';

class GroupsModel extends BaseModel<GroupsEntity> {
  GroupsModel({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<GroupModel> items;

  factory GroupsModel.fromMap(Map<String, dynamic> json) => GroupsModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: json["items"] == null
            ? []
            : List<GroupModel>.from(
                json["items"].map((x) => GroupModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  GroupsEntity toEntity() {
    return GroupsEntity(
        items: items.map((e) => e.toEntity()).toList(), totalCount: totalCount);
  }
}
