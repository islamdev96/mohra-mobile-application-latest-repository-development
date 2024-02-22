import 'package:flutter/material.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/params/singleStore_params.dart';
import 'package:starter_application/features/shop/data/model/request/shops_list_param.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';
import 'package:starter_application/features/shop/domain/entity/prodcuts_list_entity.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';

class SearchScreenNotifier extends ScreenNotifier {
  late BuildContext context;
  final storCubit = ShopCubit();
  var controller = TextEditingController();
  String? search;
  List<ProductItemEntity>? ProductSearch;
  List<ShopEntity>? storeSearch;

  void getSearch() {
    storCubit.getSearch(
        ShopsListParam(
            keyword: search ?? '',
            skipCount: 0,
            maxResultCount: 20),
        GetProductsParam(
            SkipCount: 0,
            Search: search ?? '',
            MaxResultCount: 40));
  }

  void closeNotifier() {
    storCubit.close();
    this.dispose();
  }

  onFavorite(int index, bool favorite) {
    ProductSearch![index].isFavorite = favorite;
  }
}
