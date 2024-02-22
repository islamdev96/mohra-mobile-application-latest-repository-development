import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/provider/cart.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/params/id_param.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/params/singleStore_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/favorite/data/model/request/get_favorites_params.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/features/shop/data/model/request/add_edit_shipping_address_param.dart';
import 'package:starter_application/features/shop/data/model/request/check_coupon_param.dart';
import 'package:starter_application/features/shop/data/model/request/createReview_params.dart';
import 'package:starter_application/features/shop/data/model/request/create_order_params.dart';
import 'package:starter_application/features/shop/data/model/request/get_order_details_params.dart';
import 'package:starter_application/features/shop/data/model/request/get_shop_category_params.dart';
import 'package:starter_application/features/shop/data/model/request/get_single_shop_params.dart';
import 'package:starter_application/features/shop/data/model/request/get_slider_images_param.dart';
import 'package:starter_application/features/shop/data/model/request/image_params.dart';
import 'package:starter_application/features/shop/data/model/request/productItem_param.dart';
import 'package:starter_application/features/shop/data/model/request/review_param.dart';
import 'package:starter_application/features/shop/data/model/request/shops_list_param.dart';
import 'package:starter_application/features/shop/data/model/response/order_details_model.dart';
import 'package:starter_application/features/shop/data/model/response/orders_model.dart';
import 'package:starter_application/features/shop/domain/entity/check_coupon_entity.dart';
import 'package:starter_application/features/shop/domain/entity/prodcuts_list_entity.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/domain/entity/reviews_entity.dart';
import 'package:starter_application/features/shop/domain/entity/shipping_addresses_list_entity.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';
import 'package:starter_application/features/shop/domain/entity/slider_entity.dart';
import 'package:starter_application/features/shop/domain/entity/storeCategory_entity.dart';
import 'package:starter_application/features/shop/domain/entity/topCategory_entity.dart';
import 'package:starter_application/features/shop/domain/usecase/add_favorite_prodcut_usecse.dart';
import 'package:starter_application/features/shop/domain/usecase/check_coupon_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/create_order_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/create_reviewProduct_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/create_shipping_address_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/delete_shipping_address_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/follow_shop_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/get_all_orders_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/get_favorite_prodcuts_usecse.dart';
import 'package:starter_application/features/shop/domain/usecase/get_order_details_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/get_productItem_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/get_products_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/get_review_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/get_shipping_addresses_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/get_shops_list_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/get_single_shop_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/get_sliderImages_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/get_storecategory_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/get_topCategory_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/get_topProducts_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/remove_favorite_prodcut_usecse.dart';
import 'package:starter_application/features/shop/domain/usecase/un_follow_shop_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/update_shipping_address_usecase.dart';
import 'package:starter_application/features/shop/domain/usecase/upload_image_usecase.dart';

import '../../../../../core/errors/app_errors.dart';
import '../../../domain/usecase/check_if_create_order_usecase.dart';

part 'shop_cubit.freezed.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(const ShopState.shopInitState());

  void getStore(NoParams param, ShopsListParam paramStore,
      GetSliderImagesParam sliderParam) async {
    emit(const ShopState.shopLoadingState());

    final List<dynamic> results = await Future.wait([
      getIt<GetSliderImagesUsecase>()(sliderParam),
      getIt<GetTopCategoryUsecase>()(param),
      getIt<GetShopsListUsecase>()(paramStore),
      getIt<GetTopProductsUsecase>()(paramStore)
    ]);

    if (results[0].hasErrorOnly ||
        results[1].hasErrorOnly ||
        results[2].hasErrorOnly ||
        results[3].hasErrorOnly) {
      final error = results[0].hasErrorOnly
          ? results[0].error
          : results[1].hasErrorOnly
              ? results[1].error
              : results[2].hasErrorOnly
                  ? results[2].error
                  : results[3].error;
      emit(
        ShopState.shopErrorState(
            error!,
            () => this.getStore(
                  param,
                  paramStore,
                  sliderParam,
                )),
      );
    } else {
      emit(ShopState.homeStoreLodedState(results[0].data!, results[1].data!,
          results[2].data!, results[3].data!));
    }
  }

  void getStores(ShopsListParam paramStore) async {
    emit(const ShopState.shopLoadingState());

    final result = await getIt<GetShopsListUsecase>()(paramStore);
    result.pick(
      onData: (data) => emit(ShopState.shopsListLoaded(data)),
      onError: (error) => emit(
        ShopState.shopErrorState(error, () => this.getStores(paramStore)),
      ),
    );
  }

  void getSingleStore(GetProductsParam paramTop, GetProductsParam paramPro,
      ReviewParam paramreview) async {
    emit(const ShopState.shopLoadingState());

    final List<dynamic> results = await Future.wait([
      getIt<GetProductsListUseCase>()(paramTop),
      getIt<GetProductsListUseCase>()(paramPro),
      getIt<GetgetReviewUsecase>()(paramreview),
    ]);

    if (results[0].hasErrorOnly ||
        results[1].hasErrorOnly ||
        results[2].hasErrorOnly) {
      final error = results[0].hasErrorOnly
          ? results[0].error
          : results[1].hasErrorOnly
              ? results[1].error
              : results[2].error;
      emit(
        ShopState.shopErrorState(
            error!, () => this.getSingleStore(paramTop, paramPro, paramreview)),
      );
    } else {
      emit(ShopState.singleStoreLodedState(
          results[0].data!, results[1].data!, results[2].data!));
    }
  }

  void getProducts(GetProductsParam param) async {
    emit(const ShopState.shopLoadingState());

    final List<dynamic> results = await Future.wait([
      getIt<GetProductsListUseCase>()(param),
    ]);

    if (results[0].hasErrorOnly) {
      final error = results[0].error;
      emit(
        ShopState.shopErrorState(error!, () => this.getProducts(param)),
      );
    } else {
      print('dsdsdds');
      emit(ShopState.getProductsLoaded(results[0].data!));
    }
  }

  void getStorecategorys(GetShopCategoryParams param) async {
    emit(const ShopState.shopLoadingState());

    final result = await getIt<GetStorecategoryUsecase>()(param);
    result.pick(
      onData: (data) => emit(ShopState.storeCategoryLodedState(data)),
      onError: (error) => emit(
        ShopState.shopErrorState(error, () => this.getStorecategorys(param)),
      ),
    );
  }

  void getAllOrders(GetAllNotificationParam param) async {
    emit(const ShopState.getOrdersLoadingState());

    final result = await getIt<GetOrderssUseCase>()(param);
    result.pick(
      onData: (data) => emit(ShopState.getOrdersSuccess(data)),
      onError: (error) => emit(
        ShopState.getSingleStoreError(error, () => this.getAllOrders(param)),
      ),
    );
  }

  void getDetailsOfOrder(GetOrderDetailsParams param) async {
    emit(const ShopState.getDetailsOrderLoadingState());

    final result = await getIt<GetOrdersDetailsUseCase>()(param);
    result.pick(
      onData: (data) => emit(ShopState.getDetailsOrderSuccess(data)),
      onError: (error) => emit(
        ShopState.getSingleStoreError(
            error, () => this.getDetailsOfOrder(param)),
      ),
    );
  }

  void createOrder(CreateOrderParams param) async {
    emit(const ShopState.createOrderLoading());

    final result = await getIt<CreateOrderUseCase>()(param);
    result.pick(
      onData: (data) {
        Provider.of<Cart>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .shippingAddress = null;
        emit(const ShopState.createOrderSuccess());
      },
      onError: (error) => emit(
        ShopState.createOrderErrorState(error, () => this.createOrder(param)),
      ),
    );
  }

  void checkIfCanCreateOrder(CreateOrderParams param) async {
    emit(const ShopState.createOrderLoading());

    final result = await getIt<CheckIfCreateOrderUseCase>()(param);
    result.pick(
      onData: (data) => emit(const ShopState.checkIfCanCreateOrderSuccess()),
      onError: (error) => emit(
        ShopState.checkIfCanCreateOrderErrorState(
            error, () => this.createOrder(param)),
      ),
    );
  }

  void getProductItem(ProductItemParam param, ReviewParam paramreview) async {
    emit(const ShopState.shopLoadingState());
    int? IdSup;
    final List<dynamic> results = await Future.wait([
      getIt<GetProductItemUsecase>()(param),
      getIt<GetgetReviewUsecase>()(paramreview),
    ]);
    results[0].pick(
      onData: (data) {
        IdSup = data.classificationId!;
      },
      onError: (error) {
        emit(
          ShopState.shopErrorState(
              error, () => this.getProductItem(param, paramreview)),
        );
      },
    );

    if (results[0].hasErrorOnly || results[1].hasErrorOnly) {
      final error =
          results[0].hasErrorOnly ? results[0].error : results[1].error;
      emit(
        ShopState.shopErrorState(
            error, () => this.getProductItem(param, paramreview)),
      );
    } else {
      final result = await getIt<GetProductsListUseCase>()(GetProductsParam(
        MaxResultCount: 10,
        SkipCount: 0,
        Search: '',
        Sorting: '',
        supCategoryId: IdSup,
      ));
      result.pick(
        onData: (data) => emit(ShopState.productItemLodedState(
            results[0].data!, results[1].data!, data)),
        onError: (error) => emit(
          ShopState.shopErrorState(
              error, () => this.getProductItem(param, paramreview)),
        ),
      );
    }
  }

  Future<Result<AppErrors, List<ProductItemEntity>>> getPagination(
      GetProductsParam param) async {
    final result = await getIt<GetProductsListUseCase>()(param);
    return Result(error: result.error, data: result.data?.items ?? []);
  }

  void getSearch(
      ShopsListParam paramStore, GetProductsParam paramProduct) async {
    emit(const ShopState.shopLoadingState());

    final List<dynamic> results = await Future.wait([
      getIt<GetShopsListUsecase>()(paramStore),
      getIt<GetProductsListUseCase>()(paramProduct),
    ]);

    if (results[0].hasErrorOnly || results[1].hasErrorOnly) {
      final error =
          results[0].hasErrorOnly ? results[0].error : results[1].error;
      emit(
        ShopState.shopErrorState(
            error!, () => this.getSearch(paramStore, paramProduct)),
      );
    } else {
      emit(ShopState.searchLodedState(results[0].data!, results[1].data!));
    }
  }

  void uploadImagesandReview({
    required List<XFile> images,
    required String coment,
    required int rate,
    required int id,
    required int experienceRate,
    required int profesionalismRate,
    required int waitTimeRate,
    required int valueRate,
    required int refType,
  }) async {
    List<String> urls = [];
    emit(const ShopState.shopLoadingState());
    for (int i = 0; i < images.length; i++) {
      final result =
          await getIt<UploadImagesUsecase>()(ImagesParams(image: images[i]));
      result.pick(
        onData: (data) {
          urls.add(data.urls[0]);
        },
        onError: (error) => emit(ShopState.shopErrorState(
          error,
          () => this.uploadImagesandReview(
              coment: coment,
              id: id,
              refType: refType,
              images: images,
              rate: rate,
              experienceRate: experienceRate,
              profesionalismRate: profesionalismRate,
              valueRate: valueRate,
              waitTimeRate: waitTimeRate),
        )),
      );
    }
    final result = await getIt<ReviewProductUsecase>()(CreateReviewParams(
        comment: coment,
        rate: rate,
        refId: id,
        refType: refType,
        images: urls,
        experienceRate: experienceRate,
        profesionalismRate: profesionalismRate,
        valueRate: valueRate,
        waitTimeRate: waitTimeRate));
    result.pick(
      onData: (data) => emit(ShopState.reviewProductLodedState(data)),
      onError: (error) => emit(ShopState.shopErrorState(
        error,
        () => this.uploadImagesandReview(
            coment: coment,
            id: id,
            refType: refType,
            images: images,
            rate: rate,
            experienceRate: experienceRate,
            profesionalismRate: profesionalismRate,
            valueRate: valueRate,
            waitTimeRate: waitTimeRate),
      )),
    );
  }

  void checkCoupon(CheckCouponParam params) async {
    emit(const ShopState.shopLoadingState());

    final result = await getIt<CheckCouponUseCase>().call(params);
    result.pick(
      onData: (data) => emit(ShopState.checkCouponLoaded(data)),
      onError: (error) => emit(
        ShopState.shopErrorState(error, () {
          this.checkCoupon(params);
        }),
      ),
    );
  }

  void followShop(IdParam params) async {
    emit(const ShopState.shopLoadingState());

    final result = await getIt<FolloWShopUseCase>().call(params);
    result.pick(
      onData: (data) {
        emit(const ShopState.followShopSuccess());
        // getShops(ShopsListParam(
        //   onlyFollowingShops: true,
        // ));
      },
      onError: (error) => emit(
        ShopState.shopErrorState(error, () {
          this.followShop(params);
        }),
      ),
    );
  }

  void getSingleShop(SingleShopParams param) async {
    emit(const ShopState.shopLoadingState());

    final result = await getIt<GetSingleShopUseCase>().call(param);
    result.pick(
      onData: (data) => emit(ShopState.getSingleStoreSuccess(data)),
      onError: (error) => emit(
        ShopState.getSingleStoreError(error, () {
          this.getSingleShop(param);
        }),
      ),
    );
  }

  void unFollowShop(IdParam params) async {
    emit(const ShopState.shopLoadingState());

    final result = await getIt<UnFolloWShopUseCase>().call(params);
    result.pick(
      onData: (data) {
        emit(const ShopState.unFollowShopSuccess());
        // getShops(ShopsListParam(
        //   onlyFollowingShops: true,
        // ));
      },
      onError: (error) => emit(
        ShopState.shopErrorState(error, () {
          this.unFollowShop(params);
        }),
      ),
    );
  }

  void getShops(ShopsListParam params) async {
    emit(const ShopState.shopLoadingState());

    final result = await getIt<GetShopsListUsecase>().call(params);
    result.pick(
      onData: (data) => emit(ShopState.shopsListLoaded(data)),
      onError: (error) => emit(
        ShopState.shopErrorState(error, () {
          this.getShops(params);
        }),
      ),
    );
  }

  void getFavoriteProducts(GetFavoritesParams params) async {
    emit(const ShopState.shopLoadingState());

    final result = await getIt<GetFavoriteProductsUseCase>().call(params);
    result.pick(
      onData: (data) => emit(ShopState.favoriteProductsLoaded(data)),
      onError: (error) => emit(
        ShopState.shopErrorState(error, () {
          this.getFavoriteProducts(params);
        }),
      ),
    );
  }

  void getSliderImages(GetSliderImagesParam params) async {
    emit(const ShopState.shopLoadingState());

    final result = await getIt<GetSliderImagesUsecase>().call(params);
    result.pick(
      onData: (data) => emit(ShopState.sliderImagesLoaded(data)),
      onError: (error) => emit(
        ShopState.shopErrorState(error, () {
          this.getSliderImages(params);
        }),
      ),
    );
  }

  void addToFavorite(IdParam params) async {
    emit(const ShopState.addToFavoriteLoading());

    final result = await getIt<AddFavoriteProductUseCase>().call(params);
    result.pick(
      onData: (data) => emit(const ShopState.addToFavorite()),
      onError: (error) => emit(
        const ShopState.addToFavoriteError(),
      ),
    );
  }

  void removeFromFavorite(IdParam params) async {
    emit(const ShopState.removeFromFavoriteLoading());

    final result = await getIt<RemoveFavoriteProductUseCase>().call(params);
    result.pick(
      onData: (data) => emit(const ShopState.removeFromFavorite()),
      onError: (error) => emit(
        const ShopState.removeFromFavoriteError(),
      ),
    );
  }

// void filterProduct(bool price , bool rate, bool date) async {
//   ProductResponceModel productResponceModel;
//   emit(GetProductLoading());
//   this.date  = date;
//   this.price = price;
//   this.rate  = rate;
//   String sort =  sortFunction(price,rate,date);
//   try {
//     getAllProductRequestModel.skipCount = 0;
//     getAllProductRequestModel.maxResultCount = 20;
//     getAllProductRequestModel.sorting  = sort;
//     items.clear();
//     productResponceModel = await Network.filterProduct(getAllProductRequestModel);
//     if (productResponceModel.success) {
//       if (productResponceModel.result.items.isEmpty) {
//         emit(GetProductEmpty());
//       } else{
//         items.addAll(productResponceModel.result.items);
//         emit(GetProductSuccess(items: items));
//       }
//     } else {
//       emit(GetProductFailure(errorModel: productResponceModel.error));
//     }
//   } catch (e) {
//     emit(GetProductFailure(errorModel: ErrorModel(details: e.toString())));
//   }
// }
}

class ShippingAddressCubit extends Cubit<ShippingAddressState> {
  ShippingAddressCubit()
      : super(const ShippingAddressState.shippingAddressInitState());

  void createShippingAddress(AddEditShippingAddressParam params) async {
    emit(const ShippingAddressState.shippingAddressLoadingState());

    final result = await getIt<CreateShippingAddressUseCase>().call(params);
    result.pick(
      onData: (data) =>
          emit(ShippingAddressState.createShippingAddressSuccess(data)),
      onError: (error) => emit(
        ShippingAddressState.shippingAddressErrorState(error, () {
          this.createShippingAddress(params);
        }),
      ),
    );
  }

  void updateShippingAddress(AddEditShippingAddressParam params) async {
    emit(const ShippingAddressState.shippingAddressLoadingState());

    final result = await getIt<UpdateShippingAddressUseCase>().call(params);
    result.pick(
      onData: (data) =>
          emit(ShippingAddressState.updateShippingAddressSuccess(data)),
      onError: (error) => emit(
        ShippingAddressState.shippingAddressErrorState(error, () {
          this.updateShippingAddress(params);
        }),
      ),
    );
  }

  void deleteShippingAddress(IdParam params) async {
    emit(const ShippingAddressState.shippingAddressLoadingState());

    final result = await getIt<DeleteShippingAddressUseCase>().call(params);
    result.pick(
      onData: (data) =>
          emit(const ShippingAddressState.deleteShippingAddressSuccess()),
      onError: (error) => emit(
        ShippingAddressState.shippingAddressErrorState(error, () {
          this.deleteShippingAddress(params);
        }),
      ),
    );
  }

  void getShippingAddresses() async {
    emit(const ShippingAddressState.shippingAddressLoadingState());

    final result = await getIt<GetShippingAddressesUseCase>().call(NoParams());
    result.pick(
      onData: (data) =>
          emit(ShippingAddressState.getShippingAddressesLoaded(data)),
      onError: (error) => emit(
        ShippingAddressState.shippingAddressErrorState(error, () {
          this.getShippingAddresses();
        }),
      ),
    );
  }

  Future<List<ShippingAddressEntity>?> getShippingAddressesWithList() async {
    final result = await getIt<GetShippingAddressesUseCase>().call(NoParams());
    return result.data!.items;
  }
}
