import 'package:starter_application/core/entities/base_entity.dart';

import 'favorite_entity.dart';

class FavoritesEntity extends BaseEntity {
  FavoritesEntity({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<FavoriteEntity> items;

  @override
  List<Object?> get props => [];
}
