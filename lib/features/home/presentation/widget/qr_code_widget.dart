import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';
import 'package:starter_application/generated/l10n.dart';

class QrCodeWidget extends StatelessWidget {
  const QrCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildQRcode(context);
  }

  Widget _buildQRcode(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 40.h, left: 40.w, right: 40.w),
            child: Container(
              height: 0.5.sh,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 90.w, top: 50.h, bottom: 40.h),
                    child: CustomListTile(
                      title: Text(
                        "${UserSessionDataModel.fullName}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 55.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        UserSessionDataModel.getUserCityStreet(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 40.sp,
                        ),
                      ),
                      leading: ProfilePic(
                        width: 150.h,
                        height: 150.h,
                        imageUrl: UserSessionDataModel.imageUrl,
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
                  if (context.watch<SessionData>().userId != null)
                    Expanded(
                      child: Center(
                        child: BarcodeWidget(
                          data: UserSessionDataModel.qrCode ?? '',
                          barcode: Barcode.qrCode(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40.h, left: 40.w, right: 40.w),
            child: Container(
                height: 150.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: SvgPicture.asset(
                          AppConstants.SVG_lampQR,
                        ),
                      ),
                      Text(
                        Translation.current.show_qr_code_message,
                        style: TextStyle(color: Colors.white),
                      )
                    ])),
          ),
        ],
      ),
    );
  }
}
