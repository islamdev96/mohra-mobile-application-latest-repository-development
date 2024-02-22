import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/id_param.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/params/singleStore_params.dart';
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
import 'package:starter_application/features/shop/data/model/response/check_coupon_model.dart';
import 'package:starter_application/features/shop/data/model/response/favorite_products_list_model.dart';
import 'package:starter_application/features/shop/data/model/response/get_taxfee_model.dart';
import 'package:starter_application/features/shop/data/model/response/image_upload_model.dart';
import 'package:starter_application/features/shop/data/model/response/order_details_model.dart';
import 'package:starter_application/features/shop/data/model/response/orders_model.dart';
import 'package:starter_application/features/shop/data/model/response/productItem_model.dart';
import 'package:starter_application/features/shop/data/model/response/products_list_model.dart';
import 'package:starter_application/features/shop/data/model/response/reviews_model.dart';
import 'package:starter_application/features/shop/data/model/response/shipping_addresses_list_model.dart';
import 'package:starter_application/features/shop/data/model/response/shops_list_model.dart';
import 'package:starter_application/features/shop/data/model/response/slider_model.dart';
import 'package:starter_application/features/shop/data/model/response/storeCategory_model.dart';
import 'package:starter_application/features/shop/data/model/response/topCategory_model.dart';

import '../../../../core/datasources/remote_data_source.dart';

abstract class IShopSource extends RemoteDataSource {
  Future<Either<AppErrors, SliderModel>> getSliderImages(
      GetSliderImagesParam param);

  Future<Either<AppErrors, TopCategoryModel>> getTopCategory();

  Future<Either<AppErrors, ShopsListModel>> getShops(ShopsListParam param);

  Future<Either<AppErrors, ProductsListModel>> getTopProducts(
      ShopsListParam param);

  Future<Either<AppErrors, ImageUrlsShopModel>> uploadImages(
      ImagesParams params);

  Future<Either<AppErrors, ProductsListModel>> getProducts(
      GetProductsParam param);

  Future<Either<AppErrors, StoreCategoryModel>> getStoreCategorys(
      GetShopCategoryParams param);

  Future<Either<AppErrors, ReviewsModel>> getReview(ReviewParam param);

  Future<Either<AppErrors, GetSettingModel>> getTaxFee();

  Future<Either<AppErrors, ProductItemModel>> getProductItem(
      ProductItemParam param);

  Future<Either<AppErrors, ItemReviewsModel>> CreateReview(
      CreateReviewParams params);

  Future<Either<AppErrors, CheckCouponModel>> checkCoupon(
      CheckCouponParam param);

  Future<Either<AppErrors, ShopModel>> getSingleShop(SingleShopParams param);

  Future<Either<AppErrors, EmptyResponse>> followShop(IdParam param);

  Future<Either<AppErrors, EmptyResponse>> unFollowShop(IdParam param);

  Future<Either<AppErrors, EmptyResponse>> createOrder(CreateOrderParams param);

  Future<Either<AppErrors, EmptyResponse>> checkIfCanCreateOrder(
      CreateOrderParams param);

  Future<Either<AppErrors, FavoriteProductsListModel>> getFavoriteProducts(
      GetFavoritesParams param);

  Future<Either<AppErrors, EmptyResponse>> addToFavorite(IdParam param);

  Future<Either<AppErrors, EmptyResponse>> removeFromFavorite(IdParam param);

  Future<Either<AppErrors, ShippingAddressModel>> createShippingAddress(
      AddEditShippingAddressParam param);

  Future<Either<AppErrors, EmptyResponse>> deleteShippingAddress(IdParam param);

  Future<Either<AppErrors, ShippingAddressesListModel>> getShippingAddresses(
      NoParams param);

  Future<Either<AppErrors, ShippingAddressModel>> updateShippingAddress(
      AddEditShippingAddressParam param);

  Future<Either<AppErrors, OrdersModel>> getOrders(
      GetAllNotificationParam params);

  Future<Either<AppErrors, OrderDetailsModel>> getOrderDetails(
      GetOrderDetailsParams params);
}
