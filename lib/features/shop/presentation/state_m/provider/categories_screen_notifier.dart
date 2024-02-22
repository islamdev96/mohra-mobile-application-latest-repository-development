import 'package:flutter/material.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/shop/data/model/request/get_shop_category_params.dart';
import 'package:starter_application/features/shop/domain/entity/storeCategory_entity.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class CategoriesScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late final TabController tabController;

  final storCubit = ShopCubit();

  void getStorecategorys() {
    storCubit.getStorecategorys(GetShopCategoryParams(id: null,isAllCategory: true));
  }

  void closeNotifier() {
    storCubit.close();
    this.dispose();
  }
}
