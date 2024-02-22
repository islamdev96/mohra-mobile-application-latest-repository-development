import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numeral/numeral.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/id_param.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/flutter_rating_bar.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/booking/presentation/state_m/provider/services_details_screen_notifier.dart';
import 'package:starter_application/features/event/presentation/widget/event_ads_widget.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_product_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/widgets/ProductFavoriteButton.dart';
import 'package:starter_application/features/shop/presentation/widgets/add_to_cart_button.dart';
import 'package:starter_application/features/shop/presentation/widgets/chose_color_widget.dart';
import 'package:starter_application/features/shop/presentation/widgets/product_item_widget.dart';
import 'package:starter_application/features/shop/presentation/widgets/single_product_slider.dart';
import 'package:starter_application/generated/l10n.dart';


class ServicesDetailsScreenContent extends StatefulWidget {
  final ValueChanged<bool>? onChange;
  const ServicesDetailsScreenContent({Key? key, this.onChange}) : super(key: key);
  @override
  State<ServicesDetailsScreenContent> createState() =>
      _ServicesDetailsScreenContentState();
}

class _ServicesDetailsScreenContentState
    extends State<ServicesDetailsScreenContent> {
  late ServicesDetailsScreenNotifier sn;
  final padding = EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h);
  bool isFavorite = false;
  bool anyUpdate = false;
  final storCubitFavorite = ShopCubit();
  

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ServicesDetailsScreenNotifier>(context);
    sn.context = context;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 0.4.sh,
                  child: Image.network("https://media.istockphoto.com/id/872361244/photo/man-getting-his-beard-trimmed-with-electric-razor.jpg?s=1024x1024&w=is&k=20&c=-5rC2g01SMHDEbCkU5hhpnrLodV4Xf4HMNWyGhk-k_4=",fit: BoxFit.cover,)),
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.6,color: AppColors.black),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppConstants.SVG_consStar),
                          Gaps.hGap8,
                          Text("4.7"),
                          Gaps.hGap16,
                          Text("32 reviews",style: TextStyle(color: AppColors.greyHelp2),),

                        ],
                      ),
                    ),
                    Gaps.hGap32,
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.6,color: AppColors.black),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppConstants.SVG_iconsCamera),
                          Gaps.hGap8,
                          Text("4"),
                        ],
                      ),
                    ),
                    Gaps.hGap32,
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.6,color: AppColors.black),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppConstants.SVG_Love),
                          Gaps.hGap8,
                          Text("12"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.vGap64,
              _buildDesc(),
              Gaps.vGap64,
              Container(
                color: Colors.white,
                child: Padding(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Details",
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
                          ),
                          Gaps.vGap16,
                        ],
                      ),
                      Wrap(
                        children: [
                          Text(
                            "The Truefitt & Hill Grooming Experience is a combination of our three signature treatments that will ensure that a gentleman leaves our barbershop perfectly groomed and refreshed",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Gaps.vGap256,
            ],
          ),
        ),
        _buildFooter()
      ],
    );
  }

  _buildHeader() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      Text(
                        "${Translation.current.SAR}",
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight:  FontWeight.normal,
                            fontSize: 25.sp,
                            decoration:  TextDecoration.none),
                      ),
                    Text(
                      " ${(100).toStringAsFixed(2)}",
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 35.sp,
                          decoration: TextDecoration.none),
                    ),
                  ],
                ),
                SvgPicture.asset(AppConstants.SVG_SHOP_FAVOURITE)

              ],
            ),
            Gaps.vGap16,
            Text(
              "Traditional Hot Towel Wet Shave Experience",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
            ),
            Gaps.vGap16,
          ],
        ),
      ),
    );
  }




  _buildDesc() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  Translation.of(context).Product_Descriptions,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
                ),
                Gaps.vGap16,
              ],
            ),
            Wrap(
              children: [
                Text(
                  "The Truefitt & Hill Grooming Experience is a combination of our three signature treatments that will ensure that a gentleman leaves our barbershop perfectly groomed and refreshed",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildProductInformation() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  Translation.of(context).Product_Information,
                  style:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 48.sp),
                ),
              ],
            ),
            Gaps.vGap24,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                   Translation.current.weight,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
                ),
                Text(
                  ('0') +
                      ' Kg',
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 45.sp),
                ),
              ],
            ),
            Gaps.vGap16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Translation.of(context).minimum_order,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 45.sp),
                ),
                Text(
                  '${"1"} pcs',
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 45.sp),
                ),
              ],
            ),
            Gaps.vGap16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 45.sp),
                ),
                Text(
                  "blazer",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 45.sp,
                      color: AppColors.primaryColorLight),
                ),
              ],
            ),
            Gaps.vGap16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                 "${Translation.of(context).conditions}",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 45.sp),
                ),
                Text(
                  '${Translation.of(context).New}',
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 45.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }





  _buildFooter() {
    return Positioned(
      bottom: 50.h,
      child: Container(
        width: 1.sw,
        child: Column(
          children: [
            Divider(),
            Gaps.vGap24,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.black.withOpacity(0.5))
                    ),
                    child: SvgPicture.asset(AppConstants.SVG_MESSAGE_SQUARE)),
                Gaps.hGap32,
                CustomMansourButton(title: Text("Add to cart"),onPressed: (){},width: 0.4.sw,backgroundColor: AppColors.white,borderColor: AppColors.black.withOpacity(0.5),),
                Gaps.hGap32,
                CustomMansourButton(title: Text("Book Now",style: TextStyle(color: AppColors.white),),onPressed: (){},width: 0.4.sw,),
              ],
            ),
            Gaps.vGap24,
          ],
        ),
      ),
    );
  }
}
