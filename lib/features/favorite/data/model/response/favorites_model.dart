import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/favorite/domain/entity/favorites_entity.dart';

import 'favorite_model.dart';

class FavoritesModel extends BaseModel<FavoritesEntity> {
  FavoritesModel({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<FavoriteModel> items;

  factory FavoritesModel.fromMap(Map<String, dynamic> json) => FavoritesModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: json["items"] == null
            ? []
            : List<FavoriteModel>.from(
                json["items"].map((x) => FavoriteModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  FavoritesEntity toEntity() {
    return FavoritesEntity(
        items: items.map((e) => e.toEntity()).toList(), totalCount: totalCount);
  }
}
