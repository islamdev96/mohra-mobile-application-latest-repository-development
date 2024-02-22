import 'package:starter_application/core/entities/base_entity.dart';

class TopCategoryEntity extends BaseEntity {
  TopCategoryEntity({
    this.items,
  });

  List<ItemTopCategoryEntity>? items;

  @override
  List<Object?> get props => [];
}

class ItemTopCategoryEntity extends BaseEntity {
  ItemTopCategoryEntity({
    this.imageUrl,
    this.name,
    this.id,
  });

  String? imageUrl;
  String? name;
  int? id;

  @override
  List<Object?> get props => [];
}
