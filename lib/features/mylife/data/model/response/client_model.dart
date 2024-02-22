import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/mylife/domain/entity/appointment_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/client_entity.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';

import '../../../../personality/data/model/response/get_my_avatar_response.dart';

class ClientModel extends BaseModel<ClientEntity> {
  final List<ClientItem> items;
  final int totalCount;

  ClientModel({
    required this.items,
    required this.totalCount,
  });

  factory ClientModel.fromMap(Map<String, dynamic> json) => ClientModel(
        items: json["items"] == null
            ? []
            : List<ClientItem>.from(
                json["items"].map((x) => ClientItem.fromMap(x))),
        totalCount: json['totalCount'],
      );

  @override
  ClientEntity toEntity() {
    return ClientEntity(
      items: items.toListEntity(),
      totalCount: totalCount,
    );
  }
}

class ClientItem extends BaseModel<ClientItemEntity> {
  String? value;
  String? text;
  String? imageUrl;
  AvatarModel? avatar;

  ClientItem({
    this.value,
    this.text,
    this.imageUrl,
    this.avatar,
  });

  factory ClientItem.fromMap(Map<String, dynamic> json) => ClientItem(
      value: json['value'],
      text: json['text'],
      imageUrl: json['imageUrl'],
      avatar:
          json['avatar'] != null ? AvatarModel.fromMap(json['avatar']) : null);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;

    return data;
  }

  @override
  ClientItemEntity toEntity() {
    return ClientItemEntity(
      value: value,
      text: text,
      avatar:avatar!=null? avatar!.toEntity():null,
      imageUrl: imageUrl,
    );
  }
}
