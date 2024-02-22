import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/event_location_screen_params.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/event/presentation/screen/event_location_screen.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart' as w;
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
class EventInfoWidget extends StatelessWidget {
  final EventEntity eventEntity;

  const EventInfoWidget({Key? key, required this.eventEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInfoRow(
            isNetwork: true,
            title: Text(
              eventEntity.organizer?.userName ?? '',
              style: TextStyle(
                  color: AppColors.black_text,
                  fontWeight: FontWeight.w500,
                  fontSize: 45.sp),
            ),
            subtitle: Translation.of(context).event_organizer,
            image: eventEntity.organizer?.imageUrl ?? ''),
        if (eventEntity.eventType == 0 || eventEntity.eventType == 2)
          SizedBox(
            height: 40.w,
          ),
        if (eventEntity.eventType == 0 || eventEntity.eventType == 2)
          _buildInfoRow(
            title: Text.rich(
              TextSpan(
                  text: '${Translation.current.SAR}' +
                      (eventEntity.price ?? 0).toStringAsFixed(0) +
                      '/' +
                      Translation.of(context).seat,
                  children: <InlineSpan>[
                    TextSpan(
                        text: '   ' +
                            eventEntity.availableSeats.toString() +
                            '/' +
                            eventEntity.totalSeats.toString() +
                            ' ' +
                            Translation.of(context).available_seat,
                        style: const TextStyle(
                            color: AppColors.mansourDarkOrange3)),
                  ]),
              style: TextStyle(
                  color: AppColors.black_text,
                  fontWeight: FontWeight.w500,
                  fontSize: 45.sp),
            ),
            subtitle: Translation.of(context).ticket_purchased_on_apps,
            image: AppConstants.IMG_EVENT_TICKET,
          ),
        SizedBox(
          height: 40.w,
        ),
        _buildInfoRow(
            title: Text(
              eventEntity.fromDate != null
                  ? _generateEventPeriod(
                      from: eventEntity.fromDate!, to: eventEntity.toDate)
                  : '',
              style: TextStyle(
                  color: AppColors.black_text,
                  fontWeight: FontWeight.w500,
                  fontSize: 45.sp),
            ),
            subtitle:
    DateTimeHelper.dateTo12Format((eventEntity.schedules??[]).length > 0 ? DateTime.tryParse(eventEntity.schedules!.first.fromHour!)!.toLocal() :eventEntity.fromHour!.toLocal()).toString()
           +
                    '  -  ' +
                    DateTimeHelper.dateTo12Format((eventEntity.schedules??[]).length > 0 ? DateTime.tryParse(eventEntity.schedules!.first.toHour!)!.toLocal() :eventEntity.toHour!.toLocal()).toString(),
            image: AppConstants.IMG_EVENT_DATE),
        SizedBox(
          height: 40.w,
        ),
        eventEntity.eventType == 4
            ? _buildInfoRow(
                title: Text(Translation.current.online_event),
                subtitle: Translation.current.view_on_link,
                image:  AppConstants.IMG_EVENT_LOCATION,
               /* button: CustomMansourButton(
                  onPressed: () async{
                    _launchInBrowser(eventEntity.link);
                  },
                  textSize: 35.sp,
                  padding: EdgeInsets.all(8.w),
                  titleText: Translation.of(context).go,
                )*/
              )
            : _buildInfoRow(
                title: Text(
                  eventEntity.cityName,
                  style: TextStyle(
                      color: AppColors.black_text,
                      fontWeight: FontWeight.w500,
                      fontSize: 45.sp),
                ),
                subtitle: eventEntity.placeName,
                image: AppConstants.IMG_EVENT_LOCATION,
                button: eventEntity.latitude != null &&
                        eventEntity.longitude != null
                    ? CustomMansourButton(
                        onPressed: () {
                          openMap(eventEntity.latitude!,
                              eventEntity.longitude!);

                        },
                        textSize: 35.sp,
                        padding: EdgeInsets.all(8.w),
                        titleText: Translation.of(context).view_map,
                      )
                    : null),
      ],
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await w.launch(
      url,
    )) {
      throw 'Could not launch $url';
    }
  }


  Widget _buildInfoRow({
    required Text title,
    required String subtitle,
    required String image,
    bool isNetwork = false,
    Widget? button,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: isNetwork
              ? CustomNetworkImageWidget(
                  width: 130.w,
                  height: 130.w,
                  imgPath: image,
                )
              : Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: 130.w,
                  height: 130.w,
                ),
        ),
        SizedBox(
          width: 40.w,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.w,
              ),
              title,
              SizedBox(
                height: 10.w,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: AppColors.accentColorLight,
                  fontSize: 40.sp,
                ),
                maxLines: 2,
              ),
              button != null
                  ? Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        SizedBox(height: 70.w, width: 200.w, child: button),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }

  String _generateEventPeriod({
    required DateTime from,
    DateTime? to,
  }) {
    print('aaaaaaaaaa');
    print(from);
    print(to);
    String result;
    if (to != null) {
      String fromDay = from.day.toString();
      String toDay = to.day.toString();
      String fromMonth = DateFormat('MM').format(from);
      String toMonth = DateFormat('MM').format(from);
      String fromYear = from.year.toString();
      String toYear = to.year.toString();

      bool sameDay = fromDay == toDay;
      bool sameMonth = fromMonth == toMonth;
      bool sameYear = fromYear == toYear;
      if (sameDay && !sameMonth && !sameYear)
        result = DateFormat('EEE, d MMM yyyy').format(from);
      else if (sameMonth)
        result = DateFormat('EEE, d').format(from) +
            ' - ' +
            DateFormat('EEE, d MMM').format(to);
      else if (sameYear)
        result = DateFormat('EEE, d, MMM').format(from) +
            ' - ' +
            DateFormat('EEE, d MMM yyyy').format(to);
      else
        result = DateFormat('EEE, d MMM yyyy').format(from) +
            ' - ' +
            DateFormat('EEE, d MMM yyyy').format(to);
    } else
      result = DateFormat('EEE, d MMM yyyy').format(from);
    return result;
  }
}
Future<void> openMap(double latitude, double longitude) async {
String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
if (await canLaunch(googleUrl)) {
await launch(googleUrl);
} else {
throw 'Could not open the map.';
}
}