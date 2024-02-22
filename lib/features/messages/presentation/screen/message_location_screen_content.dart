import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/custom_map/widget/custom_map.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/message_location_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

class MessageLocationScreenContent extends StatefulWidget {
  const MessageLocationScreenContent({
    Key? key,
  }) : super(key: key);
  @override
  State<MessageLocationScreenContent> createState() =>
      _MessageLocationScreenContentState();
}

class _MessageLocationScreenContentState
    extends State<MessageLocationScreenContent> {
  /// MapWidget varaiables
  double _sendLocationContainerHeight = 0.20.sh;
  late double _mapHeight;

  late MessageLocationScreenNotifier sn;

  @override
  void initState() {
    _mapHeight = 1.sh - _sendLocationContainerHeight;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<MessageLocationScreenNotifier>(context, listen: false)
        .setMarkers(context);
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<MessageLocationScreenNotifier>(context);
    sn.context = context;
    return Stack(
      children: [
        Positioned.fill(
          child: _buildCustomMap(),
        ),
        _buildSendLocationContainer(),
        _buildGpsIcon(),
      ],
    );
  }

  Widget _buildCustomMap() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(
        40.r,
      )),
      child: CustomMap(
        distanceInfoWindowEnabled: false,
        initialIndex: 0,
        mapApiKey: AppConstants.API_KEY_GOOGLE_MAPS,
        disableMyLocationPolylines: true,
        disableMyLocationIcon: false,
        disableMyLocationButton: true,
        markers: sn.markers,
        myLocationMarker: sn.myLocationMarker,
        onTap: (lat) {
          sn.onMapTap(lat);
        },
        height: _mapHeight,
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          target: sn.location,
          zoom: 15,
        ),
        onMapCreated: (controller) => sn.onMapCreated(context, controller),
      ),
    );
  }

  Widget _buildGpsIcon() {
    return PositionedDirectional(
      bottom: _sendLocationContainerHeight + 250.h,
      start: 60.w,
      child: Container(
        height: 100.h,
        width: 100.h,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Material(
            child: InkWell(
              onTap: () {
                sn.onGoToMyLocationTap();
              },
              child: Center(
                child: SizedBox(
                  height: 70.h,
                  width: 70.h,
                  child: SvgPicture.asset(
                    AppConstants.SVG_GPS,
                    color: AppColors.mansourLightBlueColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSendLocationContainer() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(
              50.r,
            ),
            topEnd: Radius.circular(
              50.r,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 60.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  sn.shareLiveLocation();
                },
                child: Row(
                  children: [
                    SizedBox(
                      height: 90.h,
                      width: 90.h,
                      child: SvgPicture.asset(
                        AppConstants.SVG_lIVE_LOCATION,
                      ),
                    ),
                    Gaps.hGap32,
                    Text(
                      Translation.current.share_live_location,
                      style: TextStyle(
                        color: AppColors.black_text,
                        fontWeight: FontWeight.bold,
                        fontSize: 45.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: AppColors.mansourLightGreyColor_2,
                thickness: 2,
                height: 100.h,
              ),
              if (sn.selectedPlacemark != null)
                InkWell(
                  onTap: () {
                    sn.onSave();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        height: 90.h,
                        width: 90.h,
                        child: SvgPicture.asset(
                          AppConstants.SVG_LOCATION,
                        ),
                      ),
                      Gaps.hGap32,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Translation.current.send_location,
                              style: TextStyle(
                                color: AppColors.black_text,
                                fontWeight: FontWeight.bold,
                                fontSize: 45.sp,
                              ),
                            ),
                            Gaps.vGap12,
                            Text(
                              getPlaceMarkInfo(sn.selectedPlacemark!),
                              style: TextStyle(
                                color: AppColors.mansourNotSelectedBorderColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 35.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
