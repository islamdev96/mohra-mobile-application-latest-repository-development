import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/provider/cart.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/cart_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/widgets/cart_item.dart';
import 'package:starter_application/generated/l10n.dart';

class SelectItemCard extends StatelessWidget {
  final CartProduct product;
  final double height;
  final double? width;
  final Color? color;
  final TextStyle? titleStyle;
  final double? bottomPadding;
  final VoidCallback? onTap;
  final CartScreenNotifier sn;

  const SelectItemCard({
    Key? key,
    required this.product,
    this.height = 100,
    this.width,
    this.color,
    this.titleStyle,
    this.bottomPadding,
    this.onTap,
    required this.sn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (product.productImage == "")
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 75.h,
                  width: 75.h,
                  child: InkWell(
                    onTap: onTap,
                    /* child: SvgPicture.asset(
                      isSelected
                          ? AppConstants.SVG_CHECKED
                          : AppConstants.SVG_UNCHECKED,
                    ), */
                  ),
                ),
                Gaps.hGap32,
                Text(
                  Translation.current.select_all_items,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        if (product.productImage != "")
          InkWell(
            onTap: onTap,
            child: CartProductWidget(
              product: product,

            ),
          ),
      ],
    );
  }
}
