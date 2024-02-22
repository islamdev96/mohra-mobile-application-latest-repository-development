import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/shop/data/model/response/productItem_model.dart';
import 'package:starter_application/features/shop/domain/entity/prodcuts_list_entity.dart';

class FavoriteProductsListModel extends BaseModel<ProductsListEntity> {
  final List<ProductItemModel> items;
  FavoriteProductsListModel({
    required this.items,
  });

  factory FavoriteProductsListModel.fromMap(Map<String, dynamic> map) {
    return FavoriteProductsListModel(
      items: List<ProductItemModel>.from(
          map['items']?.map((x) => ProductItemModel.fromMap(x['product']))),
    );
  }

  @override
  ProductsListEntity toEntity() {
    return ProductsListEntity(
      items: this.items.toListEntity(),
    );
  }
}
