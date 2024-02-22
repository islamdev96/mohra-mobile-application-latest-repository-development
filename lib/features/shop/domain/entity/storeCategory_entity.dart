import 'package:starter_application/core/entities/base_entity.dart';

class StoreCategoryEntity extends BaseEntity {
  StoreCategoryEntity({
    this.items,
  });

  List<ItemStoreCategoryEntity>? items;

  @override
  List<Object?> get props => [];
}

class ItemStoreCategoryEntity extends BaseEntity {
  ItemStoreCategoryEntity({
    this.imageUrl,
    this.classifications,
    this.name,
    this.id,
    this.order,
  });

  String? imageUrl;
  List<SupCategoryEntity>? classifications;
  String? name;
  int? id;
  int? order;

  @override
  List<Object?> get props => [];
}

class SupCategoryEntity extends BaseEntity {
  SupCategoryEntity({
    this.id,
    this.imageUrl,
    this.name,
    this.isActive,
  });

  int? id;
  String? imageUrl;
  String? name;
  bool? isActive;

  @override
  List<Object?> get props => [];
}
