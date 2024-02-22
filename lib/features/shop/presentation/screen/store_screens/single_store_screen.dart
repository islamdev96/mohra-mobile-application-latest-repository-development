import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numeral/numeral.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/flutter_rating_bar.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/news/presentation/state_m/provider/single_category_screen_notifier.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/domain/entity/reviews_entity.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';
import 'package:starter_application/features/shop/domain/entity/slider_entity.dart';
import 'package:starter_application/features/shop/domain/entity/storeCategory_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/create_reviewStore/reviewStore_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/search_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/single_store_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/widgets/product_grid_view.dart';
import 'package:starter_application/features/shop/presentation/widgets/slider_stor_home_page.dart';
import 'package:starter_application/features/shop/presentation/widgets/store_dropdown.dart';
import 'package:starter_application/features/shop/presentation/widgets/store_grid.dart';
import 'package:starter_application/features/shop/presentation/widgets/store_sorting_dropdown.dart';
import 'package:starter_application/generated/l10n.dart';

class SingleStorePageParam {
  final ShopEntity topStore;
  final List<ItemEntity> sliders;

  SingleStorePageParam({
    required this.topStore,
    required this.sliders,
  });
}

class SingleStorePage extends StatefulWidget {
  final SingleStorePageParam param;
  static const routeName = "/SingleStorePage";

  const SingleStorePage({
    Key? key,
    required this.param,
  }) : super(key: key);

  @override
  _SingleStorePageState createState() => _SingleStorePageState();
}

class _SingleStorePageState extends State<SingleStorePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final sn = SingleStoreNotifier();

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    sn.shop = widget.param.topStore;
    sn.getHomeStore();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SingleStoreNotifier>.value(
        value: sn,
        builder: (context, child) {
          context.watch<SingleStoreNotifier>();
          return Scaffold(
            backgroundColor: AppColors.mansourLightGreyColor_6,
            body: SafeArea(
              child: BlocListener<ShopCubit, ShopState>(
                bloc: sn.followStoreCubit,
                listener: (context, state) {
                  state.whenOrNull(
                    followShopSuccess: () {
                      showSnackbar(
                        Translation.current.follow_shop_success,
                      );
                      sn.shop = sn.shop.copyWith(
                          followersCount: (sn.shop.followersCount ?? 0) + 1,
                          isFollowed: true);
                      widget.param.topStore.followersCount = sn.shop.followersCount;
                      widget.param.topStore.isFollowed = sn.shop.isFollowed;
                    },
                    unFollowShopSuccess: () {
                      showSnackbar(
                        Translation.current.un_follow_shop_success,
                      );
                      sn.shop = sn.shop.copyWith(
                          followersCount: (sn.shop.followersCount ?? 0) - 1,
                          isFollowed: false);
                      widget.param.topStore.followersCount = sn.shop.followersCount;
                      widget.param.topStore.isFollowed = sn.shop.isFollowed;
                    },
                    shopErrorState: (error, callback) => ErrorViewer.showError(
                      context: context,
                      error: error,
                      callback: callback,
                    ),
                  );
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 0.4.sh,
                        width: 1.sw,
                        child: Stack(
                          children: [
                            _buildHeader1(),
                            _buildHeader2(widget.param.topStore.coverUrl),
                            _buildSearchHeader(),
                            _buildProfile(
                              sn.shop.logoUrl,
                              sn.shop.name,
                              sn.shop.followersCount,
                            ),
                          ],
                        ),
                      ),
                      Gaps.vGap32,
                      BlocConsumer<ShopCubit, ShopState>(
                        bloc: sn.storCubit,
                        listener: (context , state){
                          state.mapOrNull(
                              getProductsLoaded: (s){
                                print('asasadssd');
                              },
                              singleStoreLodedState: (s){
                                sn.topProducts = s.topProductsEntity.items!;
                                sn.Products = s.ProductsEntity.items!;
                                sn.ReviewStore = s.reviewsEntity.items!;
                                sn.SkipCount = s.topProductsEntity.items!.length;
                                sn.SkipCountProducts = s.ProductsEntity.items!.length;
                                // sn.getShopCategories();
                              },
                              storeCategoryLodedState: (s){
                                // sn.onGetCategoriesDone(s.storeCategoryEntity);
                              }
                          );
                        },
                        builder: (context, state) {
                          return state.maybeMap(
                            shopInitState: (s) => WaitingWidget(),
                            shopLoadingState: (s) => WaitingWidget(),
                            storeCategoryLodedState: (s) {
                              return SizedBox(
                                height: 0.55.sh,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: TabBarView(
                                          controller: tabController,
                                          children: [
                                            PaginationWidget<ProductItemEntity>(
                                              getItems: sn.getProductTopItems,
                                              scrollDirection: Axis.vertical,
                                              items: sn.topProducts,
                                              onDataFetched: sn.onHomeTabItemsFetched,
                                              enablePullUp: true,
                                              enablePullDown: true,
                                              refreshController: sn.refreshController1,
                                              child: SingleChildScrollView(
                                                physics: const NeverScrollableScrollPhysics(),
                                                child: Column(
                                                  children: [
                                                    // if (widget.param.sliders.length > 0)
                                                    //   Container(
                                                    //     child: ShopSliderStore(
                                                    //       imageSlider: widget.param.sliders,
                                                    //     ),
                                                    //   ),
                                                    _buildShopTrendingCard(
                                                      title: Translation.of(context).Top_Seller_Products,
                                                      child: _buildGrid(sn.topProducts),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            PaginationWidget<ProductItemEntity>(
                                              getItems: sn.getProductItems,
                                              items: sn.Products,
                                              onDataFetched: sn.onProductItemsFetched,
                                              enablePullUp: true,
                                              enablePullDown: true,
                                              refreshController: sn.refreshController2,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    // Padding(
                                                    //   padding: EdgeInsets.only(right: 100.w, left: 80.w, top: 30.h),
                                                    //   child: Row(
                                                    //     children: [
                                                    //       Expanded(
                                                    //           child: _buildDropDown2(
                                                    //             hint: Translation.current.sort,
                                                    //             items: ["A", "Z"],
                                                    //           )),
                                                    //       Gaps.hGap32,
                                                    //       Expanded(
                                                    //           flex: 2,
                                                    //           child: _buildDropDown(
                                                    //             hint: Translation.current.product_category,
                                                    //             items: sn.storeCategoryEntity.items ?? [],
                                                    //           )),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    _buildShopTrendingCard(
                                                      title: "",
                                                      child: _buildGrid(sn.Products),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            _buildReviewTab(
                                                widget.param.topStore.rate ?? 0,
                                                widget.param.topStore.ratings ?? {})
                                          ],
                                        ))
                                  ],
                                ),
                              );
                            },
                            shopErrorState: (s) => ErrorScreenWidget(
                              error: s.error,
                              callback: s.callback,
                            ),
                            reviewProductLodedState: (s) => Container(),
                            productItemLodedState: (s) =>Container(),
                            getProductsLoaded: (s) {
                              return SizedBox(
                                height: 0.55.sh,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: TabBarView(
                                          controller: tabController,
                                          children: [
                                            PaginationWidget<ProductItemEntity>(
                                              getItems: sn.getProductTopItems,
                                              scrollDirection: Axis.vertical,
                                              items: sn.topProducts,
                                              onDataFetched: sn.onHomeTabItemsFetched,
                                              enablePullUp: true,
                                              enablePullDown: true,
                                              refreshController: sn.refreshController1,
                                              child: SingleChildScrollView(
                                                physics: const NeverScrollableScrollPhysics(),
                                                child: Column(
                                                  children: [
                                                    // if (widget.param.sliders.length > 0)
                                                    //   Container(
                                                    //     child: ShopSliderStore(
                                                    //       imageSlider: widget.param.sliders,
                                                    //     ),
                                                    //   ),
                                                    _buildShopTrendingCard(
                                                      title: Translation.of(context).Top_Seller_Products,
                                                      child: _buildGrid(sn.topProducts),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            PaginationWidget<ProductItemEntity>(
                                              getItems: sn.getProductItems,
                                              items: sn.Products,
                                              onDataFetched: sn.onProductItemsFetched,
                                              enablePullUp: true,
                                              enablePullDown: true,
                                              refreshController: sn.refreshController2,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    // Padding(
                                                    //   padding: EdgeInsets.only(right: 100.w, left: 80.w, top: 30.h),
                                                    //   child: Row(
                                                    //     children: [
                                                    //       Expanded(
                                                    //           child: _buildDropDown2(
                                                    //             hint: Translation.current.sort,
                                                    //             items: ["A", "Z"],
                                                    //           )),
                                                    //       Gaps.hGap32,
                                                    //       Expanded(
                                                    //           flex: 2,
                                                    //           child: _buildDropDown(
                                                    //             hint: Translation.current.product_category,
                                                    //             items: sn.storeCategoryEntity.items ?? [],
                                                    //           )),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    _buildShopTrendingCard(
                                                      title: "",
                                                      child: _buildGrid(sn.Products),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            _buildReviewTab(
                                                widget.param.topStore.rate ?? 0,
                                                widget.param.topStore.ratings ?? {})
                                          ],
                                        ))
                                  ],
                                ),
                              );
                            },
                            searchLodedState: (s) => Container(),
                            homeStoreLodedState: (s) => Container(),
                            singleStoreLodedState: (s) {
                              return SizedBox(
                                height: 0.55.sh,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: TabBarView(
                                          controller: tabController,
                                          children: [
                                            PaginationWidget<ProductItemEntity>(
                                              getItems: sn.getProductTopItems,
                                              scrollDirection: Axis.vertical,
                                              items: sn.topProducts,
                                              onDataFetched: sn.onHomeTabItemsFetched,
                                              enablePullUp: true,
                                              enablePullDown: true,
                                              refreshController: sn.refreshController1,
                                              child: SingleChildScrollView(
                                                physics: const NeverScrollableScrollPhysics(),
                                                child: Column(
                                                  children: [
                                                    // if (widget.param.sliders.length > 0)
                                                    //   Container(
                                                    //     child: ShopSliderStore(
                                                    //       imageSlider: widget.param.sliders,
                                                    //     ),
                                                    //   ),
                                                    _buildShopTrendingCard(
                                                      title: Translation.of(context).Top_Seller_Products,
                                                      child: _buildGrid(sn.topProducts),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                PaginationWidget<ProductItemEntity>(
                                  getItems: sn.getProductItems,
                                  items: sn.Products,
                                  onDataFetched: sn.onProductItemsFetched,
                                  enablePullUp: true,
                                  enablePullDown: true,
                                  refreshController: sn.refreshController2,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        // Padding(
                                        //   padding: EdgeInsets.only(right: 100.w, left: 80.w, top: 30.h),
                                        //   child: Row(
                                        //     children: [
                                        //       Expanded(
                                        //           child: _buildDropDown2(
                                        //             hint: Translation.current.sort,
                                        //             items: ["A", "Z"],
                                        //           )),
                                        //       Gaps.hGap32,
                                        //       Expanded(
                                        //           flex: 2,
                                        //           child: _buildDropDown(
                                        //             hint: Translation.current.product_category,
                                        //             items: sn.storeCategoryEntity.items ?? [],
                                        //           )),
                                        //     ],
                                        //   ),
                                        // ),
                                        _buildShopTrendingCard(
                                          title: "",
                                          child: _buildGrid(sn.Products),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                            _buildReviewTab(
                                                widget.param.topStore.rate ?? 0,
                                                widget.param.topStore.ratings ?? {})
                                          ],
                                        ))
                                  ],
                                ),
                              );
                            },
                            addingToCart: (s) => WaitingWidget(),
                            orElse: () => const ScreenNotImplementedError(),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  _buildHeader1() {
    return Container(
      width: 1.sw,
      height: 1.sh,
      color: AppColors.mansourLightGreyColor_6,
    );
  }

  _buildHeader2(coverUrl) {
    return Container(
      height: 500.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            coverUrl ?? "",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _buildSearchHeader() {
    return PositionedDirectional(
      top: 150.h,
      start: 40.w,
      end: 40.w,
      child: Container(
        height: 100.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  Nav.pop();
                },
                child:  Icon(
                  AppConstants.getIconBack(),
                  color: Colors.white,
                )),
            Gaps.hGap12,
            InkWell(
              onTap: () => Nav.to(SearchPage.routeName),
              child: SizedBox(
                width: 0.8.sw,
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
                    )),

                // const ShopSearchTextField(
                //   hint: "search something",
                //   suffix: Icon(
                //     Icons.search,
                //   ),
                //   hintSize: 14,
                // ),
              ),
            ),
            Gaps.hGap12,
            // InkWell(
            //   onTap: () {
            //     Nav.pop();
            //   },
            //   child: SvgPicture.asset(
            //     AppConstants.SVG_CHAT,
            //     height: 80.sp,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  _buildProfile(imageUrl, companyName, followersCount) {
    return PositionedDirectional(
      top: 400.h,
      start: 60.w,
      end: 60.w,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 50.0.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: Container(
                      height: 130.h,
                      width: 130.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        companyName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 45.sp),
                      ),
                      Text(
                          "${Numeral(followersCount ?? 0).format(fractionDigits: 0)} ${Translation.of(context).Followers}",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 45.sp,
                              color: Colors.grey[400])),
                    ],
                  ),

                  Column(
                    children: [
                      sn.shop.verified?Container(
                        width: 30,
                        height: 30,
                        child: Center(
                          child: Image.asset('assets/images/verified.png'),
                        ),
                      ):Container(),
                      Gaps.vGap24,
                      BlocBuilder<ShopCubit, ShopState>(
                        bloc: sn.followStoreCubit,
                        builder: (context, state) {
                          return state.maybeMap(
                            shopLoadingState: (_) => WaitingWidget(),
                            orElse: () => CustomMansourButton(
                              height: 90.h,
                              title: Text(
                                sn.shop.isFollowed
                                    ? Translation.current.un_follow
                                    : Translation.of(context).Follow_Store,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onPressed: sn.onFollowUnFollowStoreTap,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Gaps.vGap32,
              TabBar(
                onTap: (value) {
                  setState(() {});
                },
                indicatorColor: Colors.transparent,
                controller: tabController,
                labelStyle: TextStyle(
                  color: AppColors.mansourBackArrowColor2,
                  fontSize: 45.sp,
                  fontWeight: FontWeight.bold,
                ),
                labelColor: AppColors.primaryColorLight,
                unselectedLabelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelColor: Colors.grey,
                labelPadding: EdgeInsetsDirectional.only(
                  bottom: 64.h,
                  end: 90.w,
                ),
                isScrollable: true,
                tabs: [
                  getItem(
                      icon: AppConstants.SVG_HOME,
                      title: Translation.of(context).Home,
                      isColor: tabController.index == 0),
                  getItem(
                      icon: AppConstants.SVG_SHOP_VENDOR,
                      title: Translation.of(context).Product,
                      isColor: tabController.index == 1),
                  getItem(
                      icon: AppConstants.SVG_SHOP_STAR,
                      title: Translation.of(context).Review,
                      isColor: tabController.index == 2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildGrid(var product) {
    return StoreGridView(
      top: product,
      aspectRatio: 4 / 5,
    );
  }

  Widget _buildShopTrendingCard(
      {required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppConstants.screenPadding,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 50.sp,
            ),
          ),
        ),
        Gaps.vGap12,
        child,
      ],
    );
  }

  // _buildHomeTab() {
  //   return PaginationWidget<ProductItemEntity>(
  //     getItems: sn.returnDatatop,
  //     scrollDirection: Axis.vertical,
  //     items: sn.topProducts,
  //     onDataFetched: sn.onHomeTabItemsFetched,
  //     enablePullUp: true,
  //     enablePullDown: true,
  //     refreshController: sn.refreshController1,
  //     child: SingleChildScrollView(
  //       physics: const NeverScrollableScrollPhysics(),
  //       child: Column(
  //         children: [
  //           // if (widget.param.sliders.length > 0)
  //           //   Container(
  //           //     child: ShopSliderStore(
  //           //       imageSlider: widget.param.sliders,
  //           //     ),
  //           //   ),
  //           _buildShopTrendingCard(
  //             title: Translation.of(context).Top_Seller_Products,
  //             child: _buildGrid(sn.topProducts),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // _buildProductTab() {
  //   return PaginationWidget<ProductItemEntity>(
  //       getItems: sn.returnData,
  //       items: sn.Products,
  //       onDataFetched: sn.onProductItemsFetched,
  //       enablePullUp: true,
  //       enablePullDown: true,
  //       refreshController: sn.refreshController2,
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             // Padding(
  //             //   padding: EdgeInsets.only(right: 100.w, left: 80.w, top: 30.h),
  //             //   child: Row(
  //             //     children: [
  //             //       Expanded(
  //             //           child: _buildDropDown2(
  //             //             hint: Translation.current.sort,
  //             //             items: ["A", "Z"],
  //             //           )),
  //             //       Gaps.hGap32,
  //             //       Expanded(
  //             //           flex: 2,
  //             //           child: _buildDropDown(
  //             //             hint: Translation.current.product_category,
  //             //             items: sn.storeCategoryEntity.items ?? [],
  //             //           )),
  //             //     ],
  //             //   ),
  //             // ),
  //             _buildShopTrendingCard(
  //               title: "",
  //               child: _buildGrid(sn.Products),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  // }

  _buildReviewTab(double rate, Map<String, int> ratings) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStarsCard(rate, ratings),
            Gaps.vGap32,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Translation.of(context).Review,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: ()  {
                     Nav.to(
                        ReviewStorScreen.routeName,
                        arguments: widget.param).then((value) => sn.getHomeStore());
                  },
                  child: Text(
                    Translation.of(context).Review_Store,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColorLight),
                  ),
                ),
              ],
            ),
            Gaps.vGap16,
            for (int i = 0; i < sn.ReviewStore!.length; i++)
              _buildReviewCard(sn.ReviewStore![i]),
          ],
        ),
      ),
    );
  }

  _buildStarsCard(double rate, Map<String, int> ratings) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Translation.of(context).Overall_Review,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Gaps.vGap32,
                Text(
                  "${rate}",
                  style:
                  TextStyle(fontSize: 140.sp, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Gaps.hGap32,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.of(context).Professionalism,
                        style: const TextStyle(
                            color: AppColors.mansourLightGreyColor_11),
                      ),
                      Gaps.hGap15,
                      SmoothStarRating(
                        size: 40.sp,
                        isReadOnly: true,
                        rating: ratings['0']?.toDouble() ?? 0,
                      ),
                    ],
                  ),
                  Gaps.vGap16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.of(context).Wait_Time,
                        style: const TextStyle(
                            color: AppColors.mansourLightGreyColor_11),
                      ),
                      Gaps.hGap15,
                      SmoothStarRating(
                        size: 40.sp,
                        isReadOnly: true,
                        rating: ratings['1']?.toDouble() ?? 0,
                      ),
                    ],
                  ),
                  Gaps.vGap16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.of(context).Experience,
                        style: const TextStyle(
                            color: AppColors.mansourLightGreyColor_11),
                      ),
                      Gaps.hGap15,
                      SmoothStarRating(
                        size: 40.sp,
                        isReadOnly: true,
                        rating: ratings['2']?.toDouble() ?? 0,
                      ),
                    ],
                  ),
                  Gaps.vGap16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.of(context).Value,
                        style: const TextStyle(
                            color: AppColors.mansourLightGreyColor_11),
                      ),
                      Gaps.hGap15,
                      SmoothStarRating(
                        size: 40.sp,
                        isReadOnly: true,
                        rating: ratings['3']?.toDouble() ?? 0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropDown({
    required List<ItemStoreCategoryEntity> items,
    required String hint,
  }) {
    return StoreDropdown(
      items: items,
      hint: hint,
      onChangeId: (value){
        print(value);

      },
    );
  }

  Widget _buildDropDown2({
    required List<String> items,
    required String hint,
  }) {
    return StoreSortingDropdown(
      items: items,
      hint: hint,
    );
  }

  _buildReviewCard(ItemReviewsEntity review) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Container(
                    height: 100.h,
                    width: 100.h,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColorLight),
                    child: review.reviewer!.imageUrl! == ''
                        ? Icon(
                      Icons.person,
                      size: 75.h,
                      color: Colors.white,
                    )
                        : CustomNetworkImageWidget(
                      imgPath: review.reviewer!.imageUrl!,
                      width: 0.5.sw,
                      boxFit: BoxFit.contain,
                      height: 0.5.sw,
                    ),
                  ),
                ),
                Gaps.hGap32,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 0.6.sw,
                      child: Text(review.reviewer!.name!,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          review.creationTime.toString().split(' ')[0],
                          style: const TextStyle(
                              color: AppColors.mansourLightGreyColor_11),
                        ),
                        Gaps.hGap32,
                        SmoothStarRating(
                          size: 40.sp,
                          isReadOnly: true,
                          rating: review.rate!.toDouble(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Text(review.comment!),
            Gaps.vGap32,
            _buildReviewImage(review.images!),
          ],
        ),
      ),
    );
  }

  _buildReviewImage(List<dynamic> image) {
    return SizedBox(
      height: 0.1.sh,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _buildImageCard(index, image[index].toString());
          },
          separatorBuilder: (context, index) {
            return Gaps.hGap32;
          },
          itemCount: image.length),
    );
  }
}

_buildImageCard(int index, String image) {
  return Container(
      width: 200.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CustomNetworkImageWidget(
          imgPath: image,
          boxFit: BoxFit.cover,
        ),
      ));
}

Widget getItem(
    {required String icon, required String title, required bool isColor}) {
  return Container(
    height: 100.h,
    child: Row(
      children: [
        SvgPicture.asset(
          icon,
          height: 60.sp,
          color: isColor ? AppColors.primaryColorLight : Colors.grey,
        ),
        Gaps.hGap32,
        Text(title)
      ],
    ),
  );
}
