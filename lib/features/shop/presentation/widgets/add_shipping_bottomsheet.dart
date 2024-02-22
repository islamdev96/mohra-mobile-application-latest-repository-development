import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/cart_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

void AddShippingBottomSheet({
  required BuildContext context,
  // required VoidCallback onNav,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return BottomSheet(
        builder: (BuildContext context) {
          return AddToCartBottomSheet(
            // onPress: onNav,
          );
        },
        onClosing: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              40.r,
            ),
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: 1.sh,
        ),
      );
    },
    isScrollControlled: true,
    isDismissible: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          40.r,
        ),
      ),
    ),
    constraints: BoxConstraints(
      maxHeight: 0.6.sh,
    ),
  );
}

class AddToCartBottomSheet extends StatelessWidget {
  // final List<ShippingMethod> shippingMethod;

  // final VoidCallback onPress;

   AddToCartBottomSheet({Key? key})
      : super(key: key);
  late SessionData session =
  Provider.of<SessionData>(AppConfig().appContext, listen: false);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7.sh,
      padding: EdgeInsets.only(
        left: 70.h,
        right: 70.h,
        top: 70.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            40.r,
          ),
        ),
      ),
      child: Column(
        children: [
          /// Title and  dismiss button
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Nav.pop();
                },
                icon: SizedBox(
                  height: 80.h,
                  width: 80.h,
                  child: SvgPicture.asset(
                    AppConstants.SVG_CLOSE,
                    color: Colors.black,
                  ),
                ),
              ),
              Gaps.hGap32,
              Text(
                Translation.current.choose_shipping_method,
                style: TextStyle(
                    fontSize: 45.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 50.h,
                bottom: 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildItem(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildCard(index);
                          },
                          separatorBuilder: (context, index) {
                            return Gaps.vGap64;
                          },
                          itemCount: session.getSettingModel?.shippingMethods?.length??0,
                        ),
                      ],
                    ),
                    icon: AppConstants.SVG_CLIPBOARD_CHECK,
                  ),
                  Gaps.vGap64,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildCard(int index) {
    final item = session.getSettingModel!.shippingMethods![index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            AppConstants.shipping = item.id??1;
            Nav.pop();
          },
          child: CustomListTile(
            backgroundColor: AppColors.mansourWhiteBackgrounColor_5,
            borderRadius: BorderRadius.circular(
              30.r,
            ),
            padding: const EdgeInsets.all(
              15,
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(
                20.r,
              ),
              child: Container(
                height: 150.h,
                width: 150.h,
                color: Colors.white,
                child: Image.network(
                  item.image??"",
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            title: Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: 20.h,
                start: 35.w,
              ),
              child: Text(
                (AppConfig().isLTR? item?.nameEn??" " : item?.nameAr??" ") +"( ${item?.maniDuration??0} - ${item?.maxDuration??0} )",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 37.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: 20.h,
                start: 35.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppConfig().isLTR? item?.descriptionEn??" " : item?.descriptionAr??" " ,
                    style: TextStyle(
                      color: AppColors.mansourLightGreyColor_3,
                      fontSize: 37.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    (item.fee??0).toString(),
                    style: TextStyle(
                      color: AppColors.primaryColorLight,
                      fontSize: 35.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem({
    required String icon,
    String? titleText,
    Widget? title,
    Color? iconColor,
    double? iconSize,
    TextStyle? textStyle,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 30.w,
            ),
            title == null
                ? Text(
                    titleText ?? "",
                    style: textStyle ??
                        TextStyle(
                          color: Colors.black,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                : Expanded(child: title),
          ],
        ),
      ),
    );
  }
}
