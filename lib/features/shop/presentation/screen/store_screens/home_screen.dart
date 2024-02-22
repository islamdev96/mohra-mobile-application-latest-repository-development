import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/shop/domain/entity/prodcuts_list_entity.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';
import 'package:starter_application/features/shop/domain/entity/slider_entity.dart';
import 'package:starter_application/features/shop/domain/entity/topCategory_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/favorite_products/favorite_products_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/search_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_category_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_store_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/top_stories_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/home_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/widgets/shop_widget.dart';
import 'package:starter_application/features/shop/presentation/widgets/slider_stor_home_page.dart';
import 'package:starter_application/features/shop/presentation/widgets/top_category.dart';
import 'package:starter_application/features/shop/presentation/widgets/trending_row.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../home/presentation/state_m/provider/app_main_screen_notifier.dart';
import '../categories_screen.dart';

class StoreHomePage extends StatefulWidget {
  static const routeName = "/StoreHomePage";

  const StoreHomePage({Key? key}) : super(key: key);

  @override
  _StoreHomePageState createState() => _StoreHomePageState();
}

class _StoreHomePageState extends State<StoreHomePage> {
  final sn = ShopScreenNotifier();
  late SliderEntity sliderEntity;
  late TopCategoryEntity topCategoryEntity;
  late ShopsListEntity topStoreEntity;
  late ProductsListEntity topProductsEntity;

  @override
  void initState() {
    sliderEntity = SliderEntity();
    topCategoryEntity = TopCategoryEntity();
    topStoreEntity = ShopsListEntity();
    topProductsEntity = ProductsListEntity();
    super.initState();
    sn.getHomeStore();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShopScreenNotifier>.value(
        value: sn,
        builder: (context, child) {
          context.watch<ShopScreenNotifier>();
          return OrientationBuilder(
            builder: (context, _) {
              return Scaffold(
                backgroundColor: AppColors.mansourLightGreyColor_6,
                appBar: AppBar(
                  backgroundColor: AppColors.mansourLightGreyColor_6,
                  elevation: 0.0,
                  title: InkWell(
                    onTap: () => Nav.to(SearchPage.routeName),
                    child: Container(
                      height: 100.h,
                      width: 0.9.sw,
                      decoration: BoxDecoration(
                          color: AppColors.mansourLightGreyColor_2,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: AppColors.mansourLightGreyColor_5,
                              style: BorderStyle.solid)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Expanded(
                              child: Icon(Icons.search, color: Colors.grey)),
                          Expanded(
                            flex: 4,
                            child: Text(
                              Translation.of(context).search,
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // leadingWidth: 66,
                  leading: InkWell(
                      onTap: () {
                        context
                            .read<AppMainScreenNotifier>()
                            .controller!
                            .jumpTo(0);
                        Nav.pop();
                      },
                      child: Icon(
                        AppConstants.getIconBack(),
                        color: Colors.black,
                      )),
                  actions: [
                    InkWell(
                      onTap: () => Nav.to(
                        FavoriteProductsScreen.routeName,
                      ).then((value) {
                        sn.getHomeStore();
                      }),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 70.h,
                          width: 70.h,
                          child:
                              SvgPicture.asset(AppConstants.SVG_SHOP_FAVOURITE),
                        ),
                      ),
                    )
                  ],
                ),
                body: SingleChildScrollView(
                  child: _buildBody(),
                ),
              );
            },
          );
        });
  }

  Widget _buildBody() {
    return BlocListener<ShopCubit, ShopState>(
      bloc: sn.storCubit,
      listener: (context, state) {
        if (state is GetSingleStoreSuccess) {
          Nav.to(
            SingleStorePage.routeName,
            arguments: SingleStorePageParam(
              topStore: state.shopEntity,
              sliders: [],
            ),
          );
        }
        if (state is HomeStoreLodedState) {
          sliderEntity = state.sliderEntity;
          sn.products = state.topProductsEntity.items ?? [];
          topStoreEntity = state.topStoreEntity;
          topCategoryEntity = state.topCategoryEntity;
          sn.notifyListeners();
        }
      },
      child: BlocBuilder<ShopCubit, ShopState>(
        bloc: sn.storCubit,
        builder: (context, state) {
          return state.maybeMap(
            shopInitState: (s) => Column(
              children: [
                SizedBox(
                  height: 0.40.sh,
                ),
                WaitingWidget()
              ],
            ),
            addingToCart: (s) => Column(
              children: [
                SizedBox(
                  height: 0.40.sh,
                ),
                WaitingWidget()
              ],
            ),
            shopLoadingState: (s) => Column(
              children: [
                SizedBox(
                  height: 0.40.sh,
                ),
                WaitingWidget()
              ],
            ),
            storeCategoryLodedState: (s) => Container(),
            shopErrorState: (s) => ErrorScreenWidget(
              error: s.error,
              callback: s.callback,
            ),
            homeStoreLodedState: (s) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 0.80.sh,
                  child: TrendingProduct(
                    firstChild: Column(
                      children: [
                        if ((s.sliderEntity.result?.items?.length ?? 0) > 0)
                          ShopSliderStore(
                            imageSlider: s.sliderEntity.result!.items!,
                            onSendToParent: (id) {
                              print(id);
                              sn.getSingleStore(id);
                            },
                          ),
                        Gaps.vGap64,
                        TopCategoryWidget(
                          onBack: () {
                            sn.getHomeStore();
                          },
                          height: 170.h,
                          itemWidth: 600.w,
                          top: s.topCategoryEntity.items!
                              .map((e) => TopCategory(
                                    id: e.id!,
                                    imageUrl: e.imageUrl,
                                    companyName: e.name,
                                    // length: s.topCategoryEntity.items!.length,
                                  ))
                              .toList(),
                        ),
                        Gaps.vGap64,
                        _buildShopTrendingCard(
                          title: Translation.of(context).Top_Stores,
                          list: s.topStoreEntity.items,
                          title2: Translation.of(context).view_all,
                          isCategory: false,
                          isProduct: false,
                          isTopStore: true,
                          child: ShopWidget(
                            height: 250.h,
                            itemWidth: 600.w,
                            top: s.topStoreEntity.items ?? [],
                            imageSlider: s.sliderEntity.result!.items!,
                          ),
                          onBack: () {
                            // sn.getHomeStore();
                          },
                        ),
                        Padding(
                          padding: AppConstants.screenPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Translation.of(context).Top_Seller_Products,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.sp,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Nav.to(SingleCategoryScreen.routeName)
                                      .then((value) {
                                    sn.getHomeStore();
                                  });
                                },
                                child: Text(
                                  Translation.of(context).view_all,
                                  style: TextStyle(
                                    color: AppColors.mansourBackArrowColor2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gaps.vGap12,
                      ],
                    ),
                    height: 600.w,
                    itemWidth: 500.w,
                    onBack: () {
                      sn.getHomeStore();
                    },
                    top: s.topProductsEntity.items!,
                    sn: sn,
                  ),
                ),
                SizedBox(
                  height: 0.25.sh,
                ),
              ],
            ),
            singleStoreLodedState: (s) => Container(),
            searchLodedState: (s) => Container(),
            getProductsLoaded: (s) => Container(),
            productItemLodedState: (s) => Container(),
            getSingleStoreSuccess: (s) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 0.80.sh,
                    child: TrendingProduct(
                      firstChild: Column(
                        children: [
                          if ((sliderEntity.result?.items?.length ?? 0) > 0)
                            ShopSliderStore(
                              imageSlider: sliderEntity.result!.items!,
                              onSendToParent: (id) {
                                print(id);
                                sn.getSingleStore(id);
                              },
                            ),
                          Gaps.vGap64,
                          TopCategoryWidget(
                            onBack: () {
                              sn.getHomeStore();
                            },
                            height: 170.h,
                            itemWidth: 600.w,
                            top: topCategoryEntity.items!
                                .map((e) => TopCategory(
                                      id: e.id!,
                                      imageUrl: e.imageUrl,
                                      companyName: e.name,
                                      // length: s.topCategoryEntity.items!.length,
                                    ))
                                .toList(),
                          ),
                          Gaps.vGap64,
                          _buildShopTrendingCard(
                            title: Translation.of(context).Top_Stores,
                            list: topStoreEntity.items,
                            title2: Translation.of(context).view_all,
                            isCategory: false,
                            isProduct: false,
                            isTopStore: true,
                            child: ShopWidget(
                              height: 250.h,
                              itemWidth: 600.w,
                              top: topStoreEntity.items ?? [],
                              imageSlider: sliderEntity.result!.items!,
                            ),
                            onBack: () {
                              // sn.getHomeStore();
                            },
                          ),
                          Padding(
                            padding: AppConstants.screenPadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Translation.of(context).Top_Seller_Products,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40.sp,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Nav.to(SingleCategoryScreen.routeName)
                                        .then((value) {
                                      sn.getHomeStore();
                                    });
                                  },
                                  child: Text(
                                    Translation.of(context).view_all,
                                    style: TextStyle(
                                      color: AppColors.mansourBackArrowColor2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gaps.vGap12,
                        ],
                      ),
                      height: 600.w,
                      itemWidth: 500.w,
                      onBack: () {
                        sn.getHomeStore();
                      },
                      top: topProductsEntity.items!,
                      sn: sn,
                    ),
                  ),
                  SizedBox(
                    height: 0.25.sh,
                  ),
                ],
              ),
            ),
            orElse: () => const ScreenNotImplementedError(),
            reviewProductLodedState: (s) => Container(),
          );
        },
      ),
    );
  }

  Widget _buildShopTrendingCard(
      {required String title,
      List<ShopEntity>? list,
      required String title2,
      required Widget child,
      required bool isCategory,
      required bool isTopStore,
      required bool isProduct,
      required Function onBack}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppConstants.screenPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
              if (!isTopStore)
                InkWell(
                  onTap: () {
                    if (isProduct)
                      Nav.to(SingleCategoryScreen.routeName).then((value) {
                        onBack();
                      });
                    if (isCategory)
                      Nav.to(CategoriesScreen.routeName).then((value) {
                        onBack();
                      });
                    if (isTopStore)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TopStoriesScreen(
                                  sn: sn,
                                )), // Notice that i send the Picked date in
                      ).then((value) {
                        onBack();
                      });
                  },
                  child: Text(
                    title2,
                    style: TextStyle(
                      color: AppColors.mansourBackArrowColor2,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Gaps.vGap12,
        child,
      ],
    );
  }
}
