import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/messages/presentation/widgets/loading_message_widget.dart';
import 'package:starter_application/features/moment/presentation/logic/moment_utils.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/check_in_screen_notifier.dart';
import 'package:starter_application/features/moment/presentation/widget/check_in_map.dart';
import 'package:starter_application/features/place/presentation/state_m/cubit/place_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../main.dart';

class CheckInScreenContent extends StatefulWidget {
  const CheckInScreenContent({Key? key}) : super(key: key);

  @override
  State<CheckInScreenContent> createState() => _CheckInScreenContentState();
}

class _CheckInScreenContentState extends State<CheckInScreenContent> {
  late CheckInScreenNotifier sn;

  final footerHeight = 250.h;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<CheckInScreenNotifier>(context);
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: footerHeight + 10.h,
            ),
            child: _buildCheckInLocationColumn(),
          ),
        ),
        Positioned(
          bottom: 0,
          child: _buildFooter(),
        ),
      ],
    );
  }

  Widget _buildMatchedChallengeLocation() {
    return FutureBuilder<LatLng>(
        future: sn.matchedLocationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return BlocBuilder<PlaceCubit, PlaceState>(
              bloc: sn.reverseGeocodingCubit,
              builder: (context, state) {
                return state.maybeMap(
                    orElse: () => WaitingWidget(),
                    reverseGeocodingLoaded: (_) {
                      if (sn.selectedPlace == null) return WaitingWidget();

                      return SizedBox(
                        width: 0.7.sw,
                        child: Text(
                          sn.selectedPlace?.name ?? "",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    });
              },
            );
          }
          return WaitingWidget();
        });
  }

  Widget _buildCheckInLocationColumn() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        children: [
          Gaps.vGap32,
          _buildCheckInListTile(),
          Gaps.vGap64,
          sn.getLocationLoading ? WaitingWidget() : _buildMap(),
          Gaps.vGap32,
          _buildLocationListTile(),
          Divider(
            thickness: 2,
            color: AppColors.mansourLightGreyColor,
            height: 1.h,
          ),
        ],
      ),
    );
  }

  /// LocationListTile
  Widget _buildLocationListTile() {
    return InkWell(
      onTap: sn.isVerifyChallenge ? null : sn.onSelectPlaceTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 50.h,
          horizontal: AppConstants.screenPadding.left,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70.h,
                      width: 70.h,
                      child: SvgPicture.asset(
                        AppConstants.SVG_PIN_FILL,
                        color: AppColors.primaryColorLight,
                      ),
                    ),
                    Gaps.hGap32,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 70.h,
                              width: 70.h,
                              child: SvgPicture.asset(
                                AppConstants.SVG_CHECK_MARK,
                                color: AppColors.primaryColorLight,
                              ),
                            ),
                            Gaps.hGap32,
                            Text(
                              sn.isVerifyChallenge
                                  ? Translation.current.matched_location
                                  : Translation.current.select_location,
                              style: TextStyle(
                                color: AppColors.primaryColorLight,
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Gaps.vGap12,
                        if (!sn.isVerifyChallenge)
                          SizedBox(
                            width: 0.7.sw,
                            child: Text(
                              sn.selectedPlace?.name ?? "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        if (sn.isVerifyChallenge)
                          _buildMatchedChallengeLocation(),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 70.h,
                  width: 70.h,
                  child: SvgPicture.asset(
                    isArabic
                        ? AppConstants.SVG_ARROW_IOS_LEFT
                        : AppConstants.SVG_ARROW_IOS_RIGHT,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMap() {
    return CheckInMap(
      location: sn.selectedPlace?.location ?? sn.myLocation,
      onMapCreated: (controller) {
        sn.mapController = controller;
      },
      onTap: sn.isVerifyChallenge ? null : sn.onSelectPlaceTap,
    );
  }

  _buildFooter() {
    return SizedBox(
        height: footerHeight, width: 1.sw, child: _buildWithListTile());
  }

  /// WithListTile
  Widget _buildWithListTile() {
    return CustomListTile(
      leadingFlex: 1,
      trailingFlex: 1,
      padding: AppConstants.screenPadding,
      backgroundColor: Colors.white,
      borderRadius: BorderRadius.circular(
        30.r,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
        ),
      ],
      leading: SizedBox(
        height: 65.h,
        width: 65.h,
        child: SvgPicture.asset(
          AppConstants.SVG_AT,
          color: AppColors.mansourLightGreyColor_3,
        ),
      ),
      title: Text(
        "${Translation.current.with_trs} ${MomentUtils.taggedFriendsToString(sn.taggedFriends.map((e) => e.name).toList())}",
        style: TextStyle(
          color: Colors.black,
          fontSize: 40.sp,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: SizedBox(
        height: 70.h,
        width: 70.h,
        child: SvgPicture.asset(
          isArabic
              ? AppConstants.SVG_ARROW_IOS_LEFT
              : AppConstants.SVG_ARROW_IOS_RIGHT,
        ),
      ),
      onTap: sn.onTagFriendsTap,
    );
  }

  Widget _buildCheckInListTile() {
    return CustomListTile(
      leadingFlex: 1,
      padding: AppConstants.screenPadding,
      leading: Container(
        height: 80.h,
        width: 80.h,
        decoration: const BoxDecoration(
          color: AppColors.mansourLightBlueColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SizedBox(
            height: 50.h,
            width: 50.h,
            child: SvgPicture.asset(
              AppConstants.SVG_PIN_FILL,
              color: Colors.white,
            ),
          ),
        ),
      ),
      title: Text(
        Translation.current.check_in_moment,
        style: TextStyle(
          color: Colors.black,
          fontSize: 45.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
