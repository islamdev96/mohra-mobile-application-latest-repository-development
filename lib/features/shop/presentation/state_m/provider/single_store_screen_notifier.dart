import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/id_param.dart';
import 'package:starter_application/core/params/singleStore_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/shop/data/model/request/get_shop_category_params.dart';
import 'package:starter_application/features/shop/data/model/request/review_param.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/domain/entity/reviews_entity.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';
import 'package:starter_application/features/shop/domain/entity/storeCategory_entity.dart';
import 'package:starter_application/features/shop/domain/usecase/get_products_usecase.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

class SingleStoreNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final storCubit = ShopCubit();
  final followStoreCubit = ShopCubit();
  final productCubit = ShopCubit();

  final RefreshController refreshController1 = RefreshController();

  final RefreshController refreshController2 = RefreshController();

  late ShopEntity _shop;
  late StoreCategoryEntity storeCategoryEntity;
  int selectedCategory = -1;
  int SkipCount = 0;
  int MaxResultCount = 10;
  bool isLoading = true;
  int SkipCountProducts = 0;

  List<ProductItemEntity> topProducts = [];
  List<ProductItemEntity> Products =[];

  List<ItemReviewsEntity> ReviewStore = [];

  /// Getters and setters
  ShopEntity get shop => this._shop;

  set shop(ShopEntity shop) {
    this._shop = shop;
    notifyListeners();
  }

  void getHomeStore() {
    topProducts.clear();
    Products.clear();
    ReviewStore.clear();
    SkipCountProducts = 0;
    SkipCount = 0;
    storCubit.getSingleStore(
        GetProductsParam(
          ShopId: shop.id,
          MaxResultCount: MaxResultCount,
          SkipCount: SkipCount,
          Sorting: 'TopSelling',
        ),
        GetProductsParam(
          ShopId: shop.id,
          MaxResultCount: MaxResultCount,
          SkipCount: SkipCountProducts,
        ),
        ReviewParam(RefType: 0, RefId: shop.id));
    notifyListeners();
  }
  void getTopProducts() {
    storCubit.getProducts(GetProductsParam(
      ShopId: shop.id,
      MaxResultCount: MaxResultCount,
      SkipCount: SkipCount,
      Sorting: 'TopSelling',
    ),);
  }
  void loading(value) {
    isLoading = value;
    notifyListeners();
  }

  void onHomeTabItemsFetched(List<ProductItemEntity> items, int nextUnit) {
    topProducts = items;
    notifyListeners();
  }
  void onProductItemsFetched(List<ProductItemEntity> items, int nextUnit) {
    Products = items;
    notifyListeners();
  }

  Future<Result<AppErrors, List<ProductItemEntity>>> getProductTopItems(
      int unit) async {
    final result = await getIt<GetProductsListUseCase>()(GetProductsParam(
      ShopId: shop.id,
      MaxResultCount: 10,
      SkipCount:unit * SkipCount,
      Sorting: 'TopSelling',
    ));

    return Result<AppErrors, List<ProductItemEntity>>(
        data: result.data?.items, error: result.error);
  }
  Future<Result<AppErrors, List<ProductItemEntity>>> getProductItems(
      int unit) async {
    final result = await getIt<GetProductsListUseCase>()(GetProductsParam(
      ShopId: shop.id,
      SkipCount: unit * 10,
      MaxResultCount: 10,
      Sorting: '',
      categoryId:  selectedCategory == -1 ? null : selectedCategory,
    ));

    return Result<AppErrors, List<ProductItemEntity>>(
        data: result.data?.items, error: result.error);
  }

  void onDataFetchedTop(List<ProductItemEntity> items, int nextUnit) {
    topProducts = items;
    notifyListeners();
  }

  void onDataFetched(List<ProductItemEntity> items, int nextUnit) {
    Products = items;
    notifyListeners();
  }

  void closeNotifier() {
    storCubit.close();
    followStoreCubit.close();
    this.dispose();
  }

  void onFollowUnFollowStoreTap() {
    if (!(shop.isFollowed))
      followStoreCubit.followShop(
        IdParam(id: shop.id ?? -1),
      );
    else {
      followStoreCubit.unFollowShop(
        IdParam(id: shop.id ?? -1),
      );
    }
  }

  // getShopCategories(){
  //   storCubit.getStorecategorys(GetShopCategoryParams(id: _shop.id));
  // }

  // onGetCategoriesDone(StoreCategoryEntity storeCategoryEntity){
  //   ItemStoreCategoryEntity allItem = ItemStoreCategoryEntity(
  //     id: -1,
  //     name: Translation.current.all
  //   );
  //   this.storeCategoryEntity = storeCategoryEntity;
  //   this.storeCategoryEntity.items!.insert(0,allItem);
  //   print(storeCategoryEntity.items!.length);
  // }
  //
  // changeSelectedCategory(int index){
  //   print(index);
  //   if(index == 0 ){
  //     selectedCategory = -1;
  //   }
  //   else{
  //     selectedCategory = storeCategoryEntity.items![index].id!;
  //   }
  //     SkipCountProducts = 0;
  //     this.returnData(0);
  //     notifyListeners();
  //
  // }




}
