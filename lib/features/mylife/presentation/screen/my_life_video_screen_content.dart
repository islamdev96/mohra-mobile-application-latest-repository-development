import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/mylife/domain/entity/story_entity.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import 'package:starter_application/features/mylife/presentation/widget/story_comment_widget.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../screen/../state_m/provider/my_life_video_screen_notifier.dart';

class MyLifeVideoScreenContent extends StatefulWidget {

  const MyLifeVideoScreenContent({Key? key})
      : super(key: key);

  @override
  State<MyLifeVideoScreenContent> createState() =>
      _MyLifeVideoScreenContentState();
}

class _MyLifeVideoScreenContentState extends State<MyLifeVideoScreenContent> {
  late MyLifeVideoScreenNotifier sn;

  @override
  void initState() {
    super.initState();


  }

  @override
  void dispose() {


    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    sn = Provider.of<MyLifeVideoScreenNotifier>(context);
    sn.context = context;
    return Container(
      width: 1.sw,
      height: 1.sh,
      child:  BlocConsumer<MylifeCubit, MylifeState>(
        bloc: sn.myLifeCubit,
        builder: (context, state) {
          return state.maybeMap(
            orElse: ()=> const ScreenNotImplementedError(),
            taskPerDayLoadedSuccess: (s) => const ScreenNotImplementedError(),
            appointmentLoadedPerDayState: (s) => const ScreenNotImplementedError(),
            checkDreamSuccess: (s) => const ScreenNotImplementedError(),
            deleteDreamSuccess: (s) => const ScreenNotImplementedError(),
            mylifeInitState: (s) => const ScreenNotImplementedError(),
            mylifeLoadingState: (s) => WaitingWidget(),
            positiveCreated: (s) => const ScreenNotImplementedError(),
            checkTaskSuccess: (s) => const ScreenNotImplementedError(),
            taskLoadedSuccess: (s) =>const ScreenNotImplementedError(),
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
            sn.onStortLoaded(state.s);

          }

        },
      )
    );
  }

  buildScreen(){
    return Stack(
      children: [
        SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPlayer(),
                Gaps.vGap64,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sn.storyItem.title!,
                                  style: TextStyle(
                                      fontSize: 60.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Gaps.vGap32,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Html(
                                  data: sn.storyItem.description!,
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
        _buildButton()
      ],
    );
  }

  _buildPlayer(){
    if(sn.storyItem.videoLink != null) {
      if(sn.type == 'youtube'){
        return Container(
          child: YoutubePlayer(
            controller: sn.youtubePlayerController,
            aspectRatio: 16 / 9,
          ),
        );
      }
      else{
        return Container(
            height: 600.h,
            child: Chewie(
              controller: sn.chewieController,
            ));
      }
    }
    else {
      return SizedBox(height: 20,);
    }
    }



  _buildButton() {
    return Positioned(
        bottom: 0,
        child: Container(
          width: 1.sw,
          height: 300.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StoryComment(
                  commentCount: sn.commentsCount,
                  isVideo: true,
                  likeCount: sn.storyItem.likesCount,
                  likeClicked: (){
                    sn.likeClicked();
                  },
                  isLiked: sn.storyItem.isLiked ?? false,
                  onCommentSectionTap: () {
                    sn.viewCommentSection = true;
                  },
                  disLikeClicked: (){

                  }
                ),
                InkWell(
                  onTap: () {
                    sn.shareVideoStory(sn.storyItem.id!.toString());
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
