import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/provider/cart.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/cart_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

class CartProductWidget extends StatefulWidget {
  final CartProduct product;
  final bool isCart;

  const CartProductWidget({
    Key? key,
    this.isCart = false,
    required this.product,
  }) : super(key: key);

  @override
  State<CartProductWidget> createState() => _CartProductWidgetState();
}

class _CartProductWidgetState extends State<CartProductWidget> {
  final cart = AppConfig().appContext.read<Cart>();
  TextEditingController noteController = TextEditingController();
  bool visiableNote = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<Cart>();
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 40.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    /*  SizedBox(
                      height: 75.h,
                      width: 75.h,
                      child: SvgPicture.asset(
                        widget.isSelected
                            ? AppConstants.SVG_CHECKED
                            : AppConstants.SVG_UNCHECKED,
                      ),
                    ),
                    Gaps.hGap32, */
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        20.r,
                      ),
                      child: Container(
                        height: 120.h,
                        width: 120.h,
                        color: Colors.white,
                        child: Image.network(
                          widget.product.productImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      bottom: 20.h,
                      start: 35.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.productName,
                          style: const TextStyle(
                              color: AppColors.black_text,
                              fontWeight: FontWeight.w700),
                        ),
                        Gaps.vGap16,
                        Text(
                          Translation.current.SAR +" "+ widget.product.price.toStringAsFixed(2),
                          style: const TextStyle(
                              color: AppColors.primaryColorLight),
                        ),
                        Gaps.vGap32,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (widget.product.quantity > 1)
                                      cart.updateProduct(
                                        widget.product.productId,
                                        widget.product.price,
                                        widget.product.quantity - 1,
                                        keepPrevQuantity: false,
                                        showMessages: false,
                                      );
                                  },
                                  child: Container(
                                    height: 70.h,
                                    width: 70.h,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: AppColors.mansourLightGreyColor_2,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      color: AppColors.mansourLightGreyColor_3,
                                    ),
                                  ),
                                ),
                                Gaps.hGap16,
                                Container(
                                  width: 100.w,
                                  child: Center(
                                    child: Text(
                                      widget.product.quantity.toString(),
                                      style: TextStyle(
                                          fontSize: 50.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.red))),
                                ),
                                Gaps.hGap16,
                                InkWell(
                                  onTap: () async{
                                    bool isUpdate =await cart.updateProduct(
                                      widget.product.productId,
                                      widget.product.price,
                                      widget.product.quantity + 1,
                                      keepPrevQuantity: false,
                                      showMessages: false,
                                    );
                                    if(isUpdate == false){
                                      showSnackbar(AppConfig().isLTR ? "No modification has been made due to the allowed number":"لم يتم التعديل بسبب العدد المسموح");
                                    }
                                  },
                                  child: Container(
                                    height: 70.h,
                                    width: 70.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.mansourDarkOrange3
                                          .withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: AppColors.primaryColorLight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                cart.removeProduct(widget.product.productId,widget.product.price);
                              },
                              child: SizedBox(
                                height: 60.h,
                                width: 60.h,
                                child: SvgPicture.asset(
                                  AppConstants.SVG_TRASH,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      visiableNote = !visiableNote;
                    });
                  },
                  child: Text(
                    Translation.current.add_note_to_seller,
                    style: TextStyle(
                        color: AppColors.primaryColorLight, fontSize: 40.sp),
                  ),
                ),
              ],
            ),
            if (visiableNote)
              TextField(
                  controller: noteController,
                  onChanged: (value) {
                    cart.addNoteToProduct(
                      value,
                      widget.product.quantity - 1,
                    );
                  })
          ],
        ),
      ),
    );
  }
}
