// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:starter_application/core/common/app_colors.dart';
// import 'package:starter_application/core/common/app_config.dart';
// import 'package:starter_application/core/constants/app/app_constants.dart';
// import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
// import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
// import 'package:starter_application/features/favorite/data/model/request/create_favorite_params.dart';
// import 'package:starter_application/features/favorite/data/model/request/delete_favorites_by_ref_params.dart';
// import 'package:starter_application/features/favorite/presentation/state_m/cubit/favorite_cubit.dart';
// import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
// import 'package:starter_application/features/shop/presentation/state_m/provider/product_favorite.dart';
//
// class ProductFavoriteButton extends StatefulWidget {
//   final ProductItemEntity product;
//   final Widget? icon;
//   final Function(bool isFavorite)? onIsFavoriteChanged;
//   const ProductFavoriteButton({
//     Key? key,
//     required this.product,
//     this.onIsFavoriteChanged,
//     this.icon,
//   }) : super(key: key);
//
//   @override
//   State<ProductFavoriteButton> createState() => _ProductFavoriteButtonState();
// }
//
// class _ProductFavoriteButtonState extends State<ProductFavoriteButton> {
//   FavoriteCubit _favoriteCubit = FavoriteCubit();
//   final favoriteProvider = AppConfig().appContext.read<ProductFavorite>();
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _favoriteCubit.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(widget.product.id);
//     context.watch<ProductFavorite>();
//     return Container(
//         child: BlocConsumer<FavoriteCubit, FavoriteState>(
//       bloc: _favoriteCubit,
//       builder: (context, state) => state.maybeMap(
//           favoriteInitState: (value) => _buildWidget(),
//           favoriteLoadingState: (value) => WaitingWidget(),
//           favoriteErrorState: (value) => _buildWidget(),
//           createFavoriteSuccessState: (value) => _buildWidget(),
//           deleteFavoriteSuccessState: (value) => _buildWidget(),
//           orElse: SizedBox.shrink),
//       listener: (context, state) => state.mapOrNull(
//         createFavoriteSuccessState: (value) {
//           widget.onIsFavoriteChanged?.call(true);
//           favoriteProvider.add(widget.product);
//         },
//         deleteFavoriteSuccessState: (value) {
//           widget.onIsFavoriteChanged?.call(false);
//           favoriteProvider.remove(widget.product);
//         },
//         favoriteErrorState: (value) => ErrorViewer.showError(
//             context: context, error: value.error, callback: value.callback),
//       ),
//     ));
//   }
//
//   Widget _buildWidget() {
//     // if (widget.icon != null)
//     //   return InkWell(onTap: _addToFav, child: widget.icon!);
//     return ClipOval(
//       child: Container(
//         height: 100.h,
//         width: 100.h,
//         decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
//         child: GestureDetector(
//           // onTap: _addToFav,
//           onTap: (){},
//           child: Center(
//             child: SizedBox(
//               height: 55.h,
//               width: 55.h,
//               child: SvgPicture.asset(
//                 AppConstants.SVG_LOVE,
//                 color: AppColors.white,
//                 // color: favoriteProvider.isInFavorite(widget.product.id!)
//                 //     ? AppColors.mansourLightRed
//                 //     : AppColors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // void _addToFav() {
//   //   if (widget.product.id == null) return;
//   //   !favoriteProvider.isInFavorite(widget.product.id!)
//   //       ? _favoriteCubit.createFavorites(CreateFavoriteParams(
//   //           refId: widget.product.id.toString(), refType: 1))
//   //       : _favoriteCubit.deleteFavoriteByRef(
//   //           DeleteFavoriteByRefParams(
//   //             refId: widget.product.id!,
//   //             refType: 1,
//   //           ),
//   //         );
//   // }
// }
