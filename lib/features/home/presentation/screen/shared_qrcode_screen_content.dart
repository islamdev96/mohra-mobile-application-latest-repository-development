import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';

import '../screen/../state_m/provider/shared_qrcode_screen_notifier.dart';

class SharedQrcodeScreenContent extends StatefulWidget {
  @override
  State<SharedQrcodeScreenContent> createState() =>
      _SharedQrcodeScreenContentState();
}

class _SharedQrcodeScreenContentState extends State<SharedQrcodeScreenContent> {
  late SharedQrcodeScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SharedQrcodeScreenNotifier>(context);
    sn.context = context;
    return Padding(
      padding: EdgeInsets.only(bottom: 40.h, left: 40.w, right: 40.w),
      child: Container(
        height: 1100.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 90.w, top: 50.h, bottom: 40.h),
              child: CustomListTile(
                title: Text(
                  sn.params.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 55.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  sn.params.location,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 40.sp,
                  ),
                ),
                leading: ProfilePic(
                  width: 150.h,
                  height: 150.h,
                  imageUrl: sn.params.image,
                ),
                leadingFlex: 3,
              ),
            ),
            const Text(
              '---------------------------------------------',
              style: TextStyle(color: Colors.grey),
            ),
            // Gaps.vGap32,
            // Container(
            //     height: 300.h, child: Image.asset(AppConstants.IMG_barcode)),
            // Gaps.vGap64,
            // Container(
            //     height: 300.h, child: Image.asset(AppConstants.IMG_qrcode)),
            Expanded(
              child: Center(
                child: BarcodeWidget(
                  data: sn.params.qrcode,
                  barcode: Barcode.qrCode(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
