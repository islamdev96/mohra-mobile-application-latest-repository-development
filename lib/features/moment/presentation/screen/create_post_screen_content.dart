import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/moment/presentation/logic/moment_utils.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/create_post_screen_notifier.dart';
import 'package:starter_application/features/moment/presentation/widget/pick_files_grid.dart';
import 'package:starter_application/features/place/presentation/state_m/cubit/place_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../main.dart';
import '../../../../main.dart';
import '../../../../main.dart';
import '../../../../main.dart';
import '../../../../main.dart';

class CreatePostScreenContent extends StatefulWidget {
  const CreatePostScreenContent({Key? key}) : super(key: key);

  @override
  State<CreatePostScreenContent> createState() =>
      _CreatePostScreenContentState();
}

class _CreatePostScreenContentState extends State<CreatePostScreenContent> {
  late CreatePostScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<CreatePostScreenNotifier>(context);
    return SingleChildScrollView(
      padding: AppConstants.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap64,
          _buildPostTextField(),
          InkWell(
            onTap: () {
              sn.captionFocusNode.unfocus();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (sn.selectedTrack == null) Gaps.vGap32,
                if (sn.selectedTrack == null) _buildPickImagesGrid(),
                // if (sn.pickedFiles.length == 0) Gaps.vGap32,
                // if (sn.pickedFiles.length == 0) _buildPickSong(),
                Gaps.vGap128,
                Divider(
                  thickness: 2,
                  color: AppColors.mansourLightGreyColor,
                  height: 1.h,
                ),
                _buildAddressListTile(),
                Divider(
                  thickness: 2,
                  color: AppColors.mansourLightGreyColor,
                  height: 1.h,
                ),
                Gaps.vGap32,
                _buildWithListTile(),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Post TextField
  Widget _buildPostTextField() {
    return CustomTextField(
      textKey: sn.captionKey,
      controller: sn.captionController,
      focusNode: sn.captionFocusNode,
      textInputAction: TextInputAction.newline,
      autofocus: true,
      keyboardType: TextInputType.multiline,
      maxLines: 10,
      minLines: 1,
      border: InputBorder.none,
      showCursor: true,
      cursorHeight: 80.h,
      cursorColor: AppColors.primaryColorLight,
      fontSize: 50.sp,
      validator: (value) {
        if (value == null || value.trim().length == 0)
          return Translation.of(context).errorEmptyField;
        return null;
      },
    );
  }

  /// PickImagesGrid
  Widget _buildPickImagesGrid() {
    return PickFilesGrid(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      onFilesPicked: sn.onFilesPicked,
      onFileDeleted: sn.onFileDeleted,
      filesPaths: sn.pickedFiles,
      allowMultiples: false,
    );
  }

  // Widget _buildPickSong() {
  //   if (sn.selectedTrack != null) {
  //     return CustomListTile(
  //       height: 290.h,
  //       padding: EdgeInsets.symmetric(
  //         horizontal: 40.w,
  //       ),
  //       backgroundColor: AppColors.mansourWhiteBackgrounColor_5,
  //       borderRadius: BorderRadius.circular(
  //         40.r,
  //       ),
  //       leadingFlex: 3,
  //       leading: ClipRRect(
  //         borderRadius: BorderRadius.circular(
  //           30.r,
  //         ),
  //         child: SizedBox(
  //             height: 0.6 * 290.h,
  //             width: 0.6 * 290.h,
  //             child: CachedNetworkImage(
  //               imageUrl: sn.selectedTrack?.image ?? "",
  //               placeholder: (context, url) =>
  //                   const CircularProgressIndicator.adaptive(),
  //               errorWidget: (context, url, error) => const Icon(Icons.error),
  //               fit: BoxFit.cover,
  //             )),
  //       ),
  //       title: Padding(
  //         padding: EdgeInsets.only(
  //           bottom: 20.h,
  //         ),
  //         child: Text(
  //           sn.selectedTrack?.name ?? "",
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 45.sp,
  //             fontWeight: FontWeight.w800,
  //           ),
  //         ),
  //       ),
  //       subtitle: Text(
  //         sn.selectedTrack?.artist ?? "",
  //         style: TextStyle(
  //           color: AppColors.mansourLightGreyColor_11,
  //           fontSize: 40.sp,
  //           fontWeight: FontWeight.w800,
  //         ),
  //       ),
  //       trailing: ClipRRect(
  //         borderRadius: BorderRadius.all(Radius.circular(
  //           100.r,
  //         )),
  //         child: Container(
  //           height: 20,
  //           width: 20,
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Colors.red),
  //             borderRadius: BorderRadius.all(Radius.circular(
  //               100.r,
  //             )),
  //           ),
  //           child: InkWell(
  //             onTap: sn.onRemoveSongTap,
  //             child: const Icon(
  //               Icons.clear_outlined,
  //               color: Colors.red,
  //               size: 20,
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   return Container(
  //     height: 200.h,
  //     width: 200.h,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(
  //         30.r,
  //       ),
  //     ),
  //     child: ClipRRect(
  //         borderRadius: BorderRadius.circular(
  //           30.r,
  //         ),
  //         child: Material(
  //             type: MaterialType.transparency,
  //             child: InkWell(
  //               onTap: (){},
  //               // onTap: sn.onPickSongTap,
  //               child: Center(
  //                 child: SizedBox(
  //                     height: 80.h,
  //                     width: 80.h,
  //                     child: const Icon(
  //                       Icons.music_note_outlined,
  //                       color: AppColors.primaryColorLight,
  //                     )),
  //               ),
  //             ))),
  //   );
  // }

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
}
