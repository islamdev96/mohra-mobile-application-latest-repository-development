import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/event_location_screen_params.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/features/event/domain/entity/event_ticket_entity.dart';
import 'package:starter_application/features/event/presentation/screen/event_location_screen.dart';
import 'package:starter_application/features/event/presentation/widget/event_ticket_cut_widget.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class EventTicketDetailsWidget extends StatelessWidget {
  final EventTicketEntity ticket;
  final double Price;
  final BuildContext? con;
  late LatLng? myLocation;
   EventTicketDetailsWidget({Key? key, required this.ticket, this.con , this.Price =0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(25.r)),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            _buildCutWidget(con ?? context),
            _buildContent(con ?? context),
          ],
        ),
      ),
    );
  }

  Widget _buildCutWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Spacer(
          flex: 2,
        ),
        SizedBox(
          height: 75.w,
          width: 1.sw,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: 1.sw,
                  height: 50.w,
                  child: EventTicketCutWidget(
                    circleDiameter: 50.w,
                    borderColor: AppColors.transparent,
                    cutColor: AppColors.mansourDarkPurple,
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 75.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(40.r),
                    border: Border.all(color: AppColors.black),
                  ),
                  child: Text(
                    ticket.number,
                    style: const TextStyle(color: AppColors.black_text),
                  ),
                ),
              )
            ],
          ),
        ),
        const Spacer(
          flex: 5,
        )
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: (2 / 7.5) * constraints.maxHeight,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BarcodeWidget(
                data: ticket.qrCode,
                barcode: Barcode.qrCode(),
              ),
            )),
          ),
          SizedBox(
            height: 75.w,
          ),
          SizedBox(
            height: (4 / 7) * constraints.maxHeight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 60.w,
                      ),
                      child: Container(
                        width: 1.sw,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Translation.current.name,
                              style: TextStyle(
                                  color: AppColors.mansourWhiteBackgrounColor_6,
                                  fontSize: 50.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              ticket.name,
                              style: TextStyle(
                                  color: AppColors.black_text,
                                  fontSize: 55.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height:30.h,
                            ),
                            Text(
                              Translation.current.price,
                              style: TextStyle(
                                  color: AppColors.mansourWhiteBackgrounColor_6,
                                  fontSize: 50.sp),
                            ),

                            Text(
                              '${ticket.price}',
                              style: TextStyle(
                                  color: AppColors.black_text,
                                  fontSize: 55.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Text(
                              Translation.current.event,
                              style: TextStyle(
                                  color: AppColors.mansourWhiteBackgrounColor_6,
                                  fontSize: 50.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),

                            Text(
                              ticket.event?.title ?? '',
                              maxLines: 2,
                              style: TextStyle(
                                  color: AppColors.black_text,
                                  fontSize: 55.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            if (ticket.event?.link != '') ...[
                              Text(
                                Translation.current.link,
                                style: TextStyle(
                                    color:
                                        AppColors.mansourWhiteBackgrounColor_6,
                                    fontSize: 50.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  launch(ticket.event!.link);
                                },
                                child: Text(
                                  ticket.event?.link ?? '',
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: AppColors.blueFontColor,
                                      fontSize: 55.sp,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            SizedBox(
                              height: 30.h,
                            ),
                            if(ticket.event?.placeName != '')...{
                              Text(
                                Translation.current.place_name,
                                style: TextStyle(
                                    color:
                                    AppColors.mansourWhiteBackgrounColor_6,
                                    fontSize: 50.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                ticket.event?.placeName ?? '',
                                maxLines: 2,
                                style: TextStyle(
                                    color: AppColors.black_text,
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            },
                            if(ticket.event?.cityName != '')...{
                              Text(
                                Translation.current.city,
                                style: TextStyle(
                                    color:
                                    AppColors.mansourWhiteBackgrounColor_6,
                                    fontSize: 50.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                ticket.event?.cityName ?? '',
                                maxLines: 2,
                                style: TextStyle(
                                  color: AppColors.mansourWhiteBackgrounColor_6,
                                  fontSize: 50.sp,
                                ),
                              ),
                            },
                            SizedBox(
                              height: 30.h,
                            ),
                           if( ticket.event!.eventType != 4)
                                CustomMansourButton(
                                    titleText: Translation.current.view_on_map,
                                    height: 50,
                                    onPressed: () {
                                      if (ticket.event?.latitude != null &&
                                          ticket.event?.longitude != null)
                                        launchGoogleLocation(context);
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 60.h,
                      thickness: 2.h,
                      color: AppColors.mansourLightGreyColor,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 60.w,
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Translation.current.type,
                                    style: TextStyle(
                                        color: AppColors
                                            .mansourWhiteBackgrounColor_6,
                                        fontSize: 50.sp),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    getTicketTypeName(ticket.type ?? 0),
                                    style: TextStyle(
                                        color: AppColors.black_text,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50.sp),
                                  ),

                                ],
                              ),
                              SizedBox(
                                width: 0.5.sw,
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Translation.current.date,
                                      style: TextStyle(
                                          color: AppColors
                                              .mansourWhiteBackgrounColor_6,
                                          fontSize: 50.sp),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      ticket.date != null
                                          ? DateFormat('EEE, MMM dd, yyyy')
                                              .format(ticket.date!.toLocal())
                                          : '',
                                      style: TextStyle(
                                          color: AppColors.black_text,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.sp),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      ticket.date != null
                                          ? DateFormat('hh:mm a')
                                              .format(ticket.date!.toLocal())
                                          : '',
                                      style: TextStyle(
                                          color: AppColors.black_text,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  launchGoogleLocation(BuildContext context) async {
    String url = '';
    await getLocation(context);
    MapUtils.openMap(ticket.event?.latitude??0,ticket.event?.longitude??0);
    // if (Platform.isAndroid) {
    //   await getLocation(context);
    //   print('aaaaa');
    //   print(myLocation?.latitude);
    //   print(myLocation?.longitude);
    //   print(ticket.event?.latitude);
    //   print(ticket.event?.longitude);
    //   url =
    //       'https://www.google.com/maps/dir/?api=1&origin=${myLocation?.latitude},${myLocation?.longitude}&destination=${ticket.event?.latitude},${ticket.event?.longitude}';
    //   print(url);
    //
    //   launch(url);
    //
    // }
    // else if (Platform.isIOS) {
    //   await getLocation(context);
    //   String mapOptions = [
    //     'saddr=${myLocation?.latitude},${myLocation?.longitude}',
    //     'daddr=${ticket.event?.latitude},${ticket.event?.longitude}',
    //     'dir_action=navigate'
    //   ].join('&');
    //
    //   //url = 'https://www.google.com/maps?$mapOptions';
    //   url = 'https://maps.apple.com/?sll=${ticket.event?.latitude},${ticket.event?.longitude}';
    //   //url = 'comgooglemaps:${ticket.event?.latitude},${ticket.event?.longitude}';
    //   if(await canLaunch(url)){
    //     launch(url);
    //   }
    // }
    // else {}
  }

  getLocation(BuildContext context) async {
    ProgressHUD.of(context)?.show();
    final location = await getUserLocationLogic(
        onBackTap: () {
          Nav.pop();
        },
        onRetryTap: () {
          getLocation(context);
          Nav.pop();
        },
        withoutDialogue: true);
    ProgressHUD.of(context)?.dismiss();
    if(location != null){
      myLocation = location;
    }

  }
}
class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}