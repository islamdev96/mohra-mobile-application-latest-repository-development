import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';

class NearbyMosqueCard extends StatelessWidget {
  final String name;
  final LatLng location;
  final String address;
  final bool? isOpenNow;
  final bool isOpenAllDay;
  final double height;
  final VoidCallback? onTap;
  final String image;
  final String distance;

  const NearbyMosqueCard({
    Key? key,
    required this.height,
    required this.name,
    required this.location,
    required this.address,
    required this.image,
    required this.isOpenAllDay,
    required this.distance,
    this.onTap,

    this.isOpenNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height-20.h,
                width: 0.7 * height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20.r,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Gaps.hGap32,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 42.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gaps.vGap12,
                        Text(
                          address,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 37.sp,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          distance,
                          style: TextStyle(
                            color: AppColors.mansourLightGreyColor_11,
                            fontSize: 33.sp,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 20.h,
                            horizontal: 40.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mansourPurple4.withOpacity(
                              0.1,
                            ),
                            borderRadius: BorderRadius.circular(
                              40.r,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              isOpenAllDay
                                  ? "open all day"
                                  : isOpenNow == null
                                      ? "Unknown"
                                      : isOpenNow!
                                          ? "Open now"
                                          : "Closed now",
                              style: TextStyle(
                                color: AppColors.mansourPurple4,
                                fontSize: 33.sp,
                              ),
                            ),
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
    );
  }
}
