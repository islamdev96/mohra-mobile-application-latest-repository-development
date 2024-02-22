import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/friend/domain/entity/clients_entity.dart';

import 'client_model.dart';

class ClientsModel extends BaseModel<ClientsEntity> {
  ClientsModel({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<ClientModel> items;

  factory ClientsModel.fromMap(Map<String, dynamic> json) => ClientsModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: json["items"] == null
            ? []
            : List<ClientModel>.from(
                json["items"].map((x) => ClientModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  ClientsEntity toEntity() {
    return ClientsEntity(
        totalCount: totalCount, items: items.map((e) => e.toEntity()).toList());
  }
}
