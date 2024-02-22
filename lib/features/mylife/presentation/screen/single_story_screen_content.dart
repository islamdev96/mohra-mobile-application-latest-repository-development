import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/mylife/domain/entity/story_entity.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import 'package:starter_application/features/mylife/presentation/widget/story_comment_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../main.dart';
import '../screen/../state_m/provider/single_story_screen_notifier.dart';

class SingleStoryScreenContent extends StatefulWidget {
  const SingleStoryScreenContent({Key? key}) : super(key: key);

  @override
  State<SingleStoryScreenContent> createState() =>
      _SingleStoryScreenContentState();
}

class _SingleStoryScreenContentState extends State<SingleStoryScreenContent> {
  late SingleStoryScreenNotifier sn;

  @override
  void initState() {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SingleStoryScreenNotifier>(context);
    sn.context = context;
    return Container(
      width: 1.sw,
      height: 1.sh,
      child: BlocConsumer<MylifeCubit, MylifeState>(
        bloc: sn.myLifeCubit,
        builder: (context, state) {
          return state.maybeMap(
            orElse: () => const ScreenNotImplementedError(),
            taskPerDayLoadedSuccess: (s) => const ScreenNotImplementedError(),
            appointmentLoadedPerDayState: (s) =>
                const ScreenNotImplementedError(),
            checkDreamSuccess: (s) => const ScreenNotImplementedError(),
            deleteDreamSuccess: (s) => const ScreenNotImplementedError(),
            mylifeInitState: (s) => const ScreenNotImplementedError(),
            mylifeLoadingState: (s) => WaitingWidget(),
            positiveCreated: (s) => const ScreenNotImplementedError(),
            checkTaskSuccess: (s) => const ScreenNotImplementedError(),
            taskLoadedSuccess: (s) => const ScreenNotImplementedError(),
            appointmentLoadedState: (s) => const ScreenNotImplementedError(),
            clientLoadedState: (s) => const ScreenNotImplementedError(),
            createTaskSuccess: (s) => const ScreenNotImplementedError(),
            createAppointmentSuccess: (s) => const ScreenNotImplementedError(),
            storiesLoadedState: (s) => const ScreenNotImplementedError(),
            qouteLoadedSuccess: (s) => const ScreenNotImplementedError(),
            mylifeErrorState: (s) => ErrorScreenWidget(
              error: s.error,
              callback: s.callback,
            ),
            dreamListLoaded: (s) => const ScreenNotImplementedError(),
            dreamCreated: (s) => const ScreenNotImplementedError(),
            createDream: (s) => const ScreenNotImplementedError(),
            positivesListLoaded: (s) => const ScreenNotImplementedError(),
            imageUploaded: (s) => const ScreenNotImplementedError(),
            deleteItemSuccess: (s) => const ScreenNotImplementedError(),
            storyLoaded: (s) => buildScreen(),
          );
        },
        listener: (context, state) {
          if (state is StoryLoaded) {
            sn.onStortLoaded(state.s, isArabic);
          }
        },
      ),
    );
  }

  buildScreen() {
    return Stack(
      children: [
        SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.vGap24,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 0.8.sw,
                              child: Text(
                                sn.title ?? "",
                                style: TextStyle(
                                    fontSize: 60.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  sn.updateLang(!sn.isEnglish);
                                },
                                child: Text(
                                  sn.isEnglish ? "English" : "Arabic",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: AppColors.primaryColorLight),
                                )),
                            Gaps.vGap24,
                            Text(
                              timeago.format(
                                  "".setTime(sn.storyItem.creationTime!)),
                              style: TextStyle(
                                  fontSize: 35.sp,
                                  color: AppColors.mansourWhiteBackgrounColor_6,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gaps.vGap32,
                  Container(
                    height: 0.3.sh,
                    decoration: sn.storyItem.imageUrl!.isNotEmpty
                        ? BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.r),
                              bottomRight: Radius.circular(20.r),
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(sn.storyItem.imageUrl!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.r),
                              bottomRight: Radius.circular(20.r),
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r),
                            ),
                            image: const DecorationImage(
                              image: AssetImage(
                                "assets/images/png/temp/singleStory.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Html(
                              data: sn.description ?? "",
                            ),
                            // Text(
                            //   sn.storyItem.description!,
                            //   style: TextStyle(
                            //     fontSize: 45.sp,
                            //     color:
                            //         AppColors.mansourNotSelectedBorderColor,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gaps.vGap64,
                ],
              ),
            ),
            SizedBox(
              height: 200.h,
            ),
          ],
        )),
        _buildButton(),
      ],
    );
  }

  _buildButton() {
    return Positioned(
        bottom: 0,
        child: Container(
          color: AppColors.white,
          width: 1.sw,
          height: 200.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StoryComment(
                  isVideo: false,
                  commentCount: sn.commentsCount,
                  likeCount: sn.storyItem.likesCount,
                  likeClicked: () {
                    setState(() {
                      sn.likeClicked();
                    });
                  },
                  isLiked: sn.storyItem.isLiked ?? false,
                  onCommentSectionTap: () {
                    sn.viewCommentSection = true;
                  },
                  disLikeClicked: () {},
                ),
                InkWell(
                  onTap: () {
                    sn.shareStory(sn.storyItem.id!.toString());
                  },
                  child: SvgPicture.asset(
                    AppConstants.SVG_SHARE_FILL,
                    color: AppColors.black_text,
                    height: 50.h,
                    width: 50.h,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
