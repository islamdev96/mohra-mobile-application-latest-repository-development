// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:starter_application/core/common/app_colors.dart';
// import 'package:starter_application/core/common/style/gaps.dart';
// import 'package:starter_application/core/constants/app/app_constants.dart';
// import 'package:starter_application/core/navigation/nav.dart';
// import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
// import 'package:starter_application/core/ui/mansour/search_textfield.dart';
// import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
// import 'package:starter_application/features/religion/presentation/state_m/provider/find_mosque_screen_notifier.dart';
// import 'package:starter_application/features/religion/presentation/widget/nearby_mosque_list/nearby_mosque_list.dart';
// import 'package:starter_application/features/shop/presentation/screen/categories_screen.dart';
// import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
// import 'package:starter_application/features/shop/presentation/state_m/provider/booking_services_screen_notifier.dart';
// import 'package:starter_application/features/shop/presentation/state_m/provider/shop_screen_notifier.dart';
// import 'package:starter_application/features/shop/presentation/widgets/slider_shop_home_page.dart';
// import 'package:starter_application/features/shop/presentation/widgets/top_category.dart';
// import 'package:starter_application/features/shop/presentation/widgets/trending_row.dart';

// class HomeScreenContent extends StatefulWidget {
//   @override
//   State<HomeScreenContent> createState() => _HomeScreenContentState();
// }

// List<ShopCategory> topCategories = [
//   ShopCategory(
//       name: "Kids Fashion", image: "assets/images/png/temp/kidsFashion.png"),
//   ShopCategory(name: "Interior", image: "assets/images/png/temp/interior.png"),
//   ShopCategory(
//       name: "Smartphone", image: "assets/images/png/temp/smartphone.png"),
//   ShopCategory(name: "Book", image: "assets/images/png/temp/book.png"),
// ];
// List<ShopCategory> topStore = [
//   ShopCategory(name: "", image: "assets/images/png/temp/chanel.png"),
//   ShopCategory(name: "", image: "assets/images/png/temp/zaraStor1.png"),
//   ShopCategory(name: "", image: "assets/images/png/temp/sony.png"),
//   ShopCategory(name: "", image: "assets/images/png/temp/smosh.jpg"),
// ];

// class _HomeScreenContentState extends State<HomeScreenContent> {
//   late ShopScreenNotifier sn;

//   @override
//   Widget build(BuildContext context) {
//     sn = Provider.of<ShopScreenNotifier>(context);
//     sn.context = context;
//     return _buildBody();
//   }

//   Widget _buildBody() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           BlocBuilder<ShopCubit, ShopState>(
//             bloc: sn.storCubit,
//             builder: (context, state) {
//               return state.map(
//                   shopInitState: (s) => WaitingWidget(),
//                   shopLoadingState: (s) => WaitingWidget(),
//                   shopErrorState: (s) => ErrorScreenWidget(
//                         error: s.error,
//                         callback: s.callback,
//                       ),
//                   shopImagesLodedState: (s) => const ShopSlider());
//             },
//           ),
//           _buildShopTrendingCard(
//             title: "Top Category",
//             title2: "view all",
//             isCategory: true,
//             child: TopCategory(
//               height: 400.h,
//               itemWidth: 600.w,
//               topCategories: topCategories,
//             ),
//           ),
//           _buildShopTrendingCard(
//             title: "Top Store",
//             title2: "view all",
//             isCategory: false,
//             child: TopCategory(
//               height: 250.h,
//               itemWidth: 600.w,
//               topCategories: topStore,
//               isStore: true,
//             ),
//           ),
//           _buildShopTrendingCard(
//             title: "Top Seller Products",
//             title2: "view all",
//             isCategory: false,
//             child: TrendingProduct(
//               height: 700.h,
//               itemWidth: 600.w,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildShopTrendingCard(
//       {required String title,
//       required String title2,
//       required Widget child,
//       required bool isCategory}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: AppConstants.screenPadding,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 50.sp,
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   if (isCategory) Nav.to(CategoriesScreen.routeName);
//                 },
//                 child: Text(
//                   title2,
//                   style: TextStyle(
//                     color: AppColors.mansourBackArrowColor2,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 35.sp,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Gaps.vGap12,
//         child,
//       ],
//     );
//   }
// }
