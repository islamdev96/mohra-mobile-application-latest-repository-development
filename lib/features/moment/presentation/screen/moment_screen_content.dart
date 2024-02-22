import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/localization/localization_provider.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/challenge/domain/entity/challange_entity.dart';
import 'package:starter_application/features/challenge/presentation/state_m/cubit/challenge_cubit.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/moment/presentation/state_m/cubit/moment_cubit.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/moment_screen_notifier.dart';
import 'package:starter_application/features/moment/presentation/widget/moment_card.dart';
import 'package:starter_application/features/moment/presentation/widget/moment_header.dart';
import 'package:starter_application/features/moment/presentation/widget/ongoing_challenge_card.dart';
import 'package:starter_application/features/moment/presentation/widget/post_card.dart';
import 'package:starter_application/features/user/presentation/screen/view_friend_moments_screen.dart';
import 'package:starter_application/features/user/presentation/screen/view_profile_screen.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../core/ui/toast.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart'
    as c;

class MomentScreenContent extends StatefulWidget {
  const MomentScreenContent({Key? key}) : super(key: key);

  @override
  State<MomentScreenContent> createState() => _MomentScreenContentState();
}

class _MomentScreenContentState extends State<MomentScreenContent> {
  late MomentScreenNotifier sn;
  double vLineStart = 0.12.sw;
  double vLineTop = 0.15.sh;
  double vLineWidth = 7.w;
  double _headerHeight = 0.25.sh;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<MomentScreenNotifier>(context);
    sn.context = context;

    return sn.isLoading
        ? WaitingWidget()
        : Stack(
            // fit: StackFit.loose,
            children: [
              _buildContent(),
            ],
          );
  }

  /// Content
  Widget _buildContent() {
    return Positioned.fill(
      top: 0,
      left: 0,
      right: 0,
      child: RefreshConfiguration(
        headerBuilder: () => ClassicHeader(
          refreshingIcon: Padding(
            padding: EdgeInsets.only(top: _headerHeight),
            child: SizedBox(
              height: 70.h,
              width: 70.h,
              child: const CircularProgressIndicator.adaptive(),
            ),
          ),
          releaseIcon: Padding(
            padding: EdgeInsets.only(top: _headerHeight),
            child: SizedBox(
              height: 70.h,
              width: 70.h,
              child: const CircularProgressIndicator.adaptive(),
            ),
          ),
          textStyle: const TextStyle(
            fontSize: 0,
          ),
        ),
        child: PaginationWidget<MomentItemEntity>(
          items: sn.moments,
          getItems: sn.getMomentsItems,
          onDataFetched: sn.onMomentsItemsFetched,
          refreshController: sn.momentsRefreshController,
          footer: ClassicFooter(
            loadingText: "",
            noDataText: Translation.of(context).noDataRefresher,
            failedText: Translation.of(context).failedRefresher,
            idleText: "",
            canLoadingText: "",
            /*  loadingIcon: Padding(
              padding: EdgeInsets.only(
                bottom: AppConstants.bottomNavigationBarHeight + 300.h,
              ),
              child: const CircularProgressIndicator.adaptive(),
            ), */
            height: AppConstants.bottomNavigationBarHeight + 300.h,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                if (sn.moments.isNotEmpty) _buildVLine(color: Colors.grey[300]),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: AppConstants.screenPadding.right,
                    bottom: 30.h,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: _headerHeight - 50.h,
                      ),
                      BlocBuilder<ChallengeCubit, ChallengeState>(
                        bloc: sn.challengeCubit,
                        builder: (context, state) {
                          return state.maybeMap(
                              orElse: () => const ScreenNotImplementedError(),
                              challengeInitState: (_) => WaitingWidget(),
                              challengeLoadingState: (_) => WaitingWidget(),
                              challengeErrorState: (s) => ErrorScreenWidget(
                                    error: s.error,
                                    callback: s.callback,
                                  ),
                              challengesSuccess: (s) {
                                if (sn.challenges.isNotEmpty)
                                  return ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return _buildOngoingChallenge(
                                            sn.challenges.elementAt(index));
                                      },
                                      separatorBuilder: (context, index) {
                                        return Gaps.vGap64;
                                      },
                                      itemCount: sn.challenges.length);
                                return const SizedBox.shrink();
                              });
                        },
                      ),
                      Container(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _buildPostCard(
                                sn.moments[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Gaps.vGap15;
                            },
                            itemCount: sn.moments.length),
                      ),
                      // Gaps.vGap64,
                      // _buildPostCard_2(),
                      SizedBox(
                        height: AppConstants.bottomNavigationBarHeight,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    changeCoverImageTapper();
                  },
                  child: MomentHeader(
                    height: _headerHeight,
                    width: 1.sw,
                    image: UserSessionDataModel.coverPhoto,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: vLineTop - 150.h,
                      ),
                      MomentCard(
                        vLineStart: vLineStart,
                        vLineWidth: vLineWidth,
                        indicator: ClipOval(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: sn.context,
                                builder: (ctx) {
                                  return BottomSheet(
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "",
                                                  style: TextStyle(
                                                      fontSize: 50.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      Nav.pop();
                                                    },
                                                    icon: Icon(Icons.clear))
                                              ],
                                            ),
                                            Gaps.vGap16,
                                            buildEditImageCard(
                                              text: Translation.of(context)
                                                  .view_all_my_moments,
                                              onTap: () {
                                                Nav.pop();
                                                Nav.to(ViewFriendMomentsScreen.routeName,
                                                    arguments: c.ClientEntity(
                                                        addresses: [],
                                                        hasAvatar: true,
                                                        surname:
                                                            UserSessionDataModel
                                                                .surname,
                                                        qrCode: UserSessionDataModel
                                                                .qrCode ??
                                                            "",
                                                        code: UserSessionDataModel
                                                                .code ??
                                                            "",
                                                        fullName: UserSessionDataModel
                                                            .fullName,
                                                        id: UserSessionDataModel
                                                            .userId,
                                                        imageUrl: UserSessionDataModel
                                                            .imageUrl,
                                                        emailAddress:
                                                            UserSessionDataModel
                                                                .emailAddress,
                                                        name:
                                                            UserSessionDataModel
                                                                .name,
                                                        phoneNumber:
                                                            UserSessionDataModel
                                                                .phoneNumber,
                                                        countryCode:
                                                            UserSessionDataModel
                                                                    .countryCode ??
                                                                ""));
                                              },
                                              icon:
                                                  AppConstants.SVG_MOMENT_FILL,
                                            ),
                                            Gaps.vGap8,
                                            buildEditImageCard(
                                              text: Translation.of(context)
                                                  .Change_Profile_Photo,
                                              onTap: () {
                                                Nav.pop();
                                                changeProfileImageTapper();
                                              },
                                              icon:
                                                  'assets/images/svg/icon/gallary_icon.svg',
                                            ),
                                            Gaps.vGap32,
                                          ],
                                        ),
                                      );
                                    },
                                    onClosing: () {},
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(
                                          10,
                                        ),
                                      ),
                                    ),
                                    constraints: BoxConstraints(
                                      maxHeight: 1.sh,
                                      minHeight: 0.25.sh,
                                    ),
                                    enableDrag: false,
                                  );
                                },
                                isScrollControlled: true,
                                enableDrag: false,
                                isDismissible: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                constraints: BoxConstraints(
                                  maxHeight: 1.sh,
                                  minHeight: 0.25.sh,
                                ),
                              );
                            },
                            child: CustomNetworkImageWidget(
                              imgPath: UserSessionDataModel.imageUrl,
                              height: 150.h,
                              width: 150.h,
                              boxFit: BoxFit.cover,
                              errorImage: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 100.h,
                              ),
                            ),
                          ),
                        ),
                        content: CustomListTile(
                          title: Text(
                            "${UserSessionDataModel.fullName}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 65.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          subtitle: BlocConsumer<UserCubit, UserState>(
                            bloc: sn.userCubit,
                            listener: (context, state) {
                              if (state is GetAddressesDone) {
                                sn.onAddressLoaded(state.allAddressesEntity);
                              }
                            },
                            builder: (context, state) {
                              return state.maybeMap(getAddressesDone: (s) {
                                return Text(
                                  //TODO
                                  sn.userAddress,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40.sp,
                                  ),
                                );
                              }, orElse: () {
                                return Text(
                                  //TODO
                                  sn.userAddress,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40.sp,
                                  ),
                                );
                              });
                            },
                          ),
                          trailingFlex: 4,
                          trailing: Padding(
                            padding: EdgeInsetsDirectional.only(
                              end: 40.h,
                            ),
                            child: CustomMansourButton(
                              height: 80.h,
                              borderRadius: Radius.circular(20.r),
                              onPressed: () {
                                print(LocalizationProvider().appLocal);
                              },
                              backgroundColor: Colors.white,
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 70.h,
                                    width: 70.h,
                                    child: Image.asset(
                                      AppConstants.IMG_COIN,
                                      height: 70.h,
                                    ),
                                  ),
                                  Gaps.hGap16,
                                  Text(
                                    "${sn.points} ${Translation.current.points}",
                                    style: TextStyle(
                                      color: AppColors.primaryColorLight,
                                      fontSize: 45.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        indicatorWidth: 150.h,
                      ),
                    ],
                  ),
                ),
                // if (sn.moments.isNotEmpty)
                //   _buildVLine(height: 80.h, color: Colors.grey[300]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  changeProfileImageTapper() {
    showModalBottomSheet(
      context: sn.context,
      builder: (ctx) {
        return BottomSheet(
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.of(context).Change_Profile_Photo,
                        style: TextStyle(
                            fontSize: 50.sp, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            Nav.pop();
                          },
                          icon: Icon(Icons.clear))
                    ],
                  ),
                  Gaps.vGap16,
                  buildEditImageCard(
                    text: Translation.of(context).Open_Camera,
                    onTap: () {
                      sn.changeProfileImage(0);
                    },
                    icon: 'assets/images/svg/icon/camera_profile.svg',
                  ),
                  Gaps.vGap8,
                  buildEditImageCard(
                    text: Translation.of(context).Open_Gallery,
                    onTap: () {
                      sn.changeProfileImage(1);
                    },
                    icon: 'assets/images/svg/icon/gallary_icon.svg',
                  ),
                  Gaps.vGap8,
                  // buildEditImageCard(
                  //   text: Translation.of(context).Use_Avatar,
                  //   onTap: () {
                  //     sn.changeProfileImage(2);
                  //   },
                  //   icon: 'assets/images/svg/icon/use_avatar_icon.svg',
                  // ),
                  // Gaps.vGap8,
                  buildEditImageCard(
                    text: Translation.of(context).Delete_Profile_Image,
                    onTap: () {
                      sn.changeProfileImage(3);
                    },
                    icon: 'assets/images/svg/icon/delete_image_icon.svg',
                  ),
                ],
              ),
            );
          },
          onClosing: () {},
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                10,
              ),
            ),
          ),
          constraints: BoxConstraints(
            maxHeight: 1.sh,
            minHeight: 0.3.sh,
          ),
          enableDrag: false,
        );
      },
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            10,
          ),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: 1.sh,
        minHeight: 0.3.sh,
      ),
    );
  }

  changeCoverImageTapper() {
    showModalBottomSheet(
      context: sn.context,
      builder: (ctx) {
        return BottomSheet(
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.of(context).Change_Cover_Photo,
                        style: TextStyle(
                            fontSize: 50.sp, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            Nav.pop();
                          },
                          icon: Icon(Icons.clear))
                    ],
                  ),
                  Gaps.vGap16,
                  buildEditImageCard(
                    text: Translation.of(context).Open_Camera,
                    onTap: () {
                      sn.changeCoverImage(0);
                    },
                    icon: 'assets/images/svg/icon/camera_profile.svg',
                  ),
                  Gaps.vGap8,
                  buildEditImageCard(
                    text: Translation.of(context).Open_Gallery,
                    onTap: () {
                      sn.changeCoverImage(1);
                    },
                    icon: 'assets/images/svg/icon/gallary_icon.svg',
                  ),
                  Gaps.vGap8,
                  buildEditImageCard(
                    text: Translation.of(context).delete_image_title,
                    onTap: () {
                      sn.changeCoverImage(2);
                    },
                    icon: 'assets/images/svg/icon/delete_image_icon.svg',
                  ),
                ],
              ),
            );
          },
          onClosing: () {},
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                10,
              ),
            ),
          ),
          constraints: BoxConstraints(
            maxHeight: 1.sh,
            minHeight: 0.3.sh,
          ),
          enableDrag: false,
        );
      },
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            10,
          ),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: 1.sh,
        minHeight: 0.3.sh,
      ),
    );
  }

  buildEditImageCard({
    required Function() onTap,
    required String text,
    required String icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppColors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(onPressed: onTap, icon: SvgPicture.asset(icon)),
            Gaps.hGap12,
            Text(
              text,
              style: TextStyle(
                fontSize: 50.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Ongoing challenge
  Widget _buildOngoingChallenge(ChallangeItemEntity challangeItemEntity) {
    return OngoingChallengeCard(
      points: challangeItemEntity.points ?? 0,
      vLineStart: vLineStart,
      vLineWidth: vLineWidth,
      currentStep: challangeItemEntity.currentStep!,
      stepsTitles: sn.stepsTitles,
      challangeItemEntity: challangeItemEntity,
      onStepTap: () {
        if (challangeItemEntity.currentStep == 1) {
          sn.onFriendsTap(challangeItemEntity.id);
        }
        if (challangeItemEntity.currentStep == 2) {
          sn.onCreatePostTap(challangeItemEntity.id);
        }
        if (challangeItemEntity.currentStep == 3) {
          sn.claimRewards(challangeItemEntity.id);
        }
      },
      onChallengeCardTap: () => sn.onChallengeCardTap(challangeItemEntity),
    );
  }

  /// PostCard
  Widget _buildPostCard(MomentItemEntity item) {
    return BlocConsumer<MomentCubit, MomentState>(
      bloc: sn.reportDeleteCubit,
      listener: (context, state) {
        if (state is DeletePostSuccess) {
          sn.onDeleteSuccess();
          Toast.show(Translation.current.post_was_deleted_successfully,
              duration: 600);
        } else if (state is ReportPostSuccess) {
          sn.onReportSuccess();
          Toast.show(Translation.current.post_was_reported_successfully,
              duration: 600);
        }
      },
      builder: (context, state) {
        return state.maybeMap(orElse: () {
          return getCard(item);
        });
      },
    );
  }

  PostCard getCard(MomentItemEntity item) {
    return PostCard(
      vLineStart: vLineStart,
      vLineWidth: vLineWidth,
      item: item,
      onPostCreated: sn.onPostCreated,
      onOptionTap: () {
        onOptionTap(item);
      },
      viewInteractions: true,
      owner: checkOwner(item),
    );
  }

  //added by ali to delete and report
  Future<void> onOptionTap(MomentItemEntity item) async {
    bool delete = checkOwner(item);
    if (!delete) {
      reportReason(item);
    } else {
      sn.onDeleteTapped(item.id);
    }
  }

  reportReason(MomentItemEntity item) {
    showModalBottomSheet(
      context: sn.context,
      builder: (ctx) {
        return BottomSheet(
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Translation.current.report,
                    style:
                        TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    key: sn.writeReviewKey,
                    validator: (v) {
                      if (v != null && v.trim().isNotEmpty) return null;
                      return Translation.current.errorEmptyField;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: Translation.current.reason,
                    ),
                    style: const TextStyle(
                      color: AppColors.black,
                    ),
                    cursorColor: AppColors.mansourDarkOrange3,
                    controller: sn.reasonController,
                    onFieldSubmitted: (term) {
                      sn.reason = term;
                    },
                    onChanged: (value) {
                      sn.reason = value;
                    },
                  ),
                  Gaps.vGap32,
                  BlocConsumer<MomentCubit, MomentState>(
                    bloc: sn.reportDeleteCubit,
                    listener: (context, state) {
                      if (state is DeletePostSuccess) {
                        sn.onDeleteSuccess();
                        Toast.show(
                            Translation.current.post_was_deleted_successfully,
                            duration: 600);
                      } else if (state is ReportPostSuccess) {
                        sn.onReportSuccess();
                        Toast.show(
                            Translation.current.post_was_reported_successfully,
                            duration: 600);
                      }
                    },
                    builder: (context, state) {
                      return state.maybeMap(
                        orElse: () {
                          return CustomMansourButton(
                            titleText: Translation.current.confirm,
                            textColor: AppColors.lightFontColor,
                            onPressed: () {
                              sn.onReportTapped(item.id);
                            },
                          );
                        },
                        momentLoadingState: (value) {
                          return WaitingWidget();
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
          onClosing: () {},
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                10,
              ),
            ),
          ),
          constraints: BoxConstraints(
            maxHeight: 1.sh,
            minHeight: 0.3.sh,
          ),
          enableDrag: false,
        );
      },
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            10,
          ),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: 1.sh,
        minHeight: 0.4.sh,
      ),
    );
  }

  bool checkOwner(MomentItemEntity item) {
    return item.creatorUserId == UserSessionDataModel.userId;
  }

  buildOptionButtonLogic(MomentItemEntity item) {
    if (item.creatorUserId == UserSessionDataModel.userId) {}
  }

  /// PostCard
  // Widget _buildPostCard_2() {
  //   return PostCard(
  //     vLineStart: vLineStart,
  //     vLineWidth: vLineWidth,
  //     content: "I was there join the vision 2030 event",
  //     address: "69 Crooks Mission Apt. San Fransisco, CA94121",
  //     isChallenge: true,
  //   );
  // }

  /// Vertical line
  Widget _buildVLine({double? height, required Color? color}) {
    return Positioned.fill(
        right: AppConfig().isLTR ? 0 : vLineStart,
        left: AppConfig().isLTR ? vLineStart : 0,
        // right: AppConfig().isLTR ? 0 : vLineStart,
        top: vLineTop,
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: SizedBox(
            height: height,
            child: VerticalDivider(
              thickness: vLineWidth,
              width: 0,
              // color: AppColors.mansourLightGreyColor,
              color: color,
            ),
          ),
        ));
  }
}
