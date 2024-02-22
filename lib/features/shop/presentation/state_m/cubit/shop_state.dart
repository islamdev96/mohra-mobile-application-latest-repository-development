part of 'shop_cubit.dart';

@freezed
class ShopState with _$ShopState {
  const factory ShopState.shopInitState() = ShopInitState;

  const factory ShopState.shopLoadingState() = ShopLoadingState;

  const factory ShopState.getOrdersLoadingState() = GetOrdersLoadingState;

  const factory ShopState.getDetailsOrderLoadingState() =
      GetDetailsOrderLoadingState;

  const factory ShopState.getOrderError(
    AppErrors error,
    VoidCallback callback,
  ) = GetOrderError;

  const factory ShopState.getDetailsOrderError(
    AppErrors error,
    VoidCallback callback,
  ) = GetDetailsOrderError;

  const factory ShopState.getOrdersSuccess(
    OrdersModel ordersModel,
  ) = GetOrdersSuccess;

  const factory ShopState.getDetailsOrderSuccess(
    OrderDetailsModel orderDetails,
  ) = GetDetailsOrderSuccess;

  const factory ShopState.shopErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = ShopErrorState;

  const factory ShopState.homeStoreLodedState(
    SliderEntity sliderEntity,
    TopCategoryEntity topCategoryEntity,
    ShopsListEntity topStoreEntity,
    ProductsListEntity topProductsEntity,
  ) = HomeStoreLodedState;

  const factory ShopState.singleStoreLodedState(
      ProductsListEntity topProductsEntity,
      ProductsListEntity ProductsEntity,
      ReviewsEntity reviewsEntity) = SingleStoreLodedState;

  const factory ShopState.getSingleStoreSuccess(
    ShopEntity shopEntity,
  ) = GetSingleStoreSuccess;

  const factory ShopState.getSingleStoreError(
    AppErrors error,
    VoidCallback callback,
  ) = GetSingleStoreError;

  const factory ShopState.getProductsLoaded(
    ProductsListEntity topProductsEntity,
  ) = GetProductsLoadedState;

  const factory ShopState.storeCategoryLodedState(
    StoreCategoryEntity storeCategoryEntity,
  ) = StoreCategoryLodedState;

  const factory ShopState.productItemLodedState(
      ProductItemEntity productItemEntity,
      ReviewsEntity reviewsEntity,
      ProductsListEntity topProductsEntity) = ProductItemLodedState;

  const factory ShopState.searchLodedState(
    ShopsListEntity topStoreEntity,
    ProductsListEntity topProductsEntity,
  ) = SearchLodedState;

  const factory ShopState.reviewProductLodedState(
    ItemReviewsEntity itemReviewsEntity,
  ) = ReviewProductLodedState;

  const factory ShopState.checkCouponLoaded(
    CheckCouponEntity checkCouponEntity,
  ) = CheckCouponLoadedState;

  const factory ShopState.followShopSuccess() = FollowShopSuccessState;

  const factory ShopState.createOrderSuccess() = CreateOrderSuccess;

  const factory ShopState.checkIfCanCreateOrderSuccess() = CheckIfCanCreateOrderSuccess;

  const factory ShopState.checkIfCanCreateOrderErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = CheckIfCanCreateOrderErrorState;

  const factory ShopState.createOrderErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = CreateOrderErrorState;

  const factory ShopState.createOrderLoading() = CreateOrderLoading;

  const factory ShopState.unFollowShopSuccess() = UnFollowShopSuccessState;

  const factory ShopState.addingToCart() = AddingToCart;

  const factory ShopState.shopsListLoaded(ShopsListEntity shopsListEntity) =
      ShopsListLoadedState;

  const factory ShopState.favoriteProductsLoaded(ProductsListEntity products) =
      FavoriteProductsLoadedState;

  const factory ShopState.sliderImagesLoaded(SliderEntity slider) =
      SliderImagesLoaded;

  const factory ShopState.addToFavorite() = AddToFavorite;

  const factory ShopState.removeFromFavorite() = RemoveFromFavorite;

  const factory ShopState.addToFavoriteLoading() = AddToFavoriteLoading;

  const factory ShopState.removeFromFavoriteLoading() =
      RemoveFromFavoriteLoading;

  const factory ShopState.addToFavoriteError() = AddToFavoriteError;

  const factory ShopState.removeFromFavoriteError() = RemoveFromFavoriteError;
}

@freezed
class ShippingAddressState with _$ShippingAddressState {
  const factory ShippingAddressState.shippingAddressInitState() =
      ShippingAddressInitState;

  const factory ShippingAddressState.shippingAddressLoadingState() =
      ShippingAddressLoadingState;

  const factory ShippingAddressState.shippingAddressErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = ShippingAddressErrorState;

  const factory ShippingAddressState.createShippingAddressSuccess(
      ShippingAddressEntity address) = CreateShippingAddressSuccessState;

  const factory ShippingAddressState.updateShippingAddressSuccess(
      ShippingAddressEntity address) = UpdateShippingAddressSuccessState;

  const factory ShippingAddressState.deleteShippingAddressSuccess() =
      DeleteShippingAddressSuccessState;

  const factory ShippingAddressState.getShippingAddressesLoaded(
      ShippingAddressesListEntity entity) = GetShippingAddressesLoadedState;
}
