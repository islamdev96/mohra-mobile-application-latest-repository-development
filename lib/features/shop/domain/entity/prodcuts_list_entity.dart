import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';

class ProductsListEntity extends BaseEntity {
  ProductsListEntity({
    this.items,
  });

  List<ProductItemEntity>? items;

  @override
  List<Object?> get props => [];
}

class ShopTopProductsEntity extends BaseEntity {
  ShopTopProductsEntity({
    required this.id,
    required this.logoUrl,
    required this.coverUrl,
    required this.name,
    required this.description,
  });

  int? id;
  String? logoUrl;
  String? coverUrl;
  String? name;
  String? description;

  @override
  List<Object?> get props => [];
}
