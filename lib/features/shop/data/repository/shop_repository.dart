import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/id_param.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/params/singleStore_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/favorite/data/model/request/get_favorites_params.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/features/shop/data/datasource/ishop_remote.dart';
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
import 'package:starter_application/features/shop/data/model/response/get_taxfee_model.dart';
import 'package:starter_application/features/shop/data/model/response/order_details_model.dart';
import 'package:starter_application/features/shop/data/model/response/orders_model.dart';
import 'package:starter_application/features/shop/domain/entity/check_coupon_entity.dart';
import 'package:starter_application/features/shop/domain/entity/image_urls_entity.dart';
import 'package:starter_application/features/shop/domain/entity/prodcuts_list_entity.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/domain/entity/reviews_entity.dart';
import 'package:starter_application/features/shop/domain/entity/shipping_addresses_list_entity.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';
import 'package:starter_application/features/shop/domain/entity/slider_entity.dart';
import 'package:starter_application/features/shop/domain/entity/storeCategory_entity.dart';
import 'package:starter_application/features/shop/domain/entity/topCategory_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

import '/core/common/extensions/either_error_model_extension.dart';

@Singleton(as: IShopRepository)
class ShopRepository extends IShopRepository {
  final IShopSource iShopSource;

  ShopRepository(this.iShopSource);

  @override
  Future<Result<AppErrors, SliderEntity>> getSliderImages(
      GetSliderImagesParam param) async {
    return execute(remoteResult: await iShopSource.getSliderImages(param));
  }

  @override
  Future<Result<AppErrors, ShopEntity>> getSingleShop(
      SingleShopParams param) async {
    return execute(remoteResult: await iShopSource.getSingleShop(param));
  }

  @override
  Future<Result<AppErrors, TopCategoryEntity>> getTopCategory() async {
    return execute(remoteResult: await iShopSource.getTopCategory());
  }

  @override
  Future<Result<AppErrors, ShopsListEntity>> getShops(
      ShopsListParam param) async {
    return execute(remoteResult: await iShopSource.getShops(param));
  }

  @override
  Future<Result<AppErrors, ProductsListEntity>> getTopProducts(
      ShopsListParam param) async {
    return execute(remoteResult: await iShopSource.getTopProducts(param));
  }

  @override
  Future<Result<AppErrors, ProductsListEntity>> getProducts(
      GetProductsParam param) async {
    final remote = await iShopSource.getProducts(param);
    return remote.result<ProductsListEntity>();
  }

  @override
  Future<Result<AppErrors, StoreCategoryEntity>> getStoreCategorys(
      GetShopCategoryParams param) async {
    final remote = await iShopSource.getStoreCategorys(param);
    return remote.result<StoreCategoryEntity>();
  }

  @override
  Future<Result<AppErrors, ReviewsEntity>> getReview(ReviewParam param) async {
    final remote = await iShopSource.getReview(param);
    return remote.result<ReviewsEntity>();
  }

  @override
  Future<Result<AppErrors, ProductItemEntity>> getProductItem(
      ProductItemParam param) async {
    final remote = await iShopSource.getProductItem(param);
    return remote.result<ProductItemEntity>();
  }

  @override
  Future<Result<AppErrors, ImagesUrlsShopEntity>> uploadImages(
      ImagesParams params) async {
    final remote = await iShopSource.uploadImages(params);
    return remote.result<ImagesUrlsShopEntity>();
  }

  @override
  Future<Result<AppErrors, ItemReviewsEntity>> CreateReview(
      CreateReviewParams param) async {
    final remote = await iShopSource.CreateReview(param);
    return remote.result<ItemReviewsEntity>();
  }

  @override
  Future<Result<AppErrors, CheckCouponEntity>> checkCoupon(
      CheckCouponParam param) async {
    final remote = await iShopSource.checkCoupon(param);
    return remote.result<CheckCouponEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> followShop(IdParam param) async {
    final remote = await iShopSource.followShop(param);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> createOrder(
      CreateOrderParams param) async {
    final remote = await iShopSource.createOrder(param);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> checkIfCanCreateOrder(
      CreateOrderParams param) async {
    final remote = await iShopSource.checkIfCanCreateOrder(param);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> unFollowShop(IdParam param) async {
    final remote = await iShopSource.unFollowShop(param);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, ProductsListEntity>> getFavoriteProducts(
      GetFavoritesParams param) async {
    final remote = await iShopSource.getFavoriteProducts(param);
    return remote.result<ProductsListEntity>();
  }

  @override
  Future<Result<AppErrors, ShippingAddressEntity>> createShippingAddress(
      AddEditShippingAddressParam param) async {
    final remote = await iShopSource.createShippingAddress(param);
    return remote.result<ShippingAddressEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> deleteShippingAddress(
      IdParam param) async {
    final remote = await iShopSource.deleteShippingAddress(param);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, ShippingAddressesListEntity>> getShippingAddresses(
      NoParams param) async {
    final remote = await iShopSource.getShippingAddresses(param);
    return remote.result<ShippingAddressesListEntity>();
  }

  @override
  Future<Result<AppErrors, ShippingAddressEntity>> updateShippingAddress(
      AddEditShippingAddressParam param) async {
    final remote = await iShopSource.updateShippingAddress(param);
    return remote.result<ShippingAddressEntity>();
  }

  @override
  Future<Result<AppErrors, OrdersModel>> getAllOrder(
      GetAllNotificationParam params) async {
    final remoteResult = await iShopSource.getOrders(params);
    return remoteResult.result<OrdersModel>();
  }

  @override
  Future<Result<AppErrors, OrderDetailsModel>> getOrderDetails(
      GetOrderDetailsParams params) async {
    final remoteResult = await iShopSource.getOrderDetails(params);
    return remoteResult.result<OrderDetailsModel>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> addToFavorite(IdParam param) async {
    final remoteResult = await iShopSource.addToFavorite(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> removeFromFavorite(
      IdParam param) async {
    final remoteResult = await iShopSource.removeFromFavorite(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, GetSettingModel>> getTaxFee() async {
    final remoteResult = await iShopSource.getTaxFee();
    return remoteResult.result<GetSettingModel>();
  }
}
