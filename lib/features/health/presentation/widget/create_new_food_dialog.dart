// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:starter_application/core/common/style/gaps.dart';
// import 'package:starter_application/core/constants/app/app_constants.dart';
// import 'package:starter_application/core/navigation/nav.dart';
// import 'package:starter_application/features/health/presentation/screen/create_calories/create_calories_screen.dart';
// import 'package:starter_application/features/health/presentation/screen/create_food/create_food_screen.dart';
// import 'package:starter_application/generated/l10n.dart';
//
// void showCreateFoodDialog(BuildContext context, int foodType) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return Dialog(
//         alignment: Alignment.bottomCenter,
//         insetPadding: EdgeInsets.only(
//           bottom: 200.h,
//           left: 40,
//           right: 40,
//         ),
//         backgroundColor: Colors.white,
//         child:  CreateFoodDialog(foodType: foodType,),
//       );
//     },
//   );
// }
//
// class CreateFoodDialog extends StatelessWidget {
//   int foodType;
//
//   CreateFoodDialog({
//     this.foodType = 0,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(20.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(
//           30.r,
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _buildCard(
//             title: Translation.of(context).Create_Simple_Calories,
//             icon: AppConstants.SVG_CALORIES,
//             onTap: () {
//               Nav.to(
//                 CreateCaloriesScreen.routeName,
//                 arguments: foodType,
//               );
//             },
//           ),
//           Gaps.vGap4,
//           _buildCard(
//             title: Translation.of(context).Create_Food,
//             icon: AppConstants.SVG_VEGAN_FOOD,
//             onTap: () {
//               Nav.to(
//                 CreateFoodScreen.routeName,
//               );
//             },
//           ),
//           Gaps.vGap4,
//           _buildCard(
//             title: Translation.of(context).Create_Recipe,
//             icon: AppConstants.SVG_RECIPE,
//             onTap: () {},
//           ),
//           Gaps.vGap4,
//           _buildCard(
//             title: Translation.of(context).Create_Meal,
//             icon: AppConstants.SVG_MEAL,
//             onTap: () {},
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCard({
//     required String title,
//     required String icon,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: SizedBox(
//         child: SvgPicture.asset(icon),
//       ),
//       minLeadingWidth: 50.w,
//       title: Text(
//         title,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 40.sp,
//         ),
//       ),
//       onTap: onTap,
//     );
//   }
// }
