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
import 'package:starter_application/features/moment/presentation/logic/moment_utils.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/create_feeling_screen_notifier.dart';
import 'package:starter_application/features/place/presentation/state_m/cubit/place_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../main.dart';

class CreateFeelingScreenContent extends StatefulWidget {
  const CreateFeelingScreenContent({Key? key}) : super(key: key);

  @override
  State<CreateFeelingScreenContent> createState() =>
      _CreateFeelingScreenContentState();
}

class _CreateFeelingScreenContentState
    extends State<CreateFeelingScreenContent> {
  late CreateFeelingScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<CreateFeelingScreenNotifier>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            thickness: 2,
            color: AppColors.mansourLightGreyColor,
            height: 1.h,
          ),
          _buildFeelingsList(),
          Gaps.vGap32,
          _buildFooter(),
        ],
      ),
    );
  }

  /// AddressListTile
  Widget _buildAddressListTile() {
    return InkWell(
      onTap: sn.isVerifyChallenge ? null : sn.onSelectPlaceTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 50.h,
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
                        AppConstants.SVG_PIN,
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

  /// WithListTile
  Widget _buildWithListTile() {
    return CustomListTile(
      leadingFlex: 1,
      trailingFlex: 1,
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

  Widget _buildFeelingsList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        mainAxisSpacing: 30.h,
        crossAxisSpacing: 0.25.sw,
      ),
      itemBuilder: (context, index) {
        final feeling = AppConstants.feelings[index];
        return InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => sn.onSelectFeelingTap(index),
          child: Row(
            children: [
              Image.asset(
                feeling.path,
                height: 100.sp,
                width: 100.sp,
              ),
              Gaps.hGap32,
              Text(
                feeling.name,
                style: TextStyle(
                  color: sn.selectedFeelingIndex == index
                      ? AppColors.primaryColorLight
                      : AppColors.accentColorLight,
                  fontSize: 40.sp,
                ),
              )
            ],
          ),
        );
      },
      itemCount: AppConstants.feelings.length,
    );
  }

  _buildFooter() {
    return Container(
      padding: AppConstants.screenPadding,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            30.r,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ]),
      child: Column(
        children: [
          _buildAddressListTile(),
          Divider(
            thickness: 2,
            color: AppColors.mansourLightGreyColor,
            height: 1.h,
          ),
          Gaps.vGap32,
          _buildWithListTile(),
          Gaps.vGap64,
        ],
      ),
    );
  }
}
