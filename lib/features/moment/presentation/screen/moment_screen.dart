import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/challenge/presentation/state_m/cubit/challenge_cubit.dart';
import 'package:starter_application/features/moment/presentation/state_m/cubit/moment_cubit.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/moment_screen_notifier.dart';
import 'package:starter_application/features/moment/presentation/widget/post_option_widget.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../user/presentation/state_m/cubit/user_cubit.dart';
import 'moment_screen_content.dart';

class MomentScreen extends StatefulWidget {
  static const routeName = "/MomentScreen";
  const MomentScreen({Key? key}) : super(key: key);

  @override
  _MomentScreenState createState() => _MomentScreenState();
}

class _MomentScreenState extends State<MomentScreen> with SingleTickerProviderStateMixin {
  MomentScreenNotifier sn = MomentScreenNotifier();
  late AnimationController _animationController;

  List<Widget> addPostChoices = [];

  @override
  void initState() {
    refreshPage();
    //sn.getUserAddresses();
    super.initState();
  }


  refreshPage({bool isBuild = false}){
    if(!isBuild) {
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
        upperBound: 0.5,
      );
      addPostChoices = [
        PostOptionWidget(
            width: 100.h,
            height: 100.h,
            iconData: Icons.edit,
            onTap: () =>
            sn.opacityNotifier.value == 0 ? () {} : sn.onAddPostTap(null),
            title: Translation.current.post_noun),
        PostOptionWidget(
          width: 100.h,
          height: 100.h,
          iconData: Icons.play_arrow,
          onTap: () =>
          sn.opacityNotifier.value == 0 ? () {} : sn.onAddPostTap(null),
          title: Translation.current.video,
        ),
        PostOptionWidget(
          width: 100.h,
          height: 100.h,
          iconData: Icons.music_note,
          onTap: () =>
          sn.opacityNotifier.value == 0 ? () {} : sn.onAddPostTap(null),
          title: Translation.current.music_2,
          iconColor: Colors.black,
        ),
        PostOptionWidget(
          width: 100.h,
          height: 100.h,
          iconData: Icons.location_on,
          onTap: () =>
          sn.opacityNotifier.value == 0 ? () {} : sn.onCheckInTap(null),
          title: Translation.current.check_in_moment,
          iconColor: AppColors.mansourLightBlueColor,
        ),
        PostOptionWidget(
          width: 100.h,
          height: 100.h,
          iconData: Icons.tag_faces_rounded,
          onTap: () =>
          sn.opacityNotifier.value == 0 ? () {} : sn.onAddFeelingTap(null),
          title: Translation.current.feeling_noun,
        ),
        PostOptionWidget(
            width: 100.h,
            height: 100.h,
            backgroundColor: AppColors.primaryColorLight,
            iconColor: Colors.white,
            iconPath: AppConstants.SVG_CLOSE,
            onTap: () => Nav.pop(),
            title: ""),
      ];
    }
    sn.getMoments();
    sn.getPoints();
    sn.getMyChallenges();
  }
  @override
  Widget build(BuildContext context) {
    refreshPage(isBuild: true);
    return ProgressHUD(
      indicatorWidget: Material(
        color: Colors.transparent,
        child: TextWaitingWidget(
          Translation.current.claiming_rewards,
          textColor: Colors.white,
        ),
      ),
      child: ChangeNotifierProvider.value(
          value: sn,
          child: MultiBlocListener(
              listeners: [
                BlocListener<ChallengeCubit, ChallengeState>(
                  bloc: sn.challengeCubit,
                  listener: (context, state) {
                    state.mapOrNull(
                      challengesSuccess: (value) {
                        sn.addToChallenge(value.momentEntity.items!);
                      },
                    );
                  },
                  listenWhen: (previous, current) {
                    return true;
                  },
                ),
                BlocListener<ChallengeCubit, ChallengeState>(
                  bloc: sn.challengeStepsCubit,
                  listener: (context, state) {
                    state.mapOrNull(inviteFriendsLoadingState: (_) {
                      sn.loading(true);
                    }, inviteFriendsSuccess: (_) {
                      sn.loading(false);
                      sn.getMyChallenges();
                      // sn.itemEntity.currentStep = 2;
                    }, claimRewardsLoadingState: (_) {
                      ProgressHUD.of(context)!.show();
                      // sn.itemEntity.currentStep = 2;
                    }, claimRewardsSuccess: (_) {
                      ProgressHUD.of(context)!.dismiss();
                      sn.getMyChallenges();
                      showSnackbar(Translation.current.reward_claimed);
                    }, challengeErrorState: (s) {
                      ProgressHUD.of(context)!.dismiss();
                      ErrorViewer.showError(
                        context: context,
                        error: s.error,
                        callback: s.callback,
                      );
                    });
                  },
                  listenWhen: (previous, current) {
                    return true;
                  },
                ),
                BlocListener<MomentCubit, MomentState>(
                  bloc: sn.pointsCubit,
                  listener: (context, state) {
                    state.mapOrNull(
                      pointsLoadedSuccess: (value) {
                        sn.pointLoaded(value.pointsEntity);
                        sn.loading(false);
                      },
                      momentErrorState: (s) {
                        sn.loading(false);
                        ErrorViewer.showError(
                          context: context,
                          error: s.error,
                          callback: s.callback,
                        );
                      },
                    );
                  },
                ),
                BlocListener<MomentCubit, MomentState>(
                  bloc: sn.momentCubit,
                  listener: (context, state) {
                    state.mapOrNull(momentsLoadedSuccess: (value) {
                      sn.MomentsLoaded(value.momentEntity);
                      sn.loading(false);
                    }, momentErrorState: (s) {
                      sn.loading(false);
                      ErrorViewer.showError(
                        context: context,
                        error: s.error,
                        callback: s.callback,
                      );
                    });
                  },
                ),
                BlocListener<UserCubit, UserState>(
                    bloc: sn.userCubit,
                    listener: (context, state) {
                      if (state is UploadImageDone) {
                        sn.onUpdateProfileImageDone(state.imageUrlsEntity);
                        setState(() {});
                      }
                      if (state is UpdateProfileDone) {
                        Nav.pop();
                        sn.onUpdateProfleDone(state.updateProfileEntity);
                        setState(() {});
                      }
                      if (state is AvatarLoaded) {
                        // sn.onLoadedAvatar(state.avatarListEntity);
                        // setState(() {});
                      }
                    },)
              ],
              child: Scaffold(
                backgroundColor: AppColors.mansourWhiteBackgrounColor_2,
                body: Stack(
                  children: [
                    BlocBuilder<MomentCubit, MomentState>(
                      bloc: sn.momentCubit,
                      builder: (context, state) {
                        return state.maybeMap(
                          orElse: () => const ScreenNotImplementedError(),
                          momentInitState: (_) => WaitingWidget(),
                          momentLoadingState: (_) => WaitingWidget(),
                          momentErrorState: (s) => ErrorScreenWidget(
                              error: s.error, callback: s.callback),
                          momentsLoadedSuccess: (s) =>
                              const MomentScreenContent(),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: sn.isAddOpenedNotifier,
                      builder: (_,value,___){
                        return Visibility(
                          visible: value as bool,
                          child: GestureDetector(
                            onTap: (){
                              sn.closeAdd();
                            },
                            child: Container(
                              height: 1.sh,
                              width: 1.sw,
                              color: AppColors.black.withOpacity(0.5),

                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: sn.positionNotifier0,
                      builder: (_,double p,___){
                        return AnimatedPositioned(
                          duration: Duration(milliseconds: 300),
                          bottom:   300.h,
                          right:  p ,
                          child:ValueListenableBuilder(
                            valueListenable: sn.opacityNotifier,
                            builder: (_,double p,___){
                              return  AnimatedOpacity(
                                duration: Duration(milliseconds: 300),
                                opacity: p,
                                child: Row(
                                  children: [
                                    addPostChoices[0]
                                  ],
                                ),
                              );
                            },
                          )

                         ,
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: sn.positionNotifier1,
                      builder: (_,double p,___){
                        return AnimatedPositioned(
                          duration: Duration(milliseconds: 300),
                          bottom:   300.h,
                          right:  p ,
                          child:ValueListenableBuilder(
                            valueListenable: sn.opacityNotifier,
                            builder: (_,double p,___){
                              return  AnimatedOpacity(
                                duration: Duration(milliseconds: 300),
                                opacity: p,
                                child: Row(
                                  children: [
                                    addPostChoices[1]
                                  ],
                                ),
                              );
                            },
                          )

                          ,
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: sn.positionNotifier2,
                      builder: (_,double p,___){
                        return AnimatedPositioned(
                          duration: Duration(milliseconds: 300),
                          bottom:   300.h,
                          right:  p ,
                          child:ValueListenableBuilder(
                            valueListenable: sn.opacityNotifier,
                            builder: (_,double p,___){
                              return  AnimatedOpacity(
                                duration: Duration(milliseconds: 300),
                                opacity: p,
                                child: Row(
                                  children: [
                                    addPostChoices[2]
                                  ],
                                ),
                              );
                            },
                          )

                          ,
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: sn.positionNotifier3,
                      builder: (_,double p,___){
                        return AnimatedPositioned(
                          duration: Duration(milliseconds: 300),
                          bottom:   300.h,
                          right:  p ,
                          child:ValueListenableBuilder(
                            valueListenable: sn.opacityNotifier,
                            builder: (_,double p,___){
                              return  AnimatedOpacity(
                                duration: Duration(milliseconds: 300),
                                opacity: p,
                                child: Row(
                                  children: [
                                    addPostChoices[3]
                                  ],
                                ),
                              );
                            },
                          )

                          ,
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: sn.positionNotifier4,
                      builder: (_,double p,___){
                        return AnimatedPositioned(
                          duration: Duration(milliseconds: 300),
                          bottom:   300.h,
                          right:  p ,
                          child:ValueListenableBuilder(
                            valueListenable: sn.opacityNotifier,
                            builder: (_,double p,___){
                              return  AnimatedOpacity(
                                duration: Duration(milliseconds: 300),
                                opacity: p,
                                child: Row(
                                  children: [
                                    addPostChoices[4]
                                  ],
                                ),
                              );
                            },
                          )

                          ,
                        );
                      },
                    ),
                    Positioned(
                        bottom: 230.h,
                        right: 20.w,
                        child: Column(
                          children: [
                            Container(
                              width: 120.h ,
                              height: 120.h,
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryColorLight,
                                  shape: BoxShape.circle),
                              child: RotationTransition(
                                turns: Tween(begin: 0.0, end: 1.0)
                                    .animate(_animationController),
                                child: Center(
                                  child: AnimateIcons(
                                    startIcon: Icons.add,
                                    endIcon: Icons.close,
                                    size: 30.0,
                                    controller: sn.animateIconController,
                                    // add this tooltip for the start icon
                                    startTooltip: 'Icons.add_circle',
                                    // add this tooltip for the end icon
                                    endTooltip: 'Icons.add_circle_outline',
                                    onStartIconPress: sn.openAdd,
                                    onEndIconPress: sn.closeAdd,
                                    duration:const Duration(milliseconds: 300),
                                    startIconColor: AppColors.white,
                                    endIconColor: AppColors.white,
                                    clockwise: false,
                                  ) ,

                                ),
                              ),
                            ),
                            Gaps.vGap32,
                            Container(
                              height: 120.h *.35,
                              child: Text(
                                '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 120.h * 0.3,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )),


                  ],
                ),
              ),),),
    );
  }
}
