import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:starter_application/core/common/price_utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/shop/domain/entity/shipping_addresses_list_entity.dart';
import 'package:starter_application/generated/l10n.dart';

class Cart extends ChangeNotifier {
  /// ------- Variables -------

  List<CartProduct> _products = [];
  int? discount;

  /// ------- Getters -------

  bool get isValidCart => productsCount > 0 && isValidQuantity;

  bool get isValidQuantity => _products.fold(true,
      (previousValue, element) => previousValue && (element.quantity > 0));


  ShippingAddressEntity? _shippingAddress;
  ShippingAddressEntity? get shippingAddress => this._shippingAddress;
  void set shippingAddress(ShippingAddressEntity? shippingAddressEntity) => this._shippingAddress = shippingAddressEntity;

  bool get isAddressSelected => _shippingAddress != null;

  /// The cost of all products without applying discount/coupon
  double get totalCostWithoutDiscount => calculateProductsCost(_products);

  /// The final cost after applying discount/coupon if exist
  double get totalCost => totalCostWithoutDiscount - discountValue;

  double get discountValue => PriceUtils.calculateDiscountedCost(
      totalCostWithoutDiscount, discount ?? 0);

  double get formattedTotalCost => PriceUtils.getFormattedPrice(totalCost);

  double get formattedTotalCostWithoutDiscount =>
      PriceUtils.getFormattedPrice(totalCostWithoutDiscount);

  String get formattedDiscountValue =>
      "${PriceUtils.getFormattedPrice(-discountValue)}";

  /// Products count
  int get productsCount => products.length;

  int get totalQuantity => products.fold(
      0, (previousValue, element) => previousValue + element.quantity);

  List<CartProduct> get products => _products;

  List<CartStore> get stores {
    List<CartStore> tempStores = [];
    for (int i = 0; i < productsCount; i++) {
      final product = _products[i];
      if (!tempStores.contains(product.store)) {
        tempStores.add(product.store);
        notifyListeners();
      }
    }
    return tempStores;
  }

  /// ------- Methods -------
  double calculateProductsCost(List<CartProduct> vProducts) {
    return vProducts.fold(
        0,
        (previousValue, element) =>
            (previousValue) + (element.price * element.quantity));
  }

  Future<void> init() async {
    _products = await getProductsFromSP();
  }

  /// Get the cart products from shared preference
  Future<List<CartProduct>> getProductsFromSP() async {
    final sp = await SpUtil.instance;
    final productsMapsList = sp.getStringList(AppConstants.KEY_CART) ?? [];
    return productsMapsList.map((e) => CartProduct.fromJson(e)).toList();
  }

  /// Store the cart products in shared preference
  Future<void> storeProductsInSP() async {
    final sp = await SpUtil.instance;
    await sp.putStringList(
        AppConstants.KEY_CART, _products.map((e) => e.toJson()).toList());
  }


  int getIDProduct(int id){
    return _products.indexWhere((op) => op.productId == id);
  }
  /// This method add new product to the cart
  Future<bool> addProduct(
    CartProduct product, {
    bool showMessages = false,
  }) async {
    bool isNotUpdate = false;
    int oldProductIndex = _products.indexWhere((op) => op == product);

    /// If adding new product
    if (oldProductIndex == -1) {
      isNotUpdate = true;
      _products.add(product);
      if (showMessages)
        showSnackbar(Translation.current.successfully_added_to_cart);
      notifyListeners();
      await storeProductsInSP();
    }

    /// If updating existing product quantity
    else {
      bool isContain = false;
      _products.forEach((element) {
        if (element.price == product.price &&
            product.productId == element.productId) {
          isContain = true;
        }
      });
      // _products.forEach((element) {
      //   if (element.price == product.price &&
      //       product.productId == element.productId) {
      //     isContain = true;
      //   }
      int cartProductFound =  _products.indexWhere((element) => (element.price == product.price && product.productId == element.productId),);
      int cartProductNotFound =  _products.indexWhere((element) => (element.price != product.price && product.productId == element.productId && !isContain),);
      if(cartProductFound != -1)await{
        isNotUpdate = await updateProduct(
          _products[oldProductIndex].productId,
          product.price,
          product.quantity,
          showMessages: showMessages,
          keepPrevQuantity: true,
        ),
      };
      if(cartProductNotFound != -1){
        isNotUpdate = true;
        _products.add(product);
        notifyListeners();
        await storeProductsInSP();
      }
      // _products.forEach((element) async {
      //   if (element.price == product.price &&
      //       product.productId == element.productId) {
      //     isNotUpdate = await updateProduct(
      //       _products[oldProductIndex].productId,
      //       product.price,
      //       product.quantity,
      //       showMessages: showMessages,
      //       keepPrevQuantity: true,
      //     );
      //   }
      //   if (element.price != product.price &&
      //       product.productId == element.productId &&
      //       !isContain) {
      //     isNotUpdate = true;
      //     _products.add(product);
      //     notifyListeners();
      //     await storeProductsInSP();
      //   }
      // });
    }
      return isNotUpdate;
  }

  /// This method update existing product
  Future<bool> updateProduct(
    int id,
    double price,
    int quantity, {
    bool keepPrevQuantity = false,
    bool showMessages = true,
  }) async {
    final productIndex = _products.indexWhere(
        (element) => element.productId == id && element.price == price);
    if (productIndex == -1) return true;
    final product = _products[productIndex];
    if((quantity + (keepPrevQuantity ? product.quantity : 0)) > product.allQuantity) {
      return false;
    }else {
      if ((quantity + (keepPrevQuantity ? product.quantity : 0)) <= product.allQuantity)
        product.quantity = quantity + (keepPrevQuantity ? product.quantity : 0);
      if (showMessages)
        showSnackbar(Translation.current.successfully_added_to_cart);
      await storeProductsInSP();
      notifyListeners();
      return true;
    }
  }

  /// This method delete existing product
  Future<void> removeProduct(int id, double price) async {
    final productIndex = _products.indexWhere(
        (element) => element.productId == id && price == element.price);
    if (productIndex == -1) return;
    _products.removeAt(productIndex);
    notifyListeners();
    await storeProductsInSP();
  }

  Future<void> addNoteToProduct(String note, int id) async {
    final productIndex =
        _products.indexWhere((element) => element.productId == id);
    if (productIndex == -1) return;
    final product = _products[productIndex];
    product.extraInformation = note;
    notifyListeners();
    await storeProductsInSP();
  }

  /// Remove all products from the cart
  Future<void> clear() async {
    _products.clear();
    notifyListeners();
    await storeProductsInSP();
  }

  List<CartProduct> getStoreProducts(CartStore store) {
    return _products.where((element) => element.store == store).toList();
  }

  double getStoreTotalCost(CartStore store) {
    final totalProductsCost = calculateProductsCost(getStoreProducts(store));
    return totalProductsCost -
        PriceUtils.calculateDiscountedCost(totalProductsCost, discount ?? 0);
  }
}

class CartStore {
  final int shopId;
  final String shopName;
  final String shopImage;
  final int followersCount;

  CartStore({
    required this.shopId,
    required this.shopName,
    required this.shopImage,
    required this.followersCount,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartStore && other.shopId == shopId;
  }

  @override
  int get hashCode => shopId.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'shopId': shopId,
      'shopName': shopName,
      'shopImage': shopImage,
      'followersCount': followersCount
    };
  }

  factory CartStore.fromMap(Map<String, dynamic> map) {
    return CartStore(
      shopId: map['shopId'],
      shopName: map['shopName'],
      shopImage: map['shopImage'],
      followersCount: map['followersCount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartStore.fromJson(String source) =>
      CartStore.fromMap(json.decode(source));
}

class CartProduct {
  CartProduct({
    required this.productId,
    required this.productCombinationId,
    required this.extraInformation,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.store,
    required this.quantity,
    required this.allQuantity,
  });

  final int productId;
  final int productCombinationId;
  final String productName;
  final String productImage;
  String extraInformation;
  final CartStore store;
  final double price;

  int quantity;
  int allQuantity;

  /// To products are equal if they have the same id and the same shop id
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartProduct &&
        other.productId == productId &&
        other.store == store;
  }

  @override
  int get hashCode => productId.hashCode ^ store.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      "productCombinationId": productCombinationId,
      'extraInformation': extraInformation,
      'quantity': quantity,
      'store': store.toMap(),
    };
  }

  factory CartProduct.fromMap(Map<String, dynamic> map) {
    return CartProduct(
      productId: map['productId'],
      productName: map['productName'],
      productImage: map['productImage'],
      productCombinationId: map['productCombinationId'],
      price: map['price']?.toDouble(),
      quantity: map['quantity'],
      extraInformation: map['extraInformation'],
      allQuantity: map['allQuantity'],
      store: CartStore.fromMap(map['store']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartProduct.fromJson(String source) =>
      CartProduct.fromMap(json.decode(source));
}
