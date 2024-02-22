import 'package:flutter/material.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/id_param.dart';
import 'package:starter_application/features/shop/data/model/request/shops_list_param.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/following_shop_comments_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_store_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class FollowingScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final followedShopsCubit = ShopCubit();
  final followStoreCubit = ShopCubit();
  List<ShopEntity> _shops = [];

  /// Getters and Setters
  List<ShopEntity> get shops => this._shops;

  set shops(List<ShopEntity> value) => this._shops = value;

  /// Methods

  void getFollowedShops() {
    followedShopsCubit.getShops(ShopsListParam(
      onlyFollowingShops: true,
    ));
  }
  void onFollowUnFollowStoreTap(ShopEntity shop) {
    if (!(shop.isFollowed))
      followStoreCubit.followShop(
        IdParam(id: shop.id ?? -1),
      );
    else {
      followStoreCubit.unFollowShop(
        IdParam(id: shop.id ?? -1),
      );
    }
  }
  @override
  void closeNotifier() {
    followedShopsCubit.close();
    followStoreCubit.close();
    this.dispose();
  }

  void onShopTap(ShopEntity shop) {
    Nav.to(SingleStorePage.routeName,
        arguments: SingleStorePageParam(sliders: [], topStore: shop));
  }

  void onCommentsTapped(int id){
    Nav.to(FollowingShopCommentsScreen.routeName , arguments: id).then((value) {
      getFollowedShops();
    });
  }
}
