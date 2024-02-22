import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/features/messages/presentation/widgets/loading_message_widget.dart';
import 'package:starter_application/features/shop/domain/entity/slider_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/favorite_products/favorite_products_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_store_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/shop_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/widgets/custom_shop_app_bar.dart';
import 'package:starter_application/features/shop/presentation/widgets/shop_home_grid_view.dart';
import 'package:starter_application/features/shop/presentation/widgets/slider_shop_home_page.dart';
import 'package:starter_application/generated/l10n.dart';

class ShopHomeScreen extends StatefulWidget {
  static const routeName = "/ShopHomeScreen";

  const ShopHomeScreen({Key? key}) : super(key: key);

  @override
  _ShopHomeScreenState createState() => _ShopHomeScreenState();
}

class _ShopHomeScreenState extends State<ShopHomeScreen> {
  final ShopHomeScreenNotifier sn = ShopHomeScreenNotifier();
  List<ItemEntity> slider = [];
  List<ShopCategory> categories = [
    ShopCategory(
        name: Translation.current.store,
        image: "assets/images/png/temp/shop_image_1.png"),
    ShopCategory(
        name: Translation.current.home_services,
        image: "assets/images/png/temp/shop_image_4.png"),
    ShopCategory(
        name: Translation.current.booking,
        image: "assets/images/png/temp/shop_image_8.png"),
  ];

  Future<bool> _willPopCallback() async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppMainScreen.routeName,
      (route) => false,
    );
    // await showDialog or Show add banners or whatever
    // then
    return true; // return true if the route to be popped
  }

  @override
  void initState() {
    sn.getSliderStore();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShopHomeScreenNotifier>.value(
      value: sn,
      builder: (context, child) {
        context.watch<ShopHomeScreenNotifier>();
        return OrientationBuilder(
          builder: (context, _) {
            return BlocConsumer<ShopCubit, ShopState>(
              bloc: sn.storeCubit,
              builder: (context, state) {
                return WillPopScope(
                  onWillPop: _willPopCallback,
                  child: Scaffold(
                    backgroundColor: AppColors.mansourLightGreyColor_6,
                    appBar: AppBar(
                      backgroundColor: AppColors.mansourLightGreyColor_6,
                      elevation: 0.0,
                      title: Container(
                        height: 100.h,
                        width: 0.9.sw,
                        child: ShopSearchTextField(
                          hint: Translation.current.search,
                          suffix: const Icon(Icons.search),
                          hintSize: 14,
                        ),
                      ),
                      leadingWidth: 66,
                      leading: InkWell(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppMainScreen.routeName,
                              (route) => false,
                            );
                          },
                          child:  Icon(
                            AppConstants.getIconBack(),
                            color: Colors.black,
                          )),
                      // actions: [
                      //   InkWell(
                      //     onTap: () => Nav.to(
                      //       FavoriteProductsScreen.routeName,
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: SizedBox(
                      //         height: 70.h,
                      //         width: 70.h,
                      //         child: SvgPicture.asset(
                      //             AppConstants.SVG_SHOP_FAVOURITE),
                      //       ),
                      //     ),
                      //   )
                      // ],
                    ),
                    body: (state is ShopLoadingState)
                        ? WaitingWidget()
                        : _buildBody(),
                  ),
                );
              },
              listener: (context, state) {
                if (state is SliderImagesLoaded) {
                  slider = state.slider.result!.items!;
                  print("sliders$slider");
                  setState(() {});
                }
                if (state is GetSingleStoreSuccess) {
                  Nav.to(
                    SingleStorePage.routeName,
                    arguments: SingleStorePageParam(
                      topStore: state.shopEntity,
                      sliders: [],
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(slider.isNotEmpty)
          ShopSlider(
            imageSlider: slider,
            onSendToParent: (id) {
              print(id);
              sn.getSingleStore(id);
            },
          ),
          if(slider.isEmpty)
          Gaps.vGap64,
          _buildShopGrid(),



        ],
      ),
    );
  }

  Widget _buildShopGrid() {
    return ShopGridView(shopCategory: categories);
  }

// Widget _buildShopTrendingCard(
//     {required String title, required String title2, required Widget child}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Padding(
//         padding: AppConstants.screenPadding,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 50.sp,
//               ),
//             ),
//             Text(
//               title2,
//               style: TextStyle(
//                 color: AppColors.mansourBackArrowColor2,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 35.sp,
//               ),
//             ),
//           ],
//         ),
//       ),
//       Gaps.vGap12,
//       child,
//     ],
//   );
// }
}
