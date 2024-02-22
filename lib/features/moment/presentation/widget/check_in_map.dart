import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

class CheckInMap extends StatelessWidget {
  final VoidCallback? onTap;
  final LatLng? location;
  final Function(GoogleMapController controller)? onMapCreated;

  const CheckInMap({
    Key? key,
    required this.location,
    this.onMapCreated,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildMap();
  }

  bool get isPlaceSelected => location != null;

  Widget _buildMap() {
    final markerHeight = 75.h;
    return SizedBox(
      height: 500.h,
      width: 1.sw - AppConstants.screenPadding.left * 2,
      child: Material(
        // color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    20.r,
                  ),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      // target: sn.selectedPlace?.location ??
                      //     AppConstants.MAP_DEFAULT_LOCATION,
                      target: location ?? AppConstants.MAP_DEFAULT_LOCATION,
                      zoom: 9,
                    ),
                    scrollGesturesEnabled: false,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: false,
                    rotateGesturesEnabled: false,
                    onMapCreated: onMapCreated,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20.r,
                    ),
                    color: Colors.grey.withOpacity(
                      isPlaceSelected ? 0 : 0.6,
                    ),
                  ),
                ),
              ),
              if (isPlaceSelected)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: markerHeight * 0.5,
                  top: 0,
                  child: Center(
                    child: SizedBox(
                      height: markerHeight,
                      width: markerHeight,
                      child: SvgPicture.asset(
                        AppConstants.SVG_PIN_FILL,
                        color: AppColors.primaryColorLight,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
