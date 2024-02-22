import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/story_details_screen_params.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/days_list.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/mylife/data/model/request/get_stories_request.dart';
import 'package:starter_application/features/mylife/domain/entity/DreamListEntity.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/features/mylife/presentation/screen/single_story_screen.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import 'package:starter_application/features/mylife/presentation/widget/add_fab_expendable.dart';
import 'package:starter_application/features/mylife/presentation/widget/dreams/dream_card_expanition_tile.dart';
import 'package:starter_application/features/mylife/presentation/widget/positive_widget.dart';
import 'package:starter_application/features/mylife/presentation/widget/stroy_widget.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../main.dart';
import '../screen/../state_m/provider/mylife_home_screen_screen_notifier.dart';
import 'dream_screen.dart';
import 'my_life_video_screen.dart';
import 'mylife_audio_screen.dart';

class MyLifeHomeScreenScreenContent extends StatefulWidget {
  @override
  State<MyLifeHomeScreenScreenContent> createState() =>
      _MyLifeHomeScreenScreenContentState();
}

class _MyLifeHomeScreenScreenContentState
    extends State<MyLifeHomeScreenScreenContent>
    with SingleTickerProviderStateMixin {
  late MyLifeHomeScreenScreenNotifier sn;
  double HeaderHeight = 350.h;
  EdgeInsets padding = EdgeInsets.symmetric(horizontal: 50.w, vertical: 30.h);
  EdgeInsets linearPadding =
      EdgeInsets.symmetric(horizontal: 80.w, vertical: 30.h);
  EdgeInsets vPadding = EdgeInsets.symmetric(vertical: 40.h);
  EdgeInsets floatPadding =
      EdgeInsets.symmetric(horizontal: 70.w, vertical: 50.h);
  EdgeInsets floatPaddingAR =
      EdgeInsets.symmetric(horizontal: 50.w, vertical: 30.h);
  EdgeInsets sPadding = EdgeInsets.symmetric(horizontal: 60.w, vertical: 40.h);
  BorderRadius border = BorderRadius.circular(30.r);
  late List<Widget> myLifePickerItems = [];
  late AnimationController _animationController;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      upperBound: 0.5,
    );

    myLifePickerItems = [
      _buildWheelItem(
        title: Translation.current.to_do_list,
        icon: AppConstants.SVG_TO_DO_PLIST_MY_LIFE,
        onTap: () {
          sn.goToDoScreen();
        },
      ),
      _buildWheelItem(
        title: Translation.current.appointment,
        icon: AppConstants.SVG_APPOINTMENT_MY_LIFE,
        onTap: () {
          sn.goToAppointmentScreen();
        },
      ),
      _buildWheelItem(
        title: Translation.current.dreams,
        icon: AppConstants.SVG_DREAMS_MY_LIFE,
        onTap: () {
          sn.goToDreamScreen();
        },
      ),
      _buildWheelItem(
        title: Translation.current.positivity,
        icon: AppConstants.SVG_POSITIVITY_MY_LIFE,
        onTap: () {
          sn.goToPositivityScreen();
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<MyLifeHomeScreenScreenNotifier>(context);
    sn.context = context;
    return BlocConsumer<MylifeCubit, MylifeState>(
      bloc: sn.myLifeCubit,
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => _buildScreen(),
          storyLoaded: (s) => const ScreenNotImplementedError(),
          taskPerDayLoadedSuccess: (s) => _buildScreen(),
          appointmentLoadedPerDayState: (s) => _buildScreen(),
          checkDreamSuccess: (s) => _buildScreen(),
          deleteDreamSuccess: (s) => _buildScreen(),
          mylifeInitState: (s) => WaitingWidget(),
          mylifeLoadingState: (s) => WaitingWidget(),
          positiveCreated: (s) => const ScreenNotImplementedError(),
          checkTaskSuccess: (s) => _buildScreen(),
          taskLoadedSuccess: (s) => _buildScreen(),
          appointmentLoadedState: (s) => _buildScreen(),
          clientLoadedState: (s) => const ScreenNotImplementedError(),
          createTaskSuccess: (s) => const ScreenNotImplementedError(),
          createAppointmentSuccess: (s) => const ScreenNotImplementedError(),
          storiesLoadedState: (s) => _buildScreen(),
          qouteLoadedSuccess: (s) => _buildScreen(),
          mylifeErrorState: (s) => ErrorScreenWidget(
            error: s.error,
            callback: s.callback,
          ),
          dreamListLoaded: (s) => _buildScreen(),
          dreamCreated: (s) => const ScreenNotImplementedError(),
          createDream: (s) => const ScreenNotImplementedError(),
          positivesListLoaded: (s) => _buildScreen(),
          imageUploaded: (s) => const ScreenNotImplementedError(),
          deleteItemSuccess: (s) => const ScreenNotImplementedError(),
        );
      },
      listener: (context, state) {
        if (state is AppointmentLoadedState) {
          sn.appointmentsLoadSuccess(state.eventsEntity);
          if (sn.isFirst) {}
        }
        if (state is TaskLoadedSuccess) {
          sn.tasksLoadSuccess(state.taskEntity);
        }
        if (state is DreamListLoaded) {
          sn.dreamsLoadSuccess(state.dreamListEntity);
        }
        if (state is PositivesListLoaded) {
          sn.positivesLoadSuccess(state.dreamListEntity);
        }
        if (state is StoriesLoadedState) {
          sn.storiesLoadSuccess(state.storyEntity);
        }
        if (state is QouteLoadedSuccess) {
          sn.quoteLoaded(state.quoteEntity.quote.name);
        }
        if (state is CheckTaskSuccess) {
          sn.selectedIds.clear();
        }
        if (state is CheckDreamSuccess) {
          sn.getHomeItemsByDate(DateTime.now(),
              withLoading: false, state: StateMyLife.Dreams);
        }
      },
    );
  }

  /*_buildAnimatedFAB(){
    return ;
  }*/

  _buildScreen() {
    return Container(
      height: 1.sh,
      width: 1.sw,
      color: AppColors.mansourLightGreyColor_4,
      child: RefreshIndicator(
        onRefresh: sn.onRefresh,
        child: Stack(
          children: [
            Container(
              height: 0.9.sh,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Stack(
                  children: [
                    Visibility(
                      visible: !sn.isStory,
                      child: Column(
                        children: [
                          header(),
                          _homeContent(),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: sn.isStory,
                      child: Column(
                        children: [header(), _storyContent()],
                      ),
                    ),
                    floatContainer(),
                  ],
                ),
              ),
            ),
            //bottomWidget2(),
            Visibility(
              visible: sn.isAddOpened,
              child: GestureDetector(
                onTap: () {
                  sn.closeAdd();
                },
                child: Container(
                  height: 1.sh,
                  width: 1.sw,
                  color: AppColors.black.withOpacity(0.5),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              bottom: sn.isAddOpened ? 950.h : 300.h,
              right: 20.w,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: sn.opacity,
                child: Row(
                  children: [myLifePickerItems[0]],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              bottom: sn.isAddOpened ? 800.h : 300.h,
              right: 20.w,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: sn.opacity,
                child: Row(
                  children: [myLifePickerItems[1]],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              bottom: sn.isAddOpened ? 650.h : 300.h,
              right: 20.w,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: sn.opacity,
                child: Row(
                  children: [myLifePickerItems[2]],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              bottom: sn.isAddOpened ? 500.h : 300.h,
              right: 20.w,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: sn.opacity,
                child: Row(
                  children: [myLifePickerItems[3]],
                ),
              ),
            ),
            Positioned(
                bottom: 300.h,
                right: 20.w,
                child: sn.isOneSelect
                    ? Container(
                        width: 120.h,
                        height: 120.h,
                        decoration: const BoxDecoration(
                            color: AppColors.primaryColorLight,
                            shape: BoxShape.circle),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              sn.onTapWhenSelected();
                            },
                            icon: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                          /*IconButton(
                        onPressed: () {
                          if (isExpanded) {
                            _animationController..reverse(from: 0.5);
                          } else {
                            _animationController..forward(from: 0.0);
                          }
                          sn.onTabAddFloat(
                            items: myLifePickerItems,
                            itemRadius: 200.r,
                            centerRadius: 300.r,
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      )*/
                        ),
                      )
                    : Container(
                        width: 120.h,
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
                              duration: const Duration(milliseconds: 300),
                              startIconColor: AppColors.white,
                              endIconColor: AppColors.white,
                              clockwise: false,
                            ),
                            /*IconButton(
                          onPressed: () {
                            if (isExpanded) {
                              _animationController..reverse(from: 0.5);
                            } else {
                              _animationController..forward(from: 0.0);
                            }
                            sn.onTabAddFloat(
                              items: myLifePickerItems,
                              itemRadius: 200.r,
                              centerRadius: 300.r,
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                        )*/
                          ),
                        ),
                      )),
          ],
        ),
      ),
    );
  }

  Widget floatContainer() {
    return Positioned(
      top: HeaderHeight / 1.8,
      right: 50.w,
      left: 50.h,
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.r),
          color: Colors.white,
        ),
        child: Padding(
          padding:
              AppConfig().appLanguage == 'ar' ? floatPaddingAR : floatPadding,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _floatContainerItem(
                      name: Translation.current.story,
                      number: sn.stories2.length,
                      icon: AppConstants.SVG_STORY_PLIST_MY_LIFE,
                      onPress: () {
                        sn.selectStory();
                      }),
                  _floatContainerItem(
                      name: Translation.current.dreams,
                      number: sn.dreams2.length,
                      icon: AppConstants.SVG_DREAMS_MY_LIFE,
                      onPress: () {
                        sn.goToDreamScreen();
                      }),
                  _floatContainerItem(
                      name: Translation.current.to_do,
                      number: sn.tasks.length,
                      icon: AppConstants.SVG_TO_DO_PLIST_MY_LIFE,
                      onPress: () {
                        sn.goToDoScreen();
                      }),
                ],
              ),
              Gaps.vGap32,
              Row(
                children: [
                  _floatContainerItem(
                      name: Translation.current.positivity,
                      number: sn.positives.length,
                      icon: AppConstants.SVG_POSITIVITY_MY_LIFE,
                      onPress: () {
                        sn.goToPositivityScreen();
                      }),
                  Gaps.hGap32,
                  _floatContainerItem(
                      name: Translation.current.appointment,
                      number: sn.appointments2.length,
                      icon: AppConstants.SVG_APPOINTMENT_MY_LIFE,
                      onPress: () {
                        sn.goToAppointmentScreen();
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      width: 1.sw,
      height: HeaderHeight,
      padding: EdgeInsets.symmetric(horizontal: 50.h, vertical: 30.h),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topEnd,
          end: AlignmentDirectional.topStart,
          colors: AppColors.healthOrangeGradiant,
        ),
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 80.h,
              width: 80.h,
              child: SvgPicture.asset(
                AppConstants.SVG_FORMAT_MY_LIFE,
                color: Colors.white,
              ),
            ),
          ),
          Gaps.hGap64,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "“${sn.quote}”",
                  style: TextStyle(
                    fontSize: 43.sp,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _homeContent() {
    return Container(
      color: AppColors.mansourLightGreyColor_4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gaps.vGap64,
          Container(
            height: 100.h,
            width: 1.sw,
            color: AppColors.mansourLightGreyColor_4,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 15.h),
            ),
          ),
          _contentWidget(
              text: Translation.current.appointments,
              title: Translation.current.you_dont_have_appointment_today,
              button: Translation.current.add_appointment,
              onPress: () {
                sn.goToAppointmentScreen();
              },
              icon: AppConstants.SVG_AppointmentToday,
              child: sn.appointments2.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return appointmentItem(
                            check: sn.appointments2[index].isDone!,
                            //  image: sn.appointments[index].image,
                            date: sn.appointments2[index].startDate!,
                            end: sn.appointments2[index].toHour!,
                            color: sn.appointments2[index].priority!,
                            start: sn.appointments2[index].fromHour!,
                            // persons: sn.appointments[index].persons,
                            title: sn.appointments2[index].title!,
                            index: index,
                            isSelected: sn.appointments2[index].isSelected);
                      },
                      separatorBuilder: (context, index) {
                        return Gaps.vGap8;
                      },
                      itemCount: sn.appointments2.length,
                    )
                  : null),
          _contentWidget(
            text: Translation.current.to_do_list,
            title: Translation.current.you_dont_have_todo_list_today,
            button: Translation.current.add_todo_list,
            icon: AppConstants.SVG_ToDoListToday,
            onPress: () {
              sn.goToDoScreen();
            },
            child: sn.tasks.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _buildTodoWidget(
                        date: '${sn.tasks[index].date}',
                        title: sn.tasks[index].title!,
                        color: sn.tasks[index].priority!,
                        index: index,
                        checked: sn.tasks[index].isAchieved,
                        isSelected: sn.tasks[index].isSelected,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Gaps.vGap32;
                    },
                    itemCount: sn.tasks.length,
                  )
                : null,
          ),
          _contentWidget(
              text: Translation.current.my_dreams,
              title: Translation.current.help_to_reach_dreams_message,
              button: Translation.current.add_my_dreams,
              icon: AppConstants.SVG_DREAM,
              onPress: () {
                sn.goToDreamScreen();
              },
              child: sn.dreams2.isNotEmpty
                  ? ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _buildDreamExpenationTile(
                          '${sn.dreams2[index].title}',
                          '${sn.dreams2[index].imageUrl}',
                          sn.dreams2[index].steps,
                          sn.dreams2[index].achievedStepsCount,
                          sn.dreams2[index].totalStepsCount,
                          AppColors.primaryColorDark,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Gaps.vGap32;
                      },
                      itemCount: sn.dreams2.length,
                    )
                  : null),
          Padding(
            padding: sPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translation.current.story,
                  style:
                      TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold),
                ),
                Gaps.vGap64,
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return StoryWidget(
                      image: sn.stories[0].image,
                      name: sn.stories[0].name,
                      isAudio: sn.stories[0].isAudio,
                      icon: AppConstants.SVG_MIC,
                      item: sn.stories2[index],
                      isVideo: sn.stories[0].isVideo,
                      onTap: () {
                        if (sn.stories2[index].stroyType == "Video") {
                          UserSessionDataModel.storyId = sn.stories2[index].id!;
                          Nav.to(MyLifeVideoScreen.routeName).then((value) {
                            sn.getHomeItemsByDate(DateTime.now(),
                                withLoading: false, state: StateMyLife.Stories);

                            setState(() {});
                          });
                        } else if (sn.stories2[index].stroyType == "Voice") {
                          UserSessionDataModel.storyId = sn.stories2[index].id!;
                          Nav.to(MylifeAudioScreen.routeName).then((value) {
                            sn.getHomeItemsByDate(DateTime.now(),
                                withLoading: false, state: StateMyLife.Stories);

                            setState(() {});
                          });
                        } else {
                          UserSessionDataModel.storyId = sn.stories2[index].id!;
                          Nav.to(SingleStoryScreen.routeName).then((value) {
                            sn.getHomeItemsByDate(DateTime.now(),
                                withLoading: false, state: StateMyLife.Stories);

                            setState(() {});
                          });
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Gaps.vGap24;
                  },
                  itemCount: sn.stories2.length,
                ),
              ],
            ),
          ),
          Padding(
            padding: padding,
            child: CustomMansourButton(
                titleText: Translation.current.load_more_stories,
                width: 1.sw,
                height: 90.h,
                borderColor: AppColors.primaryColorLight,
                borderRadius: Radius.circular(24.r),
                titleStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColorLight,
                    fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                    fontSize: 40.sp),
                textColor: AppColors.white,
                backgroundColor: AppColors.white,
                onPressed: () {}),
          ),
          _contentWidget(
              text: Translation.current.positivity,
              title: Translation.current.add_positivity_message,
              button: Translation.current.add_positivity_today,
              icon: AppConstants.SVG_DREAM,
              onPress: () {
                sn.goToPositivityScreen();
              },
              child: sn.positives.isNotEmpty
                  ? ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _buildPositivity(
                          title: sn.positives[index].title,
                          image: sn.positives[index].imageUrl,
                          content: sn.positives[index].description,
                          time: DateTimeHelper.getPositivityTitle(
                                  sn.positives[index].date) +
                              ' ,' +
                              Translation.current.at +
                              ' ' +
                              DateTimeHelper.dateTo12Format(
                                  sn.positives[index].date),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Gaps.vGap32;
                      },
                      itemCount: sn.positives.length,
                    )
                  : null),
          SizedBox(
            height: 400.h,
          ),
        ],
      ),
    );
  }

  _storyContent() {
    return Container(
      color: AppColors.mansourLightGreyColor_4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 130.h,
            width: 1.sw,
            color: AppColors.mansourLightGreyColor_4,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 15.h),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.h),
            child: SizedBox(
              width: 1.sw,
              height: 100.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: sn.storySort.length,
                itemBuilder: (context, index) {
                  return CustomMansourButton(
                      padding: EdgeInsets.symmetric(horizontal: 60.w),
                      title: Text(
                        sn.storySort[index],
                        style: TextStyle(
                          color: sn.selectedSortType == sn.storySort[index]
                              ? Colors.white
                              : Colors.grey,
                          fontSize: 35.sp,
                        ),
                      ),
                      borderColor: sn.selectedSortType == sn.storySort[index]
                          ? AppColors.primaryColorLight
                          : AppColors.mansourNotSelectedBorderColor,
                      borderRadius: Radius.circular(25.r),
                      backgroundColor:
                          sn.selectedSortType == sn.storySort[index]
                              ? AppColors.primaryColorLight
                              : AppColors.mansourLightGreyColor_4,
                      onPressed: () {
                        sn.onSelectType(sn.storySort[index]);
                        sn.selectedIndex =
                            sn.storySort.indexOf(sn.storySort[index]);
                        sn.sort(index);
                      });
                },
                separatorBuilder: (context, index) {
                  return Gaps.hGap32;
                },
              ),
            ),
          ),
          getDataOnTap(),
          /*sn.appointments2.length > 0 ?Visibility(
            visible: sn.appointmentVisi,
            child: Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Translation.current.today_appointment,
                          style: TextStyle(
                              fontSize: 45.sp, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            sn.goToAppointmentScreen();
                          },
                          child: Text(
                            Translation.current.view_all,
                            style: TextStyle(
                              color: AppColors.mansourBackArrowColor2,
                              fontWeight: FontWeight.bold,
                              fontSize: 45.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return appointmentItem(
                          check: sn.appointments2[index].isDone!,
                          image: sn.appointments[index].image,
                          end: sn.appointments2[index].toHour!,
                          color: sn.appointments2[index].priority!,
                          start: sn.appointments2[index].fromHour!,
                          persons: sn.appointments[index].persons,
                          title: sn.tasks.length.toString(),
                          index: index,
                          isSelected: false);
                    },
                    separatorBuilder: (context, index) {
                      return Gaps.vGap8;
                    },
                    itemCount: sn.appointments2.length,
                  ),
                ],
              ),
            ),
          ) :_buildNoData(),

          sn.tasks.length > 0 ?
            Visibility(
              visible: sn.toDoVisi,
              child: Padding(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Translation.current.today_todo_list,
                            style: TextStyle(
                                fontSize: 45.sp, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              sn.goToDoScreen();
                            },
                            child: Text(
                              Translation.current.view_all,
                              style: TextStyle(
                                color: AppColors.mansourBackArrowColor2,
                                fontWeight: FontWeight.bold,
                                fontSize: 45.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.vGap64,
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _buildTodoWidget(
                          timeFrom: sn.tasks[index].fromHour!,
                          timeTo: sn.tasks[index].toHour!,
                          title: sn.tasks[index].title!,
                          color: sn.tasks[index].priority!,
                          index: index,
                          checked: sn.tasks[index].isAchieved,
                          isSelected: sn.tasks[index].isSelected,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Gaps.vGap32;
                      },
                      itemCount: sn.tasks.length,
                    ),
                  ],
                ),
              ),
            ): _buildNoData(),
          if (sn.dreams2.isNotEmpty)
            Visibility(
              visible: sn.dreamsVisi,
              child: Padding(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Translation.current.my_dreams,
                            style: TextStyle(
                                fontSize: 45.sp, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              sn.goToDreamScreen();
                            },
                            child: Text(
                              Translation.current.view_all,
                              style: TextStyle(
                                color: AppColors.mansourBackArrowColor2,
                                fontWeight: FontWeight.bold,
                                fontSize: 45.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.vGap64,
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return DreamCardExpanationTile(
                          title: '${sn.dreams2[index].title}',
                          imageUrl: '${sn.dreams2[index].imageUrl}',
                          steps: sn.dreams2[index].steps,
                          achivedStepCount:
                              sn.dreams2[index].achievedStepsCount,
                          totalStepCount: sn.dreams2[index].totalStepsCount,
                          color: AppColors.primaryColorDark,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Gaps.vGap32;
                      },
                      itemCount: sn.dreams2.length,
                    ),
                    Gaps.vGap64,
                    Visibility(
                      visible: sn.storyVisi,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Translation.current.story,
                            style: TextStyle(
                                fontSize: 45.sp, fontWeight: FontWeight.bold),
                          ),
                          Gaps.vGap64,
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return StoryWidget(
                                  image: sn.stories[0].image,
                                  name: sn.stories[0].name,
                                  isAudio: sn.stories[0].isAudio,
                                  icon: AppConstants.SVG_MIC,
                                  item: sn.stories2[index],
                                  isVideo: sn.stories[0].isVideo);
                            },
                            separatorBuilder: (context, index) {
                              return Gaps.vGap24;
                            },
                            itemCount: sn.stories2.length,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: padding,
                      child: CustomMansourButton(
                          titleText: Translation.current.load_more_stories,
                          width: 1.sw,
                          height: 90.h,
                          borderColor: AppColors.primaryColorLight,
                          borderRadius: Radius.circular(24.r),
                          titleStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColorLight,
                              fontSize: 40.sp),
                          textColor: AppColors.white,
                          backgroundColor: AppColors.mansourLightGreyColor_4,
                          onPressed: () {}),
                    ),
                  ],
                ),
              ),
            ),
          if (sn.positives.isNotEmpty)
            Visibility(
              visible: sn.positivityVisi,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Translation.current.today_positivity,
                            style: TextStyle(
                                fontSize: 45.sp, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              sn.goToPositivityScreen();
                            },
                            child: Text(
                              Translation.current.view_all,
                              style: TextStyle(
                                color: AppColors.mansourBackArrowColor2,
                                fontWeight: FontWeight.bold,
                                fontSize: 45.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.vGap64,
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return PositiveWidget(entity: sn.positives[index]);
                      },
                      separatorBuilder: (context, index) {
                        return Gaps.vGap32;
                      },
                      itemCount: sn.positives.length,
                    ),
                  ],
                ),
              ),
            ),*/
          SizedBox(
            height: 100.h,
          )
        ],
      ),
    );
  }

  _contentWidget({
    required String text,
    required String icon,
    required String title,
    required VoidCallback onPress,
    required String button,
    required Widget? child,
  }) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: Text(
              text,
              style: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Gaps.vGap64,
          if (child == null)
            Container(
              width: 1.sw,
              decoration: BoxDecoration(
                borderRadius: border,
                color: AppColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gaps.vGap32,
                  SizedBox(
                    height: 250.h,
                    width: 250.h,
                    child: SvgPicture.asset(icon),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 120.h),
                    child: Text(
                      title,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 45.sp,
                          color: AppColors.mansourNotSelectedBorderColor),
                    ),
                  ),
                  Gaps.vGap64,
                  CustomMansourButton(
                      titleText: button,
                      width: 0.5.sw,
                      height: 90.h,
                      borderRadius: Radius.circular(24.r),
                      titleStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40.sp,
                          fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular'),
                      textColor: AppColors.white,
                      backgroundColor: AppColors.primaryColorLight,
                      onPressed: onPress),
                  Gaps.vGap64,
                ],
              ),
            ),
          if (child != null) child,
        ],
      ),
    );
  }

  bottomWidget() {
    return Positioned(
        bottom: 0,
        child: Container(
          height: 180.h,
          width: 1.sw,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.mansourLightGreyColor_9)),
          child: Center(
            child: Column(
              children: [
                DaysList(
                  height: 100.h,
                  selectedDay: sn.selectedDay,
                  onDayChange: sn.onDayChange,
                  selectedBackgroundColor: AppColors.primaryColorLight,
                ),
                Gaps.vGap12,
                // Text(sn.selectedDay.toString()),
              ],
            ),
          ),
        ));
  }

  /*bottomWidget2() {
    return Positioned(
        bottom: 0,
        child: Container(
          height: 150.h,
          width: 1.sw,
          color: Colors.white,
          child: TableCalendar(
            currentDay: sn.selectDay,
            headerVisible: false,
            daysOfWeekVisible: false,
            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            pageAnimationEnabled: true,
            calendarFormat: CalendarFormat.week,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    date.day.toString(),
                    style: const TextStyle(color: Colors.white),
                  )),
              holidayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    date.day.toString(),
                    style: const TextStyle(color: Colors.white),
                  )),
            ),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                sn.selectDay = selectedDay;
                sn.selectDay = focusedDay; //
                sn.getHomeItemsByDate(sn.selectDay);
                // print(sn.selectedDay.isUtc);
              });
            },
            daysOfWeekHeight: 100.h,
            weekendDays: const [DateTime.friday, DateTime.saturday],
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarStyle: CalendarStyle(
                outsideDaysVisible: true,
                todayDecoration: BoxDecoration(
                    color: AppColors.primaryColorLight,
                    borderRadius: BorderRadius.circular(15.r))),
          ),
        ));
  }*/

  _buildPositivity(
      {required String title,
      required String time,
      required String image,
      required String content}) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.mansourWhiteBackgrounColor_4.withOpacity(0.4),
              offset: const Offset(0, 2),
              spreadRadius: 3,
              blurRadius: 5,
            ),
          ],
          color: Colors.white),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 80.h,
                        width: 80.h,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.mansourLightGreyColor_2),
                        child: Center(
                          child: Image.network(
                            image,
                            fit: BoxFit.contain,
                          ),
                        )),
                  ],
                ),
                Gaps.hGap64,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 50.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Gaps.vGap12,
                    Text(
                      '${time}',
                      style: TextStyle(
                          fontSize: 40.sp,
                          color: AppColors.mansourNotSelectedBorderColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Gaps.vGap24,
            Divider(
              color: AppColors.mansourWhiteBackgrounColor_4,
              thickness: 1,
              height: 30.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        content,
                        style:
                            TextStyle(fontSize: 45.sp, color: Colors.grey[500]),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  getDataOnTap() {
    switch (sn.selectedIndex) {
      case 1:
        {
          return sn.appointments2.length > 0
              ? Visibility(
                  visible: sn.appointmentVisi,
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Translation.current.appointment,
                                style: TextStyle(
                                    fontSize: 45.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  sn.goToAppointmentScreen();
                                },
                                child: Text(
                                  Translation.current.view_all,
                                  style: TextStyle(
                                    color: AppColors.mansourBackArrowColor2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return appointmentItem(
                                check: sn.appointments2[index].isDone!,
                                // image: sn.appointments[index].image,
                                end: sn.appointments2[index].toHour!,
                                color: sn.appointments2[index].priority!,
                                start: sn.appointments2[index].fromHour!,
                                //  persons: sn.appointments[index].persons,
                                title: sn.appointments2[index].title!,
                                index: index,
                                isSelected: sn.appointments2[index].isSelected);
                          },
                          separatorBuilder: (context, index) {
                            return Gaps.vGap8;
                          },
                          itemCount: sn.appointments2.length,
                        ),
                      ],
                    ),
                  ),
                )
              : _buildNoData();
        }
      case 2:
        {
          return sn.tasks.length > 0
              ? Visibility(
                  visible: sn.toDoVisi,
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Translation.current.todo_list,
                                style: TextStyle(
                                    fontSize: 45.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  sn.goToDoScreen();
                                },
                                child: Text(
                                  Translation.current.view_all,
                                  style: TextStyle(
                                    color: AppColors.mansourBackArrowColor2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gaps.vGap64,
                        ListView.separated(
                          shrinkWrap: true,
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildTodoWidget(
                              date: '${sn.tasks[index].date}',
                              title: sn.tasks[index].title!,
                              color: sn.tasks[index].priority!,
                              index: index,
                              checked: sn.tasks[index].isAchieved,
                              isSelected: sn.tasks[index].isSelected,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Gaps.vGap32;
                          },
                          itemCount: sn.tasks.length,
                        ),
                      ],
                    ),
                  ),
                )
              : _buildNoData();
        }
      case 3:
        {
          return sn.dreams2.length > 0
              ? Visibility(
                  visible: sn.dreamsVisi,
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Translation.current.my_dreams,
                                style: TextStyle(
                                    fontSize: 45.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  sn.goToDreamScreen();
                                },
                                child: Text(
                                  Translation.current.view_all,
                                  style: TextStyle(
                                    color: AppColors.mansourBackArrowColor2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gaps.vGap64,
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildDreamExpenationTile(
                              '${sn.dreams2[index].title}',
                              '${sn.dreams2[index].imageUrl}',
                              sn.dreams2[index].steps,
                              sn.dreams2[index].achievedStepsCount,
                              sn.dreams2[index].totalStepsCount,
                              sn.dreamColorList[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Gaps.vGap32;
                          },
                          itemCount: sn.dreams2.length,
                        ),
                        Gaps.vGap64,
                      ],
                    ),
                  ),
                )
              : _buildNoData();
        }
      case 4:
        {
          return sn.positives.length > 0
              ? Visibility(
                  visible: sn.positivityVisi,
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Translation.current.positivity,
                                style: TextStyle(
                                    fontSize: 45.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  sn.goToPositivityScreen();
                                },
                                child: Text(
                                  Translation.current.view_all,
                                  style: TextStyle(
                                    color: AppColors.mansourBackArrowColor2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gaps.vGap64,
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildPositivity(
                              title: sn.positives[index].title,
                              image: sn.positives[index].imageUrl,
                              content: sn.positives[index].description,
                              time: DateTimeHelper.getPositivityTitle(
                                      sn.positives[index].date) +
                                  ' ,' +
                                  Translation.current.at +
                                  ' ' +
                                  DateTimeHelper.dateTo12Format(
                                      sn.positives[index].date),
                            );
                            ;
                          },
                          separatorBuilder: (context, index) {
                            return Gaps.vGap32;
                          },
                          itemCount: sn.positives.length,
                        ),
                        Gaps.vGap64,
                      ],
                    ),
                  ),
                )
              : _buildNoData();
        }
      default:
        {
          if (sn.appointments2.isEmpty &&
              sn.tasks.isEmpty &&
              sn.dreams2.isEmpty &&
              sn.stories.isEmpty &&
              sn.positives.isEmpty) {
            return _buildNoData();
          } else {
            return Column(
              children: [
                Visibility(
                  visible: sn.appointments2.isNotEmpty,
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Translation.current.appointment,
                                style: TextStyle(
                                    fontSize: 45.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  sn.goToAppointmentScreen();
                                },
                                child: Text(
                                  Translation.current.view_all,
                                  style: TextStyle(
                                    color: AppColors.mansourBackArrowColor2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return appointmentItem(
                              check: sn.appointments2[index].isDone!,
                              //  image: sn.appointments[index].image,
                              end: sn.appointments2[index].toHour!,
                              color: sn.appointments2[index].priority!,
                              start: sn.appointments2[index].fromHour!,
                              //persons: sn.appointments[index].persons,
                              title: sn.appointments2[index].title!,
                              index: index,
                              isSelected: sn.appointments2[index].isSelected,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Gaps.vGap8;
                          },
                          itemCount: sn.appointments2.length,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: sn.tasks.isNotEmpty,
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Translation.current.todo_list,
                                style: TextStyle(
                                    fontSize: 45.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  sn.goToDoScreen();
                                },
                                child: Text(
                                  Translation.current.view_all,
                                  style: TextStyle(
                                    color: AppColors.mansourBackArrowColor2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gaps.vGap64,
                        ListView.separated(
                          shrinkWrap: true,
                          reverse: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildTodoWidget(
                              date: '${sn.tasks[index].date}',
                              title: sn.tasks[index].title!,
                              color: sn.tasks[index].priority!,
                              index: index,
                              checked: sn.tasks[index].isAchieved,
                              isSelected: sn.tasks[index].isSelected,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Gaps.vGap32;
                          },
                          itemCount: sn.tasks.length,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: sn.dreams2.isNotEmpty,
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Translation.current.my_dreams,
                                style: TextStyle(
                                    fontSize: 45.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  sn.goToDreamScreen();
                                },
                                child: Text(
                                  Translation.current.view_all,
                                  style: TextStyle(
                                    color: AppColors.mansourBackArrowColor2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gaps.vGap64,
                        ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildDreamExpenationTile(
                              '${sn.dreams2[index].title}',
                              '${sn.dreams2[index].imageUrl}',
                              sn.dreams2[index].steps,
                              sn.dreams2[index].achievedStepsCount,
                              sn.dreams2[index].totalStepsCount,
                              AppColors.primaryColorDark,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Gaps.vGap32;
                          },
                          itemCount: sn.dreams2.length,
                        ),
                        Gaps.vGap64,
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: sn.positivityVisi,
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Translation.current.positivity,
                                style: TextStyle(
                                    fontSize: 45.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  sn.goToPositivityScreen();
                                },
                                child: Text(
                                  Translation.current.view_all,
                                  style: TextStyle(
                                    color: AppColors.mansourBackArrowColor2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gaps.vGap64,
                        ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildPositivity(
                              title: sn.positives[index].title,
                              image: sn.positives[index].imageUrl,
                              content: sn.positives[index].description,
                              time: DateTimeHelper.getPositivityTitle(
                                      sn.positives[index].date) +
                                  ' ,' +
                                  Translation.current.at +
                                  ' ' +
                                  DateTimeHelper.dateTo12Format(
                                      sn.positives[index].date),
                            );
                            ;
                          },
                          separatorBuilder: (context, index) {
                            return Gaps.vGap32;
                          },
                          itemCount: sn.positives.length,
                        ),
                        Gaps.vGap64,
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: sn.storyVisi,
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Translation.current.story,
                          style: TextStyle(
                              fontSize: 45.sp, fontWeight: FontWeight.bold),
                        ),
                        Gaps.vGap64,
                        ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return StoryWidget(
                              image: sn.stories[0].image,
                              name: sn.stories[0].name,
                              isAudio: sn.stories[0].isAudio,
                              icon: AppConstants.SVG_MIC,
                              item: sn.stories2[index],
                              isVideo: sn.stories[0].isVideo,
                              onTap: () {
                                UserSessionDataModel.storyId =
                                    sn.stories2[index].id!;
                                print('aaaaaaa');
                                print(sn.stories2[index].id!);
                                print(sn.stories2[index].stroyType!);
                                if (sn.stories2[index].stroyType == "Video") {
                                  UserSessionDataModel.storyId =
                                      sn.stories2[index].id!;
                                  Nav.to(MyLifeVideoScreen.routeName)
                                      .then((value) {
                                    sn.getHomeItemsByDate(DateTime.now(),
                                        withLoading: false,
                                        state: StateMyLife.Stories);

                                    setState(() {});
                                  });
                                } else if (sn.stories2[index].stroyType ==
                                    "Voice") {
                                  UserSessionDataModel.storyId =
                                      sn.stories2[index].id!;
                                  Nav.to(MylifeAudioScreen.routeName)
                                      .then((value) {
                                    sn.getHomeItemsByDate(DateTime.now(),
                                        withLoading: false,
                                        state: StateMyLife.Stories);

                                    setState(() {});
                                  });
                                } else {
                                  UserSessionDataModel.storyId =
                                      sn.stories2[index].id!;
                                  Nav.to(SingleStoryScreen.routeName)
                                      .then((value) {
                                    sn.getHomeItemsByDate(DateTime.now(),
                                        withLoading: false,
                                        state: StateMyLife.Stories);

                                    setState(() {});
                                  });
                                }
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Gaps.vGap24;
                          },
                          itemCount: sn.stories2.length,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: sn.storyVisi,
                  child: Padding(
                    padding: padding,
                    child: CustomMansourButton(
                        titleText: Translation.current.load_more_stories,
                        width: 1.sw,
                        height: 90.h,
                        borderColor: AppColors.primaryColorLight,
                        borderRadius: Radius.circular(24.r),
                        titleStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColorLight,
                            fontSize: 40.sp),
                        textColor: AppColors.white,
                        backgroundColor: AppColors.mansourLightGreyColor_4,
                        onPressed: () {}),
                  ),
                ),
                Gaps.vGap128
              ],
            );
          }
        }
    }
  }

  _buildTodoWidget(
      {required bool checked,
      required String title,
      required String date,
      required int index,
      required bool isSelected,
      required int color}) {
    return InkWell(
      onTap: () {
        sn.onCardTapped(type: 1, index: index);
      },
      child: Container(
        width: 1.sw,
        height: 200.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r), color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                VerticalDivider(
                  color: sn.getColorPriority(color),
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Gaps.hGap32,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        decoration: checked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: checked
                            ? AppColors.text_gray
                            : AppColors.black_text,
                        fontWeight: FontWeight.bold,
                        fontSize: 45.sp,
                      ),
                    ),
                    Gaps.vGap12,
                    Text(
                      '${DateTimeHelper.stringToParsedString(date)}',
                      style: TextStyle(
                        color: AppColors.mansourNotSelectedBorderColor,
                        fontSize: 40.sp,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60.h,
                    width: 60.h,
                    child: checked
                        ? SvgPicture.asset(
                            checked
                                ? AppConstants.SVG_CHECKMARK_CIRCLE_FILL
                                : AppConstants.SVG_RADIO_BUTTON_OFF,
                            color: checked
                                ? AppColors.primaryColorLight
                                : AppColors.mansourWhiteBackgrounColor_6,
                          )
                        : SvgPicture.asset(
                            isSelected
                                ? AppConstants.SVG_CHECKMARK_CIRCLE_FILL
                                : AppConstants.SVG_RADIO_BUTTON_OFF,
                            color: isSelected
                                ? AppColors.primaryColorLight
                                : AppColors.mansourWhiteBackgrounColor_6,
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildNoData() {
    return Visibility(
      visible: sn.noDataVisi,
      child: Container(
        height: 700.h,
        child: Center(
          child: Text(
            Translation.current.no_data,
            style: TextStyle(
                color: AppColors.mansourDarkOrange2,
                fontSize: 70.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildWheelItem({
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    return AppConfig().appLanguage == 'ar'
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 120.h,
                width: 120.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: LayoutBuilder(builder: (context, cons) {
                  return InkWell(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: onTap,
                    child: Center(
                      child: SizedBox(
                        height: 80.h,
                        width: 80.h,
                        child: SvgPicture.asset(
                          icon,
                          color: AppColors.primaryColorLight,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              Gaps.hGap64,
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold),
              ),
              Gaps.hGap64,
              Container(
                height: 120.h,
                width: 120.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: LayoutBuilder(builder: (context, cons) {
                  return InkWell(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: onTap,
                    child: Center(
                      child: SizedBox(
                        height: 80.h,
                        width: 80.h,
                        child: SvgPicture.asset(
                          icon,
                          color: AppColors.primaryColorLight,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
  }

  _floatContainerItem(
      {required String icon,
      required String name,
      required int number,
      required VoidCallback onPress}) {
    return InkWell(
      onTap: onPress,
      child: Container(
        child: Row(
          children: [
            SizedBox(height: 80.h, width: 80.h, child: SvgPicture.asset(icon)),
            Gaps.hGap32,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  number.toString(),
                  style:
                      TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 35.sp,
                      color: AppColors.mansourNotSelectedBorderColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget appointmentItem({
    required bool check,
    required String start,
    required String end,
    String? date,
    required String title,
    required int color,
    required bool isSelected,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        print('asassas');
        sn.onCardTapped(type: 0, index: index);
      },
      child: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 65.h,
                      width: 65.h,
                      child: check
                          ? SvgPicture.asset(
                              check
                                  ? AppConstants.SVG_CHECKMARK_CIRCLE_FILL
                                  : AppConstants.SVG_RADIO_BUTTON_OFF,
                              color: check
                                  ? AppColors.primaryColorLight
                                  : AppColors.mansourWhiteBackgrounColor_6,
                            )
                          : SvgPicture.asset(
                              isSelected
                                  ? AppConstants.SVG_CHECKMARK_CIRCLE_FILL
                                  : AppConstants.SVG_RADIO_BUTTON_OFF,
                              color: isSelected
                                  ? AppColors.primaryColorLight
                                  : AppColors.mansourWhiteBackgrounColor_6,
                            ),
                    )
                  ],
                ),
                Gaps.hGap32,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      start,
                      style: TextStyle(
                          fontSize: 40.sp,
                          color: AppColors.mansourWhiteBackgrounColor_6),
                    ),
                    Gaps.vGap8,
                    Text(
                      end,
                      style: TextStyle(
                          fontSize: 40.sp,
                          color: AppColors.mansourWhiteBackgrounColor_6),
                    ),
                    Gaps.vGap8,
                    if (date != null)
                      Text(
                        DateTimeHelper.stringToParsedString(date),
                        style: TextStyle(
                            fontSize: 40.sp,
                            color: AppColors.mansourWhiteBackgrounColor_6),
                      )
                  ],
                ),
              ],
            ),
            Gaps.hGap64,
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColorLight
                          : Colors.transparent),
                  color: sn.getColorPriority(color),
                ),
                child: Padding(
                  padding: padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gaps.vGap12,
                            Text(
                              title,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 45.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white),
                            ),
                            Gaps.vGap12,
                            // Text(
                            //   persons,
                            //   style: TextStyle(
                            //       fontSize: 35.sp, color: AppColors.white),
                            // ),
                          ],
                        ),
                      ),
                      // if (image != "")
                      //   Flexible(
                      //     child: ClipOval(
                      //       child: Container(
                      //         height: 100.h,
                      //         width: 100.h,
                      //         decoration: const BoxDecoration(
                      //           shape: BoxShape.circle,
                      //         ),
                      //         child: Image.asset(
                      //           image,
                      //           fit: BoxFit.cover,
                      //         ),
                      //       ),
                      //     ),
                      //   )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildDreamExpenationTile(
    String title,
    String imageUrl,
    List<StepEntity> steps,
    int achivedStepCount,
    int totalStepCount,
    Color color,
  ) {
    var pecent = (100 * achivedStepCount) / totalStepCount;
    print(pecent);
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.mansourNotSelectedBorderColor.withOpacity(0.1),
            blurRadius: 5,
          ),
        ],
      ),
      child: ExpansionTile(
        title: Container(
          width: 1.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.mansourNotSelectedBorderColor.withOpacity(0.1),
                blurRadius: 5,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 20.h),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Image.asset(
                            imageUrl,
                            color: AppColors.primaryColorLight,
                            height: 90.h,
                            width: 90.h,
                          ),
                          color: AppColors.primaryColorLight,
                          onPressed: () {
                            Nav.to(DreamScreen.routeName);
                          },
                        ),
                      ],
                    ),
                    Gaps.hGap32,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  color: AppColors.black_text,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 45.sp,
                                ),
                              ),
                            ],
                          ),
                          Gaps.vGap12,
                          Text(
                            ('$achivedStepCount ' +
                                Translation.of(context).of_of +
                                ' $totalStepCount ' +
                                Translation.of(context).step_achieved),
                            style: TextStyle(
                              color: AppColors.mansourNotSelectedBorderColor,
                              fontSize: 40.sp,
                            ),
                          ),
                          Gaps.vGap32,
                          LinearPercentIndicator(
                            percent: pecent / 100,
                            backgroundColor: AppColors.mansourLightGreyColor,
                            animation: true,
                            lineHeight: 10.h,
                            padding: EdgeInsets.zero,
                            progressColor: color,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        children: [
          Gaps.vGap32,
          Text(
            Translation.of(context).STEP_TO_REACH_GOAL,
            style: TextStyle(
              color: AppColors.black_text,
              fontWeight: FontWeight.bold,
              fontSize: 45.sp,
            ),
          ),
          Gaps.vGap32,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: steps.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildStep(steps[index].status == 0 ? false : true,
                    '${steps[index].title}', () {
                  if (steps[index].status == 0)
                    sn.checkStep(steps[index].id);
                  else
                    sn.unCheckStep(steps[index].id);
                });
              },
            ),
          )
        ],
      ),
    );
  }

  _buildStep(bool isDone, String stepText, Function() onTapStep) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 250.w,
            ),
            child: Text(
              "$stepText",
              style: TextStyle(
                decoration:
                    isDone ? TextDecoration.lineThrough : TextDecoration.none,
                color: AppColors.text_gray,
                fontSize: 45.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 50.w,
            ),
            child: GestureDetector(
              onTap: onTapStep,
              child: SizedBox(
                height: 50.h,
                width: 50.h,
                child: SvgPicture.asset(
                  isDone
                      ? AppConstants.SVG_CHECKMARK_CIRCLE_FILL
                      : AppConstants.SVG_RADIO_BUTTON_OFF,
                  color: 2 == 2
                      ? AppColors.primaryColorLight
                      : AppColors.accentColorLight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
