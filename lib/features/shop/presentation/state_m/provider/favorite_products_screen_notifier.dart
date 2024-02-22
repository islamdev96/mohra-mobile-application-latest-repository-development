import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/singleStore_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/favorite/data/model/request/get_favorites_params.dart';
import 'package:starter_application/features/favorite/domain/entity/favorite_entity.dart';
import 'package:starter_application/features/messages/domain/entity/message_entity.dart';
import 'package:starter_application/features/shop/domain/entity/prodcuts_list_entity.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/domain/usecase/get_favorite_prodcuts_usecse.dart';
import 'package:starter_application/features/shop/domain/usecase/get_products_usecase.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_product_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/product_favorite.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class FavoriteProductsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final ShopCubit favoriteProductsCubit = ShopCubit();
  final RefreshController momentsRefreshController = RefreshController();
  List<ProductItemEntity> _favorites = [];
  bool isLoading = true;

  /// Getters and Setters
  List<ProductItemEntity> get favorites => this._favorites;

  set favorites(List<ProductItemEntity> value) => this._favorites = value;

  /// Methods

  @override
  void closeNotifier() {
    favoriteProductsCubit.close();
    this.dispose();
  }

  void removeFromFavorite(int id) {
    _favorites.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void getFavoritesProducts() {
    favoriteProductsCubit.getProducts(
      GetProductsParam(
          SkipCount: 0, MaxResultCount: 10, IncludeOnlyFavorite: true),
    );
  }

  void loading(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<Result<AppErrors, List<ProductItemEntity>>> getMomentsItems(
      int unit) async {
    final result = await getIt<GetProductsListUseCase>()(
      GetProductsParam(
          SkipCount: unit * 10, MaxResultCount: 10, IncludeOnlyFavorite: true),
    );

    return Result<AppErrors, List<ProductItemEntity>>(
        data: result.data?.items, error: result.error);
  }

  void onMomentsItemsFetched(List<ProductItemEntity> items, int nextUnit) {
    _favorites = items;
    notifyListeners();
  }

  void NotificationsLoaded(ProductsListEntity momentEntity) {
    _favorites = momentEntity.items!;
    notifyListeners();
  }

  onProductTap(ProductItemEntity product) {
    Nav.to(
      SingleProductScreen.routeName,
      arguments: SingleProductScreenParam(
        productId: product.id!,
      ),
    ).then((value) {
      getFavoritesProducts();
    });
  }
}
