import 'package:flutter/cupertino.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/shop/data/model/request/get_single_shop_params.dart';
import 'package:starter_application/features/shop/data/model/request/get_slider_images_param.dart';
import 'package:starter_application/features/shop/data/model/request/shops_list_param.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

class ShopHomeScreenNotifier extends ScreenNotifier {
  late BuildContext context;
  final storeCubit = ShopCubit();

  void getSliderStore() {
    storeCubit.getSliderImages(
      GetSliderImagesParam(),
    );
  }

  void getSingleStore(id) {
    storeCubit.getSingleShop(SingleShopParams(id: id));
  }

  @override
  void closeNotifier() {
    storeCubit.close();
  }
}

class ShopCategory {
  final String image;
  final String name;

  ShopCategory({required this.image, required this.name});
}
