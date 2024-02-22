import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/enums/shipping_address_type_enum.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/myaddress_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

class MyAddressScreenContent extends StatefulWidget {
  @override
  State<MyAddressScreenContent> createState() => _MyAddressScreenContentState();
}

class _MyAddressScreenContentState extends State<MyAddressScreenContent> {
  late MyAddressScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<MyAddressScreenNotifier>(context);
    sn.context = context;
    return ModalProgressHUD(
      inAsyncCall: sn.isLoading,
      child: SingleChildScrollView(
        child: Column(
          children: [_buildAddress(), _buildAddAddress()],
        ),
      ),
    );
  }

  _buildAddress() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildAddressItem(
            shippingAddressTypeName(
                mapIdToShippingAddressType(sn.addresses[index].addressType)),
            sn.addresses[index].streetAddress,
            index);
      },
      separatorBuilder: (context, index) {
        return Gaps.vGap8;
      },
      itemCount: sn.addresses.length,
    );
  }

  _buildAddressItem(String name, String title, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 50.h),
      child: InkWell(
        onTap: () {
          sn.onSelectAddress(index);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                  color: sn.selectedAddressIndex == index
                      ? AppColors.primaryColorLight
                      : Colors.white)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 75.h,
                              width: 75.h,
                              // child: SvgPicture.asset(
                              //     sn.selectedAddressIndex == index
                              //         ? AppConstants.SVG_CHECKED
                              //         : AppConstants.SVG_UNCHECKED),
                              child: InkWell(
                                onTap: () => sn.onDeleteAddressTap(index),
                                child: Icon(
                                  Icons.delete,
                                  color: AppColors.mansourLightRed,
                                  size: 75.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gaps.hGap64,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  fontSize: 45.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => sn.onEditAddressTap(
                            sn.addresses[index],
                          ),
                          child: Text(
                            Translation.current.edit,
                            style: TextStyle(
                                fontSize: 45.sp,
                                color: AppColors.primaryColorLight,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 120.w,
                  ),
                  child: Row(
                    children: [
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
                                title,
                                style: const TextStyle(
                                  color: AppColors.black_text,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildAddAddress() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 50.h),
      child: SlidingAnimated(
        initialOffset: 5,
        intervalStart: 0.5,
        intervalEnd: 0.6,
        child: CustomMansourButton(
          borderRadius: Radius.circular(20.r),
          height: 90.h,
          borderColor: AppColors.primaryColorLight,
          backgroundColor: Colors.white,
          titleText: Translation.current.add_other_address,
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          titleStyle:
              TextStyle(fontSize: 40.sp, color: AppColors.primaryColorLight),
          onPressed: sn.onAddAddressTap,
        ),
      ),
    );
  }
}
