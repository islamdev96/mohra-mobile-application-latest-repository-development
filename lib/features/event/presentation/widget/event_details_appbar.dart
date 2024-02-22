import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/dynamic_links.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/user_type.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/event/presentation/screen/ticket_qrCode_screen.dart';

class EventDetailsAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final int? eventId;
  final VoidCallback onTicketQrCodeScanned;

  const EventDetailsAppbar(
      {Key? key,
      required this.title,
      required this.onTicketQrCodeScanned,
      this.eventId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 50.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppBar(
            elevation: 0,
            foregroundColor: AppColors.black_text,
            titleSpacing: 0,
            backgroundColor: AppColors.transparent,
            leading: InkWell(
                onTap: () {
                  Nav.pop();
                },
                child: Icon(
                  AppConstants.getIconBack(),
                  color: Colors.black,
                )),
            // shadowColor: AppColors.transparent,
            title: Container(
              width: 0.6.sw,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 60.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              eventId != null
                  ? IconButton(
                      onPressed: () {
                        _shareEvent(eventId.toString());
                      },
                      icon: const Icon(
                        Icons.share,
                        color: AppColors.black_text,
                      ))
                  : const SizedBox.shrink(),
              UserSessionDataModel.userType == UserType.EventOrganizer
                  ? IconButton(
                      splashRadius: 50.h,
                      onPressed: () {
                        Nav.to(
                          TicketQrCodeScreen.routeName,
                          arguments: TicketQrCodeScreenParam(
                              onDispose: onTicketQrCodeScanned,
                              eventId: eventId ?? 0),
                        );
                      },
                      icon: const Icon(
                        Icons.qr_code_scanner,
                        color: AppColors.black_text,
                      ))
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }

  void _shareEvent(String id) async {
    DynamicLinkService dynamicLinkService = DynamicLinkService();
    Uri uri = await dynamicLinkService.createDynamicLink(
        queryParameters: {'id': id},
        type: AppConstants.KEY_DYNAMIC_LINKS_EVENT);
    FlutterShare.share(
      title: uri.toString(),
      linkUrl: uri.toString(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(150.h);
}
