import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/id_param.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/params/singleStore_params.dart';
import 'package:starter_application/core/results/result.dart';
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

import '../../../../core/repositories/repository.dart';

abstract class IShopRepository extends Repository {
  Future<Result<AppErrors, SliderEntity>> getSliderImages(
      GetSliderImagesParam param);

  Future<Result<AppErrors, TopCategoryEntity>> getTopCategory();

  Future<Result<AppErrors, ShopsListEntity>> getShops(ShopsListParam param);

  Future<Result<AppErrors, ProductsListEntity>> getTopProducts(
      ShopsListParam param);

  Future<Result<AppErrors, ProductsListEntity>> getProducts(
      GetProductsParam param);

  Future<Result<AppErrors, StoreCategoryEntity>> getStoreCategorys(
      GetShopCategoryParams params);

  Future<Result<AppErrors, ShopEntity>> getSingleShop(SingleShopParams params);

  Future<Result<AppErrors, ReviewsEntity>> getReview(ReviewParam param);

  Future<Result<AppErrors, ImagesUrlsShopEntity>> uploadImages(
      ImagesParams params);

  Future<Result<AppErrors, ProductItemEntity>> getProductItem(
      ProductItemParam param);

  Future<Result<AppErrors, ItemReviewsEntity>> CreateReview(
      CreateReviewParams param);

  Future<Result<AppErrors, CheckCouponEntity>> checkCoupon(
      CheckCouponParam param);

  Future<Result<AppErrors, EmptyResponse>> followShop(IdParam param);

  Future<Result<AppErrors, EmptyResponse>> createOrder(CreateOrderParams param);

  Future<Result<AppErrors, EmptyResponse>> checkIfCanCreateOrder(
      CreateOrderParams param);

  Future<Result<AppErrors, EmptyResponse>> unFollowShop(IdParam param);

  Future<Result<AppErrors, ProductsListEntity>> getFavoriteProducts(
      GetFavoritesParams param);

  Future<Result<AppErrors, EmptyResponse>> addToFavorite(IdParam param);

  Future<Result<AppErrors, GetSettingModel>> getTaxFee();

  Future<Result<AppErrors, EmptyResponse>> removeFromFavorite(IdParam param);

  Future<Result<AppErrors, ShippingAddressEntity>> createShippingAddress(
      AddEditShippingAddressParam param);

  Future<Result<AppErrors, ShippingAddressEntity>> updateShippingAddress(
      AddEditShippingAddressParam param);

  Future<Result<AppErrors, EmptyResponse>> deleteShippingAddress(IdParam param);

  Future<Result<AppErrors, ShippingAddressesListEntity>> getShippingAddresses(
      NoParams param);

  Future<Result<AppErrors, OrdersModel>> getAllOrder(
      GetAllNotificationParam params);

  Future<Result<AppErrors, OrderDetailsModel>> getOrderDetails(
      GetOrderDetailsParams params);
}
