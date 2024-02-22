import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/health/domain/entity/dishes_list_entity.dart';


class FavortieDishListEntity extends BaseEntity {
  FavortieDishListEntity({
    required this.totalCount,
    required this.items,
  });

  int totalCount;
  List<FavoriteDishItemEntity> items;

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class FavoriteDishItemEntity extends BaseEntity {
  FavoriteDishItemEntity({
    required this.dishId,
    required this.dish,
    required this.id,
    required this.clientId,
  });

  int dishId;
  DishEntity dish;
  int id;
  int clientId;

  @override
  // TODO: implement props
  List<Object?> get props => [];


}