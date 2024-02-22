import 'package:dartz/dartz.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_client_type.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/create_model_interceptor/all_data_create_model_inteceptor.dart';
import 'package:starter_application/core/net/create_model_interceptor/null_response_model_interceptor.dart';
import 'package:starter_application/core/net/net.dart';
import 'package:starter_application/core/net/response_validators/default_response_validator.dart';
import 'package:starter_application/core/params/id_param.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/params/singleStore_params.dart';
import 'package:starter_application/features/event/data/model/response/event_model.dart';
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

import 'ishop_remote.dart';

@Singleton(as: IShopSource)
class ShopRemoteSource extends IShopSource {
  @override
  Future<Either<AppErrors, SliderModel>> getSliderImages(
      GetSliderImagesParam param) {
    return request(
        converter: (json) => SliderModel.fromJson(json),
        method: HttpMethod.GET,
        url: APIUrls.SliderImages,
        queryParameters: param.toMap(),
        createModelInterceptor: const AllDataCreateModelInterceptor());
  }

  @override
  Future<Either<AppErrors, TopCategoryModel>> getTopCategory() {
    return request(
      converter: (json) => TopCategoryModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.TopCategory,
    );
  }

  @override
  Future<Either<AppErrors, ShopModel>> getSingleShop(SingleShopParams param) {
    return request(
      converter: (json) => ShopModel.fromMap(json),
      method: HttpMethod.GET,
      queryParameters: param.toMap(),
      url: APIUrls.singleShop,
    );
  }

  @override
  Future<Either<AppErrors, ShopsListModel>> getShops(ShopsListParam param) {
    return request(
      converter: (json) => ShopsListModel.fromMap(json),
      method: HttpMethod.GET,
      queryParameters: param.toMap(),
      url: APIUrls.shopsList,
    );
  }

  @override
  Future<Either<AppErrors, ProductsListModel>> getTopProducts(
      ShopsListParam param) {
    return request(
      converter: (json) => ProductsListModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.TopProducts,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, ProductsListModel>> getProducts(
      GetProductsParam param) {
    return request(
      converter: (json) => ProductsListModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.productsList,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, StoreCategoryModel>> getStoreCategorys(
      GetShopCategoryParams param) {
    return request(
        converter: (json) => StoreCategoryModel.fromMap(json),
        method: HttpMethod.GET,
        url: APIUrls.StoreCategorys,
        queryParameters: param.toMap());
  }

  @override
  Future<Either<AppErrors, ReviewsModel>> getReview(ReviewParam param) {
    return request(
      converter: (json) => ReviewsModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.Review,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, ProductItemModel>> getProductItem(
      ProductItemParam param) {
    return request(
      converter: (json) => ProductItemModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.ProductItem,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, ImageUrlsShopModel>> uploadImages(
      ImagesParams params) {
    return requestUploadFile(
        converter: (json) {
          return ImageUrlsShopModel.fromMap(json);
        },
        url: APIUrls.uploadImageMahmoud,
        fileKey: 'input',
        filePath: params.image.path,
        data: {},
        responseValidator: DefaultResponseValidator(),
        mediaType: MediaType('image', 'png'));
  }

  @override
  Future<Either<AppErrors, ItemReviewsModel>> CreateReview(
      CreateReviewParams params) {
    return request(
      converter: (json) {
        return ItemReviewsModel.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.CreateReview,
      body: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, CheckCouponModel>> checkCoupon(
      CheckCouponParam param) {
    return request(
      converter: (json) {
        return CheckCouponModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.API_CHECK_COUPON_VALIDITY,
      queryParameters: param.toMap(),
      // responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> followShop(IdParam param) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.API_FOLLOW_SHOP,
      body: param.toMap(),
      createModelInterceptor: const AllDataCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> createOrder(
      CreateOrderParams param) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.API_CREATE_ORDER,
      body: param.toMap(),
      createModelInterceptor: const AllDataCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> checkIfCanCreateOrder(
      CreateOrderParams param) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.API_CHECK_IF_CAN_CREATE_ORDER,
      body: param.toMap(),
      createModelInterceptor: const AllDataCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> unFollowShop(IdParam param) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.API_UN_FOLLOW_SHOP,
      body: param.toMap(),
      createModelInterceptor: const AllDataCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, FavoriteProductsListModel>> getFavoriteProducts(
      GetFavoritesParams param) {
    return request(
      converter: (json) {
        return FavoriteProductsListModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.API_GET_FAVORITE_PRODUCTS,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, ShippingAddressModel>> createShippingAddress(
      AddEditShippingAddressParam param) {
    return request(
      converter: (json) {
        return ShippingAddressModel.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.API_CREATE_SHIPPING_ADDRESS,
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deleteShippingAddress(
      IdParam param) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.DELETE,
      url: APIUrls.API_DELETE_SHIPPING_ADDRESS,
      queryParameters: param.toMap(),
      createModelInterceptor: const NullResponseModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, ShippingAddressesListModel>> getShippingAddresses(
      NoParams param) {
    return request(
      converter: (json) {
        return ShippingAddressesListModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.API_GET_SHIPPING_ADDRESSES,
      queryParameters: {
        "SkipCount": 0,
        "MaxResultCount": 1000,
      },
    );
  }

  @override
  Future<Either<AppErrors, OrdersModel>> getOrders(
      GetAllNotificationParam params) {
    return request(
        converter: (json) => OrdersModel.fromMap(json),
        method: HttpMethod.GET,
        url: APIUrls.API_GET_ORDERS,
        queryParameters: params.toMap());
  }

  @override
  Future<Either<AppErrors, OrderDetailsModel>> getOrderDetails(
      GetOrderDetailsParams params) {
    return request(
      converter: (json) => OrderDetailsModel.fromJson(json),
      queryParameters: params.toMap(),
      method: HttpMethod.GET,
      url: APIUrls.API_DETAILS_ORDERS,
    );
  }

  @override
  Future<Either<AppErrors, ShippingAddressModel>> updateShippingAddress(
      AddEditShippingAddressParam param) {
    return request(
      converter: (json) {
        return ShippingAddressModel.fromMap(json);
      },
      method: HttpMethod.PUT,
      url: APIUrls.API_UPDATE_SHIPPING_ADDRESS,
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> addToFavorite(IdParam param) {
    return request(
        converter: (json) {
          return EmptyResponse.fromMap(json);
        },
        method: HttpMethod.POST,
        url: APIUrls.API_CREATE_Product_FAVORITE,
        body: param.toMap(),
        withAuthentication: true,
        httpClientType: HttpClientType.MAIN);
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> removeFromFavorite(IdParam param) {
    return request(
        converter: (json) {
          return EmptyResponse.fromMap(json);
        },
        method: HttpMethod.DELETE,
        url: APIUrls.API_DELETE_Product_FAVORITE,
        queryParameters: param.toMap(),
        withAuthentication: true,
        httpClientType: HttpClientType.MAIN);
  }

  @override
  Future<Either<AppErrors, GetSettingModel>> getTaxFee() {
    return request(
        converter: (json) {
          return GetSettingModel.fromJson(json);
        },
        method: HttpMethod.GET,
        url: APIUrls.API_GetFeesPercentage,
        withAuthentication: true,
        httpClientType: HttpClientType.MAIN);
  }
}
