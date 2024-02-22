import 'package:starter_application/core/params/base_params.dart';

class GetProductsParam extends BaseParams {
  final String? Sorting;
  final String? Search;
  final int? ShopId;
  final int? OrderType;
  final int? SkipCount;
  final int? MaxResultCount;
  final int? supCategoryId;
  final int? categoryId;
  final bool? HasOffer;
  final bool? OnlyFeatured;
  final bool? FollowedShopsProducts;
  final int? mightLikeProductId;
  final double? minPrice;
  final double? maxPrice;
  final double? minRate;
  final double? maxRate;
  final int? minMostRequest;
  final int? maxMostRequest;
  final int? minTopSelling;
  final int? maxTopSelling;
  final DateTime? fromDate;
  final DateTime? toDate;
  final bool? IncludeOnlyFavorite;

  GetProductsParam(
      {this.Sorting,
      this.ShopId,
      this.Search,
      this.OrderType,
      this.SkipCount,
      this.MaxResultCount,
      this.supCategoryId,
      this.mightLikeProductId,
      this.minPrice,
      this.HasOffer,
      this.FollowedShopsProducts,
      this.OnlyFeatured,
      this.maxPrice,
      this.minRate,
      this.maxRate,
      this.minMostRequest,
      this.maxMostRequest,
      this.minTopSelling,
      this.maxTopSelling,
      this.fromDate,
      this.toDate,
      this.categoryId,
      this.IncludeOnlyFavorite,

      });
// ClassificationId
  Map<String, dynamic> toMap() {
    return {
      if (Sorting != null) 'Sorting': Sorting ?? '',
      if (supCategoryId != null) 'ClassificationId': supCategoryId ?? '',
      if (ShopId != null) 'ShopId': ShopId ?? '',
      if (OrderType != null) 'OrderType': OrderType,
      if (HasOffer != null) 'HasOffer': HasOffer,
      if (OnlyFeatured != null) 'OnlyFeatured': OnlyFeatured,
      if (FollowedShopsProducts != null) 'FollowedShopsProducts': FollowedShopsProducts,
      if (Search != null) 'Keyword': Search ?? '',
      if (SkipCount != null) 'SkipCount': SkipCount ?? '',
      if (MaxResultCount != null) 'MaxResultCount': MaxResultCount ?? '',
      if (mightLikeProductId != null) 'MightLikeProductId': mightLikeProductId,
      if (minPrice != null) 'MinPrice': minPrice,
      if (maxPrice != null) 'MaxPrice': maxPrice,
      if (minRate != null) 'MinRate': minRate,
      if (maxRate != null) 'MaxRate': maxRate,
      if (minMostRequest != null) 'MinMostRequest': minMostRequest,
      if (maxMostRequest != null) 'MaxMostRequest': maxMostRequest,
      if (minTopSelling != null) 'MinTopSelling': minTopSelling,
      if (maxTopSelling != null) 'MaxTopSelling': maxTopSelling,
      if (fromDate != null) 'FromDate': fromDate!.toIso8601String(),
      if (toDate != null) 'ToDate': toDate!.toIso8601String(),
      if (categoryId != null) 'CategoryId': categoryId,
      'IsActive': true,
      if (IncludeOnlyFavorite != null) 'IncludeOnlyFavorite': IncludeOnlyFavorite,
    };
  }

  // ProductsParam copyWith(
  //     {String? Sorting, int? ShopId, int? SkipCount, int? MaxResultCount}) {
  //   return ProductsParam(
  //     Sorting: Sorting ?? this.Sorting,
  //     ShopId: ShopId ?? this.ShopId,
  //     SkipCount: SkipCount ?? this.SkipCount,
  //     MaxResultCount: MaxResultCount ?? this.MaxResultCount,
  //   );
  // }
}
