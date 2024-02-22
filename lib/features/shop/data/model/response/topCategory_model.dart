import 'dart:convert';
import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/shop/domain/entity/topCategory_entity.dart';
import '/core/common/extensions/base_model_list_extension.dart';

TopCategoryModel topCategoryModelFromMap(String str) =>
    TopCategoryModel.fromMap(json.decode(str));

String topCategoryModelToMap(TopCategoryModel data) =>
    json.encode(data.toMap());

class TopCategoryModel extends BaseModel<TopCategoryEntity> {
  TopCategoryModel({
    this.items,
  });

  List<ItemTopCategoryModel>? items;

  factory TopCategoryModel.fromMap(Map<String, dynamic> json) =>
      TopCategoryModel(
        items: json["items"].isNotEmpty
            ? List<ItemTopCategoryModel>.from(
                json["items"].map((x) => ItemTopCategoryModel.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "items": List<dynamic>.from(items!.map((x) => x.toMap())),
      };

  @override
  TopCategoryEntity toEntity() {
    return TopCategoryEntity(items: items?.toListEntity());
  }
}

class ItemTopCategoryModel extends BaseModel<ItemTopCategoryEntity> {
  ItemTopCategoryModel({
    this.imageUrl,
    this.name,
    this.id,
  });

  String? imageUrl;
  String? name;
  int? id;

  factory ItemTopCategoryModel.fromMap(Map<String, dynamic> json) =>
      ItemTopCategoryModel(
        imageUrl: stringV(json["imageUrl"]),
        name: stringV(json["name"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        "name": name,
        "id": id,
      };

  @override
  ItemTopCategoryEntity toEntity() {
    return ItemTopCategoryEntity(id: id, imageUrl: imageUrl, name: name);
  }
}
