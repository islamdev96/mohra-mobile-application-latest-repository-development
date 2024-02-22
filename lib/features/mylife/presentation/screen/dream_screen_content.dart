import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/mylife/domain/entity/DreamListEntity.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import 'package:starter_application/features/mylife/presentation/widget/dreams/dream_card_expanition_tile.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/dream_screen_notifier.dart';

class DreamScreenContent extends StatefulWidget {
  @override
  State<DreamScreenContent> createState() => _DreamScreenContentState();
}

class _DreamScreenContentState extends State<DreamScreenContent> {
  late DreamScreenNotifier sn;
  bool isExpanded = false;

  EdgeInsets padding = EdgeInsets.symmetric(horizontal: 60.w, vertical: 20.h);

  EdgeInsets itemPadding = EdgeInsets.symmetric(vertical: 60.h);

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<DreamScreenNotifier>(context);
    sn.context = context;
    return Container(
      width: 1.sw,
      height: 1.sh,
      child: BlocConsumer<MylifeCubit, MylifeState>(
        bloc: sn.mylifeCubit,
        listener: (context, state) {
          if (state is DreamListLoaded) {
            sn.onDreamListLoaded(state.dreamListEntity);
          }
          if (state is DreamCreated) {
            sn.onDreamCreatedSuccessfully();

          }
          if(state is CheckDreamSuccess){
            sn.getDreamList();
          }
          if(state is DeleteDreamSuccess){
            sn.getDreamList();
          }
        },
        builder: (context, state) {
          return state.maybeMap(
            orElse: ()=> const ScreenNotImplementedError(),
            storyLoaded: (s) => const ScreenNotImplementedError(),
            taskPerDayLoadedSuccess: (s) => const ScreenNotImplementedError(),
            appointmentLoadedPerDayState:(s) => const ScreenNotImplementedError(),
            mylifeInitState: (s) => WaitingWidget(),
            mylifeLoadingState: (s) => WaitingWidget(),
            imageUploaded: (s) => const ScreenNotImplementedError(),
            qouteLoadedSuccess: (s) => const ScreenNotImplementedError(),
            storiesLoadedState: (s) => const ScreenNotImplementedError(),
            taskLoadedSuccess: (s) => const ScreenNotImplementedError(),
            appointmentLoadedState: (s) => const ScreenNotImplementedError(),
            clientLoadedState: (s) => const ScreenNotImplementedError(),
            createAppointmentSuccess: (s) => const ScreenNotImplementedError(),
            positivesListLoaded: (s) => const ScreenNotImplementedError(),
            deleteItemSuccess: (s) => const ScreenNotImplementedError(),
            dreamCreated: (s) => Stack(
              children: [
                SingleChildScrollView(
                    child: Padding(
                  padding: padding,
                  child: Column(
                    children: [_buildHeader(), _buildContent()],
                  ),
                )),
                PositionedDirectional(
                    bottom: 50.h,
                    end: AppConfig().isLTR ? 40.w : null,
                    start: AppConfig().isLTR ? null : 40.w ,
                    child: Container(
                      width: 120.h,
                      height: 120.h,
                      decoration: const BoxDecoration(
                          color: AppColors.primaryColorLight,
                          shape: BoxShape.circle),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            sn.onAddTap();
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            createDream: (s) => Stack(
              children: [
                SingleChildScrollView(
                    child: Padding(
                  padding: padding,
                  child: Column(
                    children: [_buildHeader(), _buildContent()],
                  ),
                )),
                PositionedDirectional(
                    bottom: 50.h,
                    end: AppConfig().isLTR ? 40.w : null,
                    start: AppConfig().isLTR ? null : 40.w ,
                    child: Container(
                      width: 120.h,
                      height: 120.h,
                      decoration: const BoxDecoration(
                          color: AppColors.primaryColorLight,
                          shape: BoxShape.circle),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            sn.onAddTap();
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            mylifeErrorState: (s) => ErrorScreenWidget(
              error: s.error,
              callback: s.callback,
            ),
            createTaskSuccess: (s) => const ScreenNotImplementedError(),
            positiveCreated: (s) => const ScreenNotImplementedError(),
            checkDreamSuccess: (s)=>Stack(
              children: [
                SingleChildScrollView(
                    child: Padding(
                      padding: padding,
                      child: Column(
                        children: [_buildHeader(), _buildContent()],
                      ),
                    )),
                PositionedDirectional(
                    bottom: 50.h,
                    end: AppConfig().isLTR ? 40.w : null,
                    start: AppConfig().isLTR ? null : 40.w ,
                    child: Container(
                      width: 120.h,
                      height: 120.h,
                      decoration: const BoxDecoration(
                          color: AppColors.primaryColorLight,
                          shape: BoxShape.circle),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            sn.onAddTap();
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            deleteDreamSuccess: (s)=>Stack(
              children: [
                SingleChildScrollView(
                    child: Padding(
                      padding: padding,
                      child: Column(
                        children: [_buildHeader(), _buildContent()],
                      ),
                    )),
                PositionedDirectional(
                    bottom: 50.h,
                    end: AppConfig().isLTR ? 40.w : null,
                    start: AppConfig().isLTR ? null : 40.w ,
                    child: Container(
                      width: 120.h,
                      height: 120.h,
                      decoration: const BoxDecoration(
                          color: AppColors.primaryColorLight,
                          shape: BoxShape.circle),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            sn.onAddTap();
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            checkTaskSuccess: (CheckTaskSuccess value) =>
            const ScreenNotImplementedError() ,
            dreamListLoaded: (s) => Stack(
              children: [
                SingleChildScrollView(
                    child: Padding(
                  padding: padding,
                  child: Column(
                    children: [_buildHeader(), _buildContent()],
                  ),
                )),
                PositionedDirectional(
                    bottom: 50.h,
                    end: AppConfig().isLTR ? 40.w : null,
                    start: AppConfig().isLTR ? null : 40.w ,
                    child: Container(
                      width: 120.h,
                      height: 120.h,
                      decoration: const BoxDecoration(
                          color: AppColors.primaryColorLight,
                          shape: BoxShape.circle),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            sn.onAddTap();
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }

  _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 300.h,
            width: 200.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              gradient: const LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: AppColors.healthOrangeGradiant,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${sn.totalInProgressDreams}/${sn.dreamListEntity.totalCount}",
                        style: TextStyle(
                            fontSize: 65.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Gaps.vGap24,
                  Text(
                    Translation.current.dream_in_progress,
                    style: TextStyle(fontSize: 45.sp, color: Colors.white),
                  ),
                  Gaps.vGap64,
                ],
              ),
            ),
          ),
        ),
        Gaps.hGap64,
        Expanded(
          child: Container(
            height: 300.h,
            width: 200.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              gradient: const LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: AppColors.myLifeGradiant3,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${sn.totalAchievedDreams}/${sn.dreamListEntity.totalCount}",
                        style: TextStyle(
                            fontSize: 65.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Gaps.vGap24,
                  Text(
                    Translation.of(context).dreams_achieved,
                    style: TextStyle(fontSize: 45.sp, color: Colors.white),
                  ),
                  Gaps.vGap64,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildContent() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 50.h),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sn.dreamListEntity.items.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key('${sn.dreamListEntity.items[index].id}'),
          background:Container(
              padding: EdgeInsets.only(right: 20.0),
              color: Colors.red,
              child:  Align(
                alignment: Alignment.center,
                child: new Text('Delete',
                    style:  TextStyle(color: Colors.white , fontSize: 60.sp)),
              )),
          direction: DismissDirection.startToEnd,
          confirmDismiss: (s) async{
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Confirm"),
                  content: const Text("Are you sure you want to delete this Dream?"),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          sn.deleteDream(sn.dreamListEntity.items[index].id);
                          Navigator.of(context).pop(true);
                        },
                        child: const Text("DELETE")
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("CANCEL"),
                    ),
                  ],
                );
              },
            );
          },
          onDismissed: (s){
            print('aaaa');
          },
          child: _buildDreamExpenationTile(
            '${sn.dreamListEntity.items[index].title}',
            '${sn.dreamListEntity.items[index].imageUrl}',
            sn.dreamListEntity.items[index].steps,
            sn.dreamListEntity.items[index].achievedStepsCount,
            sn.dreamListEntity.items[index].totalStepsCount,
            sn.dreamColorList[index],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Gaps.vGap64;
      },
    );
  }

  _buildDreamExpenationTile(String title, String imageUrl , List<StepEntity> steps, int achivedStepCount, int totalStepCount , Color color,){
    var  pecent = (100 * achivedStepCount) / totalStepCount;
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
                            color: color,
                            height: 90.h,
                            width: 90.h,
                          ),
                          color: color,
                          onPressed: () {},
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
                            ('$achivedStepCount ' + Translation.of(context).of_of + ' $totalStepCount ' + Translation.of(context).step_achieved),
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
                return _buildStep(
                  steps[index].status == 0 ? false : true,
                  '${steps[index].title}',
                    (){
                    if(steps[index].status == 0)
                      sn.checkStep(steps[index].id);
                    else
                      sn.unCheckStep(steps[index].id);
                }
                );
              },
            ),
          )
        ],
      ),
    );
  }

  _buildStep(bool isDone , String stepText , Function() onTapStep){
    return  Padding(
      padding: const EdgeInsets.symmetric( vertical: 10),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:  EdgeInsets.only(
              left: 250.w,
            ),
            child: Text(
              "$stepText",
              style: TextStyle(
                decoration: isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: AppColors.text_gray,
                fontSize: 45.sp,
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(
              right: 50.w,
            ),
            child: GestureDetector(
              onTap:onTapStep,
              child: SizedBox(
                height: 50.h,
                width: 50.h,
                child: SvgPicture.asset(
                  isDone
                      ? AppConstants
                      .SVG_CHECKMARK_CIRCLE_FILL
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
