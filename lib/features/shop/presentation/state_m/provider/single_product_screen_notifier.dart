import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/provider/cart.dart';
import 'package:starter_application/core/params/id_param.dart';
import 'package:starter_application/features/shop/data/model/request/get_slider_images_param.dart';
import 'package:starter_application/features/shop/data/model/request/productItem_param.dart';
import 'package:starter_application/features/shop/data/model/request/review_param.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/domain/entity/reviews_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_product_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class SingleProductScreenNotifier extends ScreenNotifier {
  SingleProductScreenNotifier(this.param);

  /// Fields
  late BuildContext context;
  final storCubit = ShopCubit();
  final sliderCubit = ShopCubit();
  final followStoreCubit = ShopCubit();
  final SingleProductScreenParam param;
  int? Id;
  ProductItemEntity? _productItem;
  int productsCartCount = 0;
  ReviewsEntity? reviewsproductItem;
  List<ProductItemEntity> relatedProducts = [];
  final cart = AppConfig().appContext.read<Cart>();
  double price = 0.0;
  int _selectedColor = 0;
  int _selectedSize = -1;

  int _iSFavorite = 0;

  /// Getters and Setters
  int get selectedColorIndex => this._selectedColor;

  set selectedColorIndex(int value) {
    this._selectedColor = value;
    notifyListeners();
  }

  int get selectedSizeIndex => this._selectedSize;

  set selectedSizeIndex(int value) {
    this._selectedSize = value;
    notifyListeners();
  }

  int get selectFavorite => this._iSFavorite;

  set selectFavorite(int value) {
    this._iSFavorite = value;
    notifyListeners();
  }

  ProductItemEntity? get productItem => this._productItem;

  set productItem(ProductItemEntity? value) {
    this._productItem = value;
    notifyListeners();
  }

  /// Methods

  onSelectColor(int index) {
    print(index);
    _selectedColor = index;
    _selectedSize = 2;
    notifyListeners();
  }

  onSelectSize(int index, ProductItemEntity item) {
    print(index);
    _selectedColor = index;
    price = item.combinations![index].price!;
    notifyListeners();
  }

  onFavorite(int index, bool favorite) {
    print(favorite);
    relatedProducts[index].isFavorite = favorite;
    notifyListeners();
  }

  onStoreTap() {
    // Nav.to(SingleStorePage.routeName);
  }

  void getProductItem() {
    storCubit.getProductItem(
        ProductItemParam(Id: Id), ReviewParam(RefType: 1, RefId: Id));
  }

  void onFollowUnFollowStoreTap() {
    if (!(productItem?.shop?.isFollowed ?? false))
      followStoreCubit.followShop(
        IdParam(id: productItem?.shop?.id ?? -1),
      );
    else {
      followStoreCubit.unFollowShop(
        IdParam(id: productItem?.shop?.id ?? -1),
      );
    }
  }

  @override
  void closeNotifier() {
    followStoreCubit.close();
    storCubit.close();
    sliderCubit.close();
    this.dispose();
  }

  onIsFavoriteChanged(bool isFavorite) {}

  void getSliderImages() {
    sliderCubit.getSliderImages(
      GetSliderImagesParam(
        productId: Id,
      ),
    );
  }
}
