import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/localization/localization_provider.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/params/screen_params/personality_result_screen_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/toast/errv_toast_options.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/toast/show_error_toast.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/core/utils/insta-image-viewer/src/insta_image_viewer.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';
import 'package:starter_application/features/health/presentation/widget/profile/one_user_info_carrd.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/moment/presentation/widget/moment_card.dart';
import 'package:starter_application/features/moment/presentation/widget/moment_header.dart';
import 'package:starter_application/features/personality/presentation/screen/personality_details_screen.dart';
import 'package:starter_application/features/personality/presentation/screen/presonality_result_screen.dart';
import 'package:starter_application/features/personality/presentation/screen/visit_user_personality_page_screen.dart';
import 'package:starter_application/features/user/presentation/screen/view_friend_moments_screen.dart';
import 'package:starter_application/features/user/presentation/screen/view_profile_screen.dart';
import 'package:starter_application/features/user/presentation/widget/cover_image_widget.dart';
import 'package:starter_application/features/user/presentation/widget/friend_card.dart';
import 'package:starter_application/features/user/presentation/widget/moment_curve_image.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../main.dart';
import '../screen/../state_m/provider/visit_user_profile_screen_notifier.dart';

class VisitUserProfileScreenContent extends StatelessWidget {
  late VisitUserProfileScreenNotifier sn;
  double _headerHeight = 0.25.sh;
  double vLineStart = 0.12.sw;
  double vLineTop = 0.15.sh;
  double vLineWidth = 7.w;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<VisitUserProfileScreenNotifier>(context);
    sn.context = context;
    return Container(
      height: 1.sh,
      width: 1.sw,
      color: AppColors.black.withOpacity(0.03),
      child: Stack(
        children: [
          _buildScreenDetails(),
          _buildHeaderBackground(),
          _buildHeaderContent(),
        ],
      ),
    );
  }

  Widget _buildHeaderBackground() {
    return PositionedDirectional(
      top: 0,
      child: MomentHeader(
        height: 0.25.sh,
        width: 1.sw,
        image: sn.clientProfileEntity.client?.coverImage,
      ),
    );
  }

  UniqueKey key = UniqueKey();

  Widget _buildHeaderContent() {
    return PositionedDirectional(
      top: vLineTop - 0.10.sh,
      child: Container(
        width: 1.sw,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Nav.pop();
                  },
                  icon: Icon(
                    AppConstants.getIconBack(),
                    color: AppColors.white,
                    size: 30,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (sn.clientProfileEntity.client!.avatarEntity != null) {
                      Nav.to(VisitUserPersonalityPageScreen.routeName,
                          arguments: PersonalityResultScreenParams(
                            birthDay: sn.clientProfileEntity.client
                                        ?.avatarEntity?.month !=
                                    null
                                ? DateTime(
                                    1,
                                    sn.clientProfileEntity.client!.avatarEntity!
                                        .month!,
                                    2,
                                  )
                                : null,
                            gender: sn.clientProfileEntity.client!.avatarEntity!
                                .gender,
                            name: sn.clientProfileEntity.client!.fullName,
                          ));
                    }
                  },
                  child: CachedNetworkImage(
                    imageUrl: sn.getAvatarImage(),
                    fit: BoxFit.contain,
                    width: 0.2.sw,
                    height: 0.2.sw,
                    errorWidget: (context, url, error) => Container(
                      child: const Icon(Icons.error),
                    ),
                    placeholder: (context, _) => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        sn.context,
                        PageRouteBuilder(
                            opaque: false,
                            barrierColor: Colors.white.withOpacity(0),
                            pageBuilder: (BuildContext context, _, __) {
                              return FullScreenViewer(
                                  tag: key,
                                  disableSwipeToDismiss: false,
                                  disposeLevel: DisposeLevel.high,
                                  child: CachedNetworkImage(
                                    imageUrl: sn.clientProfileEntity.client!
                                            .imageUrl ??
                                        "",
                                    placeholder: (context, url) {
                                      return CircularProgressIndicator
                                          .adaptive();
                                    },
                                  )

                                  // Image(
                                  //   image: Image.network(sn.clientProfileEntity.client!.imageUrl??"",).image,
                                  // ),
                                  // child:  ProfilePic(
                                  //   width: 1.sw,
                                  //   height: 0.5.sh,
                                  //   imageUrl: sn.clientProfileEntity.client!.imageUrl,
                                  // )
                                  );
                            }));
                  },
                  child: Hero(
                      tag: key,
                      child: ProfilePic(
                        width: 180.w,
                        height: 180.w,
                        imageUrl: sn.clientProfileEntity.client!.imageUrl,
                      )),
                ),
                Gaps.hGap32,
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  color: sn.clientProfileEntity.client!.coverImage != null
                      ? AppColors.text_gray.withOpacity(0.4)
                      : Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 0.6.sw,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              //
                              child: Text(
                                '${sn.clientProfileEntity.client!.fullName}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (sn.clientProfileEntity.isFriend)
                              IconButton(
                                  onPressed: () {
                                    if (Provider.of<AppMainScreenNotifier>(
                                            getIt<NavigationService>()
                                                .getNavigationKey
                                                .currentContext!,
                                            listen: false)
                                        .isVisitUserInChat)
                                      Nav.pop();
                                    else
                                      sn.messageTapped(
                                          sn.clientProfileEntity.isFriend);
                                  },
                                  icon: Icon(
                                    Icons.message,
                                    color: AppColors.mansourBackArrowColor2,
                                  ))
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${sn.userAddress}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppColors.white,
                            ),
                          ),
                          if (sn.clientProfileEntity.isFriend)
                            Text(
                              ' ${sn.clientProfileEntity.client!.userName}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColors.white,
                              ),
                            ),
                        ],
                      ),
                      if (!sn.clientProfileEntity.isFriend)
                        Text(
                          '${Translation.current.userName} : ${sn.clientProfileEntity.client!.userName}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildScreenDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: _headerHeight,
          ),
          _buildMomentsList(),
          // Gaps.vGap32,
          // Visibility(
          //   visible: sn.isFriend,
          //   child: _buildMediaLinkList(),
          // ),
          Gaps.vGap32,
          Visibility(
            visible: sn.isFriend,
            child: _buildActionCard(
                title: Translation.current.events,
                onTap: () {
                  showErrorToast(
                      errVToastOptions: const ErrVToastOptions(),
                      message: Translation.current.will_be_added_soon);
                }),
          ),
          Gaps.vGap32,
          Visibility(
            visible: sn.isFriend,
            child: _buildActionCard(
                title: Translation.current.others,
                onTap: () {
                  showErrorToast(
                      errVToastOptions: const ErrVToastOptions(),
                      message: Translation.current.will_be_added_soon);
                }),
          ),
          Gaps.vGap32,
          // Visibility(
          //   visible: sn.isFriend,
          //   child: _buildMessageButton(),
          // ),
          // Gaps.vGap32,
          if (isVisitUserMoment == true && sn.clientProfileEntity.isFriend)
            CustomMansourButton(
              width: 1.sw,
              backgroundColor: AppColors.white,
              height: 50,
              onPressed: () {
                if (Provider.of<AppMainScreenNotifier>(
                        getIt<NavigationService>()
                            .getNavigationKey
                            .currentContext!,
                        listen: false)
                    .isVisitUserInChat)
                  Nav.pop();
                else
                  sn.messageTapped(sn.clientProfileEntity.isFriend);
              },
              title: Row(
                children: [
                  const Icon(
                    Icons.message,
                    color: AppColors.mansourDarkOrange3,
                  ),
                  Gaps.hGap12,
                  Text(
                    Translation.current.message,
                    style: const TextStyle(
                      color: AppColors.mansourDarkOrange3,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          if (!sn.clientProfileEntity.isFriend && isVisitUserMoment)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50.h),
              child: BlocConsumer<FriendCubit, FriendState>(
                bloc: sn.friendCubit,
                builder: (context, state) => state.maybeMap(
                  friendLoadingState: (value) => WaitingWidget(),
                  friendRequestSentState: (value) => _buildAddFriendButton(),
                  orElse: () => _buildAddFriendButton(),
                ),
                listener: (context, state) =>
                    state.mapOrNull(friendErrorState: (value) {
                  ErrorViewer.showError(
                      context: context, error: value.error, callback: () {});
                }, friendRequestSentState: (value) {
                  sn.onFriendAddDone();
                }, cancelFriendRequestDone: (v) {
                  sn.onFriendRequestCancelDone();
                }),
              ),
            ),
          if (isVisitUserMoment == false) _buildFooterButtons(),
        ],
      ),
    );
  }

  _buildMomentsList() {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 10, top: 5, bottom: 5),
      // height:
      //     sn.clientProfileEntity.client!.moments!.isEmpty ? 0.1.sh : 0.20.sh,
      width: 1.sw,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: AppColors.white,
          offset: Offset(0, 0),
          blurRadius: 2,
        ),
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: sn.clientProfileEntity.client!.moments!.isEmpty
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          Text(
            Translation.current.moments,
            style: TextStyle(
                fontSize: 50.sp,
                color: AppColors.black,
                fontWeight: FontWeight.bold),
          ),
          Gaps.vGap12,
          if (sn.clientProfileEntity.client!.moments!.isNotEmpty)
            InkWell(
              onTap: () {
                if (sn.isFriend) {
                  Nav.to(ViewFriendMomentsScreen.routeName,
                      arguments: sn.clientProfileEntity.client);
                }
              },
              child: Row(
                children: [
                  Container(
                    height: 0.25.sw,
                    width: 0.9.sw,
                    child: ListView.separated(
                      itemCount: sn.clientProfileEntity.client!.moments!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        // if(sn.clientProfileEntity.client!.moments![index].imageUrl != null || sn.clientProfileEntity.client!.moments![index].videos!.length > 0)
                        return _buildMomentItem(
                            sn.clientProfileEntity.client!.moments![index]);
                        // else
                        //   return SizedBox.shrink();
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Gaps.hGap12;
                      },
                    ),
                  ),
                  Container(
                    height: 0.12.sh,
                    color: AppColors.white,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 0.05.sw,
                    ),
                  ),
                ],
              ),
            ),
          if (sn.clientProfileEntity.client!.moments!.isEmpty)
            Container(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      Translation.current.no_moments_for_now,
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  _buildMomentItem(MomentItemEntity m) {
    if (m.videos!.length > 0 || m.imageUrl != null || m.feelingIconUrl != null)
      return MomentCurveImage(
        imgPath: m.feelingIconUrl != null
            ? m.feelingIconUrl
            : m.imageUrl!.first.imageUrl!.startsWith("https")
                ? m.imageUrl!.first.imageUrl!
                : "",
        height: 0.10.sh,
        width: 0.10.sh,
        radius: 8,
        withChild: true,
      );
    else
      return SizedBox();
    // else if(m.lat != null && m.long != null && m.placeName != null)
    //   return Container(
    //     decoration: BoxDecoration(
    //       color: AppColors.white,
    //       borderRadius: BorderRadius.circular(20),
    //       border: Border.all(
    //         width: .5,
    //         color: Colors.black,
    //       ),
    //     ),
    //     height: 0.10.sh,
    //     width: 0.10.sh,
    //     child: Icon(Icons.location_on),
    //   );
    // else if(m.music != null)
    //   return Container(
    //     decoration: BoxDecoration(
    //       color: AppColors.white,
    //       borderRadius: BorderRadius.circular(20),
    //       border: Border.all(
    //         width: .5,
    //         color: Colors.black,
    //       ),
    //     ),
    //     height: 0.10.sh,
    //     width: 0.10.sh,
    //     child: Icon(Icons.music_note),
    //   );
    // else if(m.feelingIconUrl != null)
    //   return Container(
    //     decoration: BoxDecoration(
    //       color: AppColors.white,
    //       borderRadius: BorderRadius.circular(20),
    //       border: Border.all(
    //         width: .5,
    //         color: Colors.black,
    //       ),
    //     ),
    //     height: 0.10.sh,
    //     width: 0.10.sh,
    //     child: Icon(Icons.face),
    //   );
    // else
    //   return Container(
    //     decoration: BoxDecoration(
    //       color: AppColors.white,
    //       borderRadius: BorderRadius.circular(20),
    //       border: Border.all(
    //         width: .5,
    //         color: Colors.black,
    //       ),
    //     ),
    //     height: 0.10.sh,
    //     width: 0.10.sh,
    //     child: Center(
    //       child: Text(m.caption ?? "",maxLines: 2,
    //       textAlign: TextAlign.center,),
    //     ),
    //   );
  }

  _buildMediaLinkList() {
    return GestureDetector(
      onTap: () {
        showErrorToast(
            errVToastOptions: const ErrVToastOptions(),
            message: Translation.current.will_be_added_soon);
      },
      child: Container(
        padding: const EdgeInsetsDirectional.only(start: 10, top: 5, bottom: 5),
        height: 0.20.sh,
        width: 1.sw,
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: AppColors.white,
            offset: Offset(0, 0),
            blurRadius: 2,
          ),
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Translation.current.Media_links_others,
              style: TextStyle(
                  fontSize: 50.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold),
            ),
            Gaps.vGap12,
            Row(
              children: [
                Container(
                  height: 0.14.sh,
                  width: 0.9.sw,
                  child: ListView.separated(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 0.10.sh,
                        width: 0.10.sh,
                        child: MomentCurveImage(
                          imgPath: '',
                          height: 0.10.sh,
                          width: 0.10.sh,
                          radius: 10,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Gaps.hGap12;
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('goo');
                  },
                  child: Container(
                    height: 0.12.sh,
                    color: AppColors.white,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 0.05.sw,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildActionCard({
    required String title,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.only(
            start: 10, top: 10, bottom: 10, end: 10),
        height: 0.06.sh,
        width: 1.sw,
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: AppColors.white,
            offset: Offset(0, 0),
            blurRadius: 2,
          ),
        ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 50.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: 0.12.sh,
                color: AppColors.white,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 0.05.sw,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildFooterButtons() {
    return sn.isFriend
        ? Container(
            width: 1.sw,
            height: 120,
            child: Column(
              children: [
                BlocConsumer<FriendCubit, FriendState>(
                  bloc: sn.blockCubit,
                  builder: (context, state) => state.maybeMap(
                    friendLoadingState: (value) => WaitingWidget(),
                    orElse: () => _buildBlockButton(),
                  ),
                  listener: (context, state) => state.mapOrNull(
                    friendErrorState: (value) {
                      ErrorViewer.showError(
                          context: context,
                          error: value.error,
                          callback: () {});
                    },
                    friendBlockedState: (state) => sn.onBlockDone(),
                    friendUnblockedState: (state) => sn.onUnBlockDone(),
                  ),
                ),
                Gaps.vGap12,
                BlocConsumer<FriendCubit, FriendState>(
                  bloc: sn.muteCubit,
                  builder: (context, state) => state.maybeMap(
                    friendLoadingState: (value) => WaitingWidget(),
                    orElse: () => _buildMuteButton(),
                  ),
                  listener: (context, state) => state.mapOrNull(
                    friendErrorState: (value) {
                      ErrorViewer.showError(
                          context: context,
                          error: value.error,
                          callback: () {});
                    },
                    changeMuteSuccess: (v) => sn.onMuteStatusChanged(),
                  ),
                )
              ],
            ),
          )
        : BlocConsumer<FriendCubit, FriendState>(
            bloc: sn.friendCubit,
            builder: (context, state) => state.maybeMap(
              friendLoadingState: (value) => WaitingWidget(),
              friendRequestSentState: (value) => _buildAddFriendButton(),
              orElse: () => _buildAddFriendButton(),
            ),
            listener: (context, state) =>
                state.mapOrNull(friendErrorState: (value) {
              ErrorViewer.showError(
                  context: context, error: value.error, callback: () {});
            }, friendRequestSentState: (value) {
              sn.onFriendAddDone();
            }, cancelFriendRequestDone: (v) {
              sn.onFriendRequestCancelDone();
            }),
          );
  }

  _buildAddFriendButton() {
    return AddFriendButton(
      isFriend: sn.isFriend,
      requestSent: sn.hasFriendRequest,
      onTap: () {
        if (!sn.hasFriendRequest) {
          sn.addFriend();
        }
        if (sn.hasFriendRequest) {
          sn.cancelFriendRequest();
        }
      },
    );
  }

  _buildBlockButton() {
    return sn.isBlocked
        ? CustomMansourButton(
            width: 1.sw,
            backgroundColor: AppColors.white,
            height: 50,
            onPressed: () {
              sn.unBlock();
            },
            title: Row(
              children: [
                const Icon(
                  Icons.block,
                  color: AppColors.mansourDarkOrange3,
                ),
                Gaps.hGap12,
                Text(
                  Translation.current.blocked,
                  style: const TextStyle(
                    color: AppColors.mansourDarkOrange3,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        : CustomMansourButton(
            width: 1.sw,
            backgroundColor: AppColors.white,
            height: 50,
            onPressed: () {
              sn.block();
            },
            title: Row(
              children: [
                const Icon(
                  Icons.block,
                  color: AppColors.mansourDarkOrange3,
                ),
                Gaps.hGap12,
                Text(
                  Translation.current.block,
                  style: const TextStyle(
                    color: AppColors.mansourDarkOrange3,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
  }

  _buildMuteButton() {
    return sn.isMuted
        ? CustomMansourButton(
            width: 1.sw,
            backgroundColor: AppColors.white,
            height: 50,
            onPressed: () {
              sn.mute();
            },
            title: Row(
              children: [
                const Icon(
                  Icons.volume_off,
                  color: AppColors.mansourDarkOrange3,
                ),
                Gaps.hGap12,
                Text(
                  Translation.current.muted,
                  style: const TextStyle(
                    color: AppColors.mansourDarkOrange3,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        : CustomMansourButton(
            width: 1.sw,
            backgroundColor: AppColors.white,
            height: 50,
            onPressed: () {
              sn.mute();
            },
            title: Row(
              children: [
                const Icon(
                  Icons.volume_up,
                  color: AppColors.mansourDarkOrange3,
                ),
                Gaps.hGap12,
                Text(
                  Translation.current.mute,
                  style: const TextStyle(
                    color: AppColors.mansourDarkOrange3,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
  }

  _buildMessageButton() {
    return CustomMansourButton(
      width: 0.5.sw,
      backgroundColor: AppColors.mansourDarkOrange2,
      height: 50,
      onPressed: () {
        if (Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .isVisitUserInChat)
          Nav.pop();
        else
          sn.messageTapped(sn.clientProfileEntity.isFriend);
      },
      title: Row(
        children: [
          Text(
            Translation.current.message,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 40.sp,
            ),
          ),
        ],
      ),
    );
  }

// Future<void> _showMyDialog(widget,context) async {
//   return showGeneralDialog<void>(
//     context: context,
//     useRootNavigator: true,
//     barrierDismissible: false, // user must tap button!
//     pageBuilder: (_,__,___) {
//       return SafeArea(
//         child: Container(
//           color: Colors.black,
//           child: InstaImageViewer(child:   Center(
//             child: SizedBox(
//               child: Container(
//                 width: 1.sw,
//                 height: .5.sh,
//                 child:widget ,
//               ),
//             ),
//           ),),
//           //
//           // Stack(
//           //   children: [
//           //     Align(
//           //       alignment: const Alignment(.9,-.9),
//           //       child: GestureDetector(
//           //         onTap: (){
//           //           Navigator.pop(context);
//           //         },
//           //         child: Container(
//           //           width: 40,
//           //           height: 40,
//           //           decoration: const BoxDecoration(
//           //             shape: BoxShape.circle,
//           //             color: Colors.white,
//           //           ),
//           //           child: Center(
//           //             child: Icon(Icons.close_rounded),
//           //           ),
//           //         ),
//           //       ),
//           //     ),
//           //     Center(
//           //       child: SizedBox(
//           //         child: Container(
//           //           width: 1.sw,
//           //           height: .5.sh,
//           //           child:widget ,
//           //         ),
//           //       ),
//           //     ),
//           //   ],
//           // ),
//         ),
//       );
//     },
//   );
// }

  /// old code
/*@override
  Widget build(BuildContext context) {
    sn = Provider.of<VisitUserProfileScreenNotifier>(context);
    sn.context = context;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Container(
              width: 1.sw,
              height: 0.1.sh,
              child: Center(
                child: ProfilePic(
                  width: 0.3.sw,
                  height: 0.1.sh,
                  imageUrl: sn.clientProfileEntity.client?.imageUrl ?? '',
                ),
              ),
            ),
          ),
          Gaps.vGap24,
          Container(
            width: 0.9.sw,
            child: Column(
              children: [
                Text(
                  sn.clientProfileEntity.client?.fullName ?? '',
                  style: TextStyle(
                    fontSize: 50.sp,
                  ),
                ),
                Gaps.vGap40,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlocConsumer<FriendCubit, FriendState>(
                      bloc: sn.friendCubit,
                      builder: (context, state) => state.maybeMap(
                        friendLoadingState: (value) => WaitingWidget(),
                        friendRequestSentState: (value) => AddFriendButton(
                          requestSent: true,
                          onTap: () {},
                          isFriend: false,
                        ),
                        orElse: () => AddFriendButton(
                          isFriend: sn.clientProfileEntity.isFriend,
                          onTap: () {
                            sn.addFriend();
                          },
                        ),
                      ),
                      listener: (context, state) => state.mapOrNull(
                        friendErrorState: (value) {
                          ErrorViewer.showError(
                              context: context,
                              error: value.error,
                              callback: () {});
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sn.navToRoom();
                      },
                      child: Container(
                        width: 0.35.sw,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.mansourDarkOrange2, width: 1),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.message,
                              color: AppColors.mansourDarkOrange2,
                              size: 30,
                            ),
                            Text(
                              Translation.current.message,
                              style: TextStyle(
                                color: AppColors.mansourDarkOrange2,
                                fontSize: 50.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Gaps.vGap40,
                Divider(
                  thickness: 1,
                  color: AppColors.mansourDarkOrange,
                ),
                OneUserInfoCard(
                  infoKey: Translation.current.firstName,
                  infoValue: sn.clientProfileEntity.client?.name ?? '',
                  withDivider: false,
                  dividerWidth: 1,
                  textColor: AppColors.black,
                ),
                OneUserInfoCard(
                  infoKey: Translation.current.lastName,
                  infoValue: sn.clientProfileEntity.client?.surname ?? '',
                  withDivider: false,
                  dividerWidth: 1,
                  textColor: AppColors.black,
                ),
                */ /*OneUserInfoCard(
                  infoKey: 'User Name',
                  infoValue: sn.clientProfileEntity.client?.,
                  withDivider: false,
                  dividerWidth: 1,
                  textColor: AppColors.black,
                ),*/ /*
                OneUserInfoCard(
                  infoKey: Translation.current.email,
                  infoValue: sn.clientProfileEntity.client?.emailAddress ?? '',
                  withDivider: false,
                  dividerWidth: 1,
                  textColor: AppColors.black,
                ),
                OneUserInfoCard(
                  infoKey: Translation.current.phone,
                  infoValue: sn.clientProfileEntity.client?.phoneNumber ?? '',
                  withDivider: false,
                  dividerWidth: 1,
                  textColor: AppColors.black,
                ),
                if (sn.clientProfileEntity.client?.gender != null)
                  OneUserInfoCard(
                    infoKey: Translation.current.gender,
                    infoValue: sn.clientProfileEntity.client?.gender == 0
                        ? Translation.current.male
                        : Translation.current.female,
                    withDivider: false,
                    dividerWidth: 1,
                    textColor: AppColors.black,
                  ),
                */ /*OneUserInfoCard(
                  infoKey: 'Birth Date',
                  infoValue: '1997-8-24',
                  withDivider: false,
                  dividerWidth: 1,
                  textColor: AppColors.black,
                ),*/ /*
                */ /*OneUserInfoCard(
                  infoKey: 'Points',
                  infoValue: '${UserSessionDataModel.points}',
                  withDivider: false,
                  dividerWidth: 1,
                  textColor: AppColors.black,
                ),*/ /*
                Divider(
                  thickness: 1,
                  color: AppColors.mansourDarkOrange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }*/
}
