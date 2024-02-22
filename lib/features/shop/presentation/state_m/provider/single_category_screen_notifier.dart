import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/constants/enums/sorting_option_enum.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/singleStore_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/domain/usecase/get_products_usecase.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/widgets/bottom_sheet_product_filter.dart';

enum SortingOrder { ASC, DESC }

class SingleCategoryScreenNotifier extends ScreenNotifier {
  SingleCategoryScreenNotifier() {
    filterData = BottomSheetProductFilterData(
      minPrice: 0,
      maxPrice: 5000,
      minRate: 0,
      maxRate: 5,
      minSales: 0,
      maxSales: 5000,
      minYearOffset: 0,
      maxYearOffset: DateTime.now().year - firstYear,
      minRequests: 0,
      maxRequests: 5000,
      firstYear: firstYear,
    );
    oldFilterData = BottomSheetProductFilterData(
      minPrice: 0,
      maxPrice: 5000,
      minRate: 0,
      maxRate: 5,
      minSales: 0,
      maxSales: 5000,
      minYearOffset: 0,
      maxYearOffset: DateTime.now().year - firstYear,
      minRequests: 0,
      maxRequests: 5000,
      firstYear: firstYear,
    );
  }
  RefreshController refreshController = RefreshController();
  late BottomSheetProductFilterData oldFilterData;
  late BuildContext context;
  final storCubit = ShopCubit();
  int? supCategoryId;
  int SkipCount = 0;
  int MaxResultCount = 10;
  SortingType? _sorting;
  bool _filter = false;
  SortingOrder _sortingOrder = SortingOrder.DESC;

  String? search;
  // String Sorting = '';

  List<ProductItemEntity>? ProductInSupcategory;
  int firstYear = 2010;

  late BottomSheetProductFilterData filterData;

  /// Getters and setters
  SortingType? get sorting => this._sorting;
  bool get filter => this._filter;
  SortingOrder get sortingOrder => this._sortingOrder;

  void getSingleCategory() {
    storCubit.getProducts(
      GetProductsParam(
        MaxResultCount: MaxResultCount,
        SkipCount: SkipCount,
        Search: search,
        Sorting: sorting?.name == null
            ? null
            : "${sorting!.name} ${sortingOrder.name}",
        supCategoryId: supCategoryId,
        minPrice: filterData.startPrice,
        maxPrice: filterData.endPrice == filterData.maxPrice
            ? null
            : filterData.endPrice,
        minRate: filterData.startRate,
        maxRate: filterData.endRate,
        minMostRequest: filterData.startRequests,
        maxMostRequest: filterData.endRequests == filterData.maxRequests
            ? null
            : filterData.endRequests,
        minTopSelling: filterData.startSales,
        maxTopSelling: filterData.endSales == filterData.maxSales
            ? null
            : filterData.endSales,
        fromDate: filterData.startYearOffset != null
            ? DateTime(firstYear + filterData.startYearOffset!)
            : null,
        toDate: filterData.endYearOffset != null
            ? DateTime(firstYear + filterData.endYearOffset!, 12, 31)
            : null,
      ),
    );
  }

  Future<Result<AppErrors, List<ProductItemEntity>>> returnData(
      int unit) async {
    //
    // return storCubit.getPagination(GetProductsParam(
    //   MaxResultCount: MaxResultCount,
    //   SkipCount: unit * 10,
    //   Search: search,
    //   Sorting: sorting?.name == null
    //       ? null
    //       : "${sorting!.name} ${sortingOrder.name}",
    //   supCategoryId: supCategoryId,
    //   minPrice: filterData.startPrice,
    //   maxPrice: filterData.endPrice == filterData.maxPrice
    //       ? null
    //       : filterData.endPrice,
    //   minRate: filterData.startRate,
    //   maxRate: filterData.endRate,
    //   minMostRequest: filterData.startRequests,
    //   maxMostRequest: filterData.endRequests == filterData.maxRequests
    //       ? null
    //       : filterData.endRequests,
    //   minTopSelling: filterData.startSales,
    //   maxTopSelling: filterData.endSales == filterData.maxSales
    //       ? null
    //       : filterData.endSales,
    //   fromDate: filterData.startYearOffset != null
    //       ? DateTime(firstYear + filterData.startYearOffset!)
    //       : null,
    //   toDate: filterData.endYearOffset != null
    //       ? DateTime(firstYear + filterData.endYearOffset!, 12, 31)
    //       : null,
    // ));
    final result = await getIt<GetProductsListUseCase>()(GetProductsParam(
      MaxResultCount: MaxResultCount,
      SkipCount: unit * 10,
      Search: search,
      Sorting: sorting?.name == null
          ? null
          : "${sorting!.name} ${sortingOrder.name}",
      supCategoryId: supCategoryId,
      minPrice: filterData.startPrice,
      maxPrice: filterData.endPrice == filterData.maxPrice
          ? null
          : filterData.endPrice,
      minRate: filterData.startRate,
      maxRate: filterData.endRate,
      minMostRequest: filterData.startRequests,
      maxMostRequest: filterData.endRequests == filterData.maxRequests
          ? null
          : filterData.endRequests,
      minTopSelling: filterData.startSales,
      maxTopSelling: filterData.endSales == filterData.maxSales
          ? null
          : filterData.endSales,
      fromDate: filterData.startYearOffset != null
          ? DateTime(firstYear + filterData.startYearOffset!)
          : null,
      toDate: filterData.endYearOffset != null
          ? DateTime(firstYear + filterData.endYearOffset!, 12, 31)
          : null,
    ));

    return Result<AppErrors, List<ProductItemEntity>>(
        data: result.data!.items, error: result.error);
  }

  void onDataFetched(List<ProductItemEntity> items, int nextUnit) {
    ProductInSupcategory = items;
    notifyListeners();
  }

  void changeSorting(SortingType? newSorting) {
    _sorting = newSorting;
    SkipCount = 0;
    notifyListeners();
    getSingleCategory();
  }

  void changeFilter(bool isFilter) {
    _filter = isFilter;
    if(isFilter == false){
      filterData = oldFilterData;
    }
    notifyListeners();
    getSingleCategory();
  }

  void onSortingReset() {
    changeSorting(null);
  }

  void onFilterReset() {
    changeFilter(false);
  }

  // void changeFilter(bool price, bool rate, bool date) {}

  onFavorite(int index, bool favorite) {
    ProductInSupcategory![index].isFavorite = favorite;
    notifyListeners();
  }

  @override
  void closeNotifier() {
    storCubit.close();
    this.dispose();
  }

  void onSortingOrderChanged() {
    if (_sortingOrder == SortingOrder.ASC)
      _sortingOrder = SortingOrder.DESC;
    else
      _sortingOrder = SortingOrder.ASC;
    SkipCount = 0;
    getSingleCategory();
    notifyListeners();
  }

  void onApplyFilterTap(BottomSheetProductFilterData p1) {
    filterData = p1;
    changeFilter(true);
    getSingleCategory();
    notifyListeners();
  }
}

class Product {
  final String image;
  final String name;
  final String shopName;
  final String shopIcon;
  bool isFavorite;

  Product(
      {required this.image,
      required this.name,
      required this.shopIcon,
      required this.shopName,
      required this.isFavorite});
}
