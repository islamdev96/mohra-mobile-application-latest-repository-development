import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/id_param.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/shop/data/model/request/get_single_shop_params.dart';
import 'package:starter_application/features/shop/data/model/request/get_slider_images_param.dart';
import 'package:starter_application/features/shop/data/model/request/shops_list_param.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';
import 'package:starter_application/features/shop/domain/usecase/get_shops_list_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/get_topProducts_usecase.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/navigation/nav.dart';
import '../../../../home/presentation/state_m/provider/app_main_screen_notifier.dart';

class ShopScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final storCubit = ShopCubit();
  final storCubitFavorite = ShopCubit();
  final storCubitStores = ShopCubit();
  final RefreshController momentsRefreshController = RefreshController();
  final RefreshController homeShopController = RefreshController();
  List<ShopEntity> _shops = [];
  List<ProductItemEntity> _products = [];
  String? search;
  bool isLoading = true;

  /// Getters and Setters
  List<ShopEntity> get shops => this._shops;

  List<ProductItemEntity> get products => this._products;

  set products(List<ProductItemEntity> value) => this._products = value;

  //TODO Test
  void getHomeStore() {
    storCubit.getStore(
      NoParams(),
      ShopsListParam(
          sorting: Translation.current.top,
          skipCount: 0,
          maxResultCount: 10,
          isActive: true),
      GetSliderImagesParam(),
    );
  }

  void onShopsItemsFetched(List<ShopEntity> items, int nextUnit) {
    _shops = items;
    notifyListeners();
  }

  void shopsLoaded(ShopsListEntity momentEntity) {
    _shops = momentEntity.items!;
    notifyListeners();
  }

  void loading(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<Result<AppErrors, List<ShopEntity>>> getShopsItems(int unit) async {
    final result = await getIt<GetShopsListUsecase>()(ShopsListParam(
        skipCount: unit * 10,
        maxResultCount: 10,
        isActive: true,
        keyword: search));

    return Result<AppErrors, List<ShopEntity>>(
        data: result.data?.items, error: result.error);
  }

  Future<Result<AppErrors, List<ProductItemEntity>>> getProducts(
      int unit) async {
    final result = await getIt<GetTopProductsUsecase>()(ShopsListParam(
        sorting: Translation.current.top,
        skipCount: unit * 10,
        maxResultCount: 10,
        isActive: true));

    return Result<AppErrors, List<ProductItemEntity>>(
        data: result.data?.items, error: result.error);
  }

  void onProductsFetched(List<ProductItemEntity> items, int nextUnit) {
    _products = items;
    notifyListeners();
  }

  void addToFavorite(id) {
    storCubitFavorite.addToFavorite(IdParam(id: id));
  }

  void removeFromFavorite(id) {
    storCubitFavorite.removeFromFavorite(IdParam(id: id));
  }

  void getSingleStore(id) {
    storCubit.getSingleShop(SingleShopParams(id: id));
  }

  void getStores() {
    storCubitStores.getShops(ShopsListParam(
        isActive: true, maxResultCount: 10, skipCount: 0, keyword: search));
  }

  void closeNotifier() {
    storCubit.close();
    this.dispose();
  }
}
