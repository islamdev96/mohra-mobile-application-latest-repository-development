import 'package:flutter/cupertino.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';

class ProductFavorite extends ChangeNotifier {
  /// Variable
  late List<ProductItemEntity> _products;

  /// Getters
  List<ProductItemEntity> get products => _products;
  set products(List<ProductItemEntity> value) {
    _products = value;
  }

  /// Methods
  Future<void> add(ProductItemEntity product) async {
    _products.add(product);
    notifyListeners();
  }

  Future<void> remove(ProductItemEntity product) async {
    _products.removeWhere((w) => w.id == product.id);
    notifyListeners();
  }

  Future<void> clearGuestWishList() async {
    _products.clear();
    notifyListeners();
  }

  // bool isInFavorite(int id) {
  //   return _products.any((w) => w.id == id);
  // }
}
