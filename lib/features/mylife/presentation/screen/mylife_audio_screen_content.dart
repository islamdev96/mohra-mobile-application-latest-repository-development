import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/mylife/domain/entity/story_entity.dart';
import 'package:starter_application/features/mylife/presentation/logic/common_audio_player.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import 'package:starter_application/features/mylife/presentation/widget/story_comment_widget.dart';
import '../screen/../state_m/provider/mylife_audio_screen_notifier.dart';
import 'package:audio_session/audio_session.dart';
class MyLifeAudioScreenContent extends StatefulWidget  {

  const MyLifeAudioScreenContent({Key? key})
      : super(key: key);
  @override
  State<MyLifeAudioScreenContent> createState() =>
      _MyLifeAudioScreenContentState();
}

class _MyLifeAudioScreenContentState extends State<MyLifeAudioScreenContent> with WidgetsBindingObserver  {
  late MylifeAudioScreenNotifier sn;



  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    sn = Provider.of<MylifeAudioScreenNotifier>(context);
    sn.context = context;
    return Padding(
      padding: sn.padding,
      child: Container(
        width: 1.sw,
        height: 1.sh,
        child:
        BlocConsumer<MylifeCubit, MylifeState>(
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

        ,
      ),
    );
  }

  buildScreen(){
    return Stack(
      children: [_buildHeader(), _buildButton()],
    );
  }
  _buildHeader() {
    //print(widget.entity.videoLink!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.vGap12,
        /*Container(
          height: 0.3.sh,
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 40.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r),
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
            image: const DecorationImage(
              image: AssetImage(
                "assets/images/png/temp/audio.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),*/
        Gaps.vGap64,
        ControlButtons(sn.player),
        // Display seek bar. Using StreamBuilder, this widget rebuilds
        // each time the position, buffered position or duration changes.
        StreamBuilder<PositionData>(
          stream: _positionDataStream,
          builder: (context, snapshot) {
            final positionData = snapshot.data;
            return SeekBar(
              duration: positionData?.duration ?? Duration.zero,
              position: positionData?.position ?? Duration.zero,
              bufferedPosition:
              positionData?.bufferedPosition ?? Duration.zero,
              onChangeEnd: sn.player.seek,

            );
          },
        ),
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
        Gaps.vGap24,
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
    );
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

                  },
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      sn.player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          sn.player.positionStream,
          sn.player.bufferedPositionStream,
          sn.player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));


  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    sn.player.dispose();
    super.dispose();
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        // Opens volume slider dialog
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 50.0,
                height: 50.0,
                child: const CircularProgressIndicator(
                  color: AppColors.mansourDarkOrange,
                ),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 64.0,
                onPressed: player.play,
                color: AppColors.mansourDarkOrange,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: player.speed,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}
