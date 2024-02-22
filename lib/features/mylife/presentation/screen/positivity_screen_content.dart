import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/widgets/empty_error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/mylife/data/model/request/delet_item_request.dart';
import 'package:starter_application/features/mylife/data/model/request/delete_dream_params.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/positivity_screen_notifier.dart';

class PositivityScreenContent extends StatefulWidget {
  @override
  State<PositivityScreenContent> createState() =>
      _PositivityScreenContentState();
}

class _PositivityScreenContentState extends State<PositivityScreenContent> {
  late PositivityScreenNotifier sn;
  EdgeInsets padding = EdgeInsets.symmetric(horizontal: 60.w, vertical: 20.h);
  EdgeInsets itemPadding = EdgeInsets.symmetric(vertical: 60.h);

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<PositivityScreenNotifier>(context);
    sn.context = context;
    return BlocConsumer<MylifeCubit, MylifeState>(
      bloc: sn.myLifeCubit,
      builder: (context, state) {
        return state is MylifeLoadingState
            ? WaitingWidget()
            : Container(
                width: 1.sw,
                height: 1.sh,
                child: Stack(
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
                        start: AppConfig().isLTR ? null : 40.w,
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
      listener: (context, state) {
        if (state is PositivesListLoaded) {
          sn.positivesLoaded(state.dreamListEntity);
        }
        if (state is PositiveCreated) {
          sn.getPositives(isDay: true);
        }
        if (state is ImageUploaded) {
          sn.createPositive(state.images.urls.first);
        }
      },
    );
  }

  _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: InkWell(
            onTap: (){
              sn.getPositives(isDay: true);
            },
            child: Container(
              height: 350.h,
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
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sn.positives.todayHabitsCount.toString(),
                          style: TextStyle(
                              fontSize: 65.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                            height: 160.h,
                            width: 160.h,
                            child: SvgPicture.asset(
                              AppConstants.SVG_POSITIVITY_MY_LIFE,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    Gaps.vGap24,
                    Text(
                      Translation.of(context).positivity_in_this_day,
                      style: TextStyle(fontSize: 45.sp, color: Colors.white),
                    ),
                    Gaps.vGap64,
                  ],
                ),
              ),
            ),
          ),
        ),
        Gaps.hGap64,
        Expanded(
          child: InkWell(
            onTap: (){
              sn.getPositives();
            },
            child: Container(
              height: 350.h,
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
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sn.positives.totalHabitsCount.toString(),
                          style: TextStyle(
                              fontSize: 65.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                            height: 160.h,
                            width: 160.h,
                            child: SvgPicture.asset(
                              AppConstants.SVG_POSITIVITY_MY_LIFE,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    Gaps.vGap24,
                    Text(
                      Translation.of(context).total_positive_thing,
                      style: TextStyle(fontSize: 45.sp, color: Colors.white),
                    ),
                    Gaps.vGap64,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildEmptyWidget() {
    return Column(
      children: [
        SizedBox(
          height: 0.2.sh,
        ),
        SizedBox(
          height: 0.2.sh,
          child: Center(
            child: EmptyErrorScreenWidget(
              message: Translation.current.no_data,
              textColor: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
  _buildContent() {
    return sn.positives.items.length > 0  ?ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sn.positives.items.length,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
                CustomSlidableAction(
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  onPressed: (BuildContext context) {
                    sn.deletePositive(DeleteItemRequest(id: sn.positives.items[index].id, type:0));
                  },
                  child: Row(
                    children: [
                      Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                              child: Icon(
                                Icons.delete,
                                color: AppColors.primaryColorLight,
                                size: 35.h,
                              ))),
                      Gaps.hGap10,
                      Text(
                        Translation.current.delete,
                        style: TextStyle(fontSize: 34.sp),
                      )
                    ],
                  ),
                ),
            ],
          ),
          child: Padding(
              padding: itemPadding,
              child: _buildPositivity(
                  title: sn.positives.items[index].title,
                  image: sn.positives.items[index].imageUrl,
                  time: DateTimeHelper.getPositivityTitle(
                          sn.positives.items[index].date) +
                      ' ,' +
                      Translation.current.at +
                      ' ' +
                      DateTimeHelper.dateTo12Format(
                          sn.positives.items[index].date),
                  content: sn.positives.items[index].description)),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Gaps.vGap8;
      },
    ) : _buildEmptyWidget();
  }

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
                          child: Container(
                            height: 80.h,
                            width: 80.h,
                            child: Center(
                              child: image != null
                                  ? ClipOval(
                                      child: Container(
                                        height: 80.h,
                                        width: 80.h,
                                        decoration: const BoxDecoration(
                                          color: AppColors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: '$image',
                                          fit: BoxFit.fill,
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            height: 80.h,
                                            width: 80.h,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  width: .5,
                                                  color: Colors.black,
                                                )),
                                            child: Icon(
                                              Icons.error,
                                              size: 80.h * .5,
                                              color: Colors.black,
                                            ),
                                          ),
                                          placeholder: (context, _) => Center(
                                            child: CircularProgressIndicator.adaptive(),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 80.h,
                                      width: 80.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: .5,
                                            color: Colors.black,
                                          )),
                                      child: Icon(
                                        Icons.error,
                                        size: 80.h * .5,
                                        color: Colors.black,
                                      ),
                                    ),
                            ),
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
                      time,
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
}
