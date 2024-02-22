import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/domain/entity/session_entity.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/state_m/provider/health_main_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'exrecise/health_list_view.dart';

void showExerciseAddBottomSheet({
  required BuildContext context,
  required String title,
  required String searchHint,
  required List<HealthItem> recommendedItems,
  required Function(int index) onRecommendedItemTap,
  required List<String> actionsNames,
  required List<String> actionsIcons,
  final VoidCallback? onSelectTap,
  final VoidCallback? onRefreshTap,
  required List<VoidCallback> actionsCallbacks,
  required HealthMainScreenNotifier sn,
}) {
  assert(
      actionsNames.length == actionsIcons.length &&
          actionsIcons.length == actionsCallbacks.length,
      "actionsNames.length == actionsIcons.length && actionsIcons.length == actionsCallbacks.length");
  //Todo create modal bottom sheet
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return BottomSheet(
        builder: (BuildContext context) {
          return AddBreakfastBottomSheet(
            title: title,
            sn: sn,
            searchHint: searchHint,
            recommendedItems: recommendedItems,
            onRecommendedItemTap: onRecommendedItemTap,
            actionsIcons: actionsIcons,
            actionsNames: actionsNames,
            actionsCallbacks: actionsCallbacks,
            onRefreshTap: onRefreshTap,
            onSelectTap: onSelectTap,
          );
        },
        onClosing: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              40.r,
            ),
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: 1.sh,
        ),
      );
    },
    isScrollControlled: true,
    isDismissible: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          40.r,
        ),
      ),
    ),
    constraints: BoxConstraints(
      maxHeight: 1.sh,
    ),
  );
}

class AddBreakfastBottomSheet extends StatefulWidget {
  final String title;
  final String searchHint;
  final List<HealthItem> recommendedItems;
  final Function(int index) onRecommendedItemTap;
  final List<String> actionsNames;
  final List<String> actionsIcons;
  final List<VoidCallback> actionsCallbacks;
  final VoidCallback? onSelectTap;
  final VoidCallback? onRefreshTap;
  final HealthMainScreenNotifier sn;

  const AddBreakfastBottomSheet({
    Key? key,
    required this.title,
    required this.searchHint,
    required this.recommendedItems,
    required this.onRecommendedItemTap,
    required this.actionsNames,
    required this.actionsIcons,
    required this.actionsCallbacks,
    required this.onRefreshTap,
    required this.onSelectTap,
    required this.sn,
  }) : super(key: key);

  @override
  State<AddBreakfastBottomSheet> createState() =>
      _AddBreakfastBottomSheetState();
}

class _AddBreakfastBottomSheetState extends State<AddBreakfastBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7.sh,
      padding: EdgeInsets.only(
        left: 70.h,
        right: 70.h,
        top: 70.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            40.r,
          ),
        ),
      ),
      child: Column(
        children: [
          /// Title and  dismiss button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 50.sp,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SizedBox(
                  height: 80.h,
                  width: 80.h,
                  child: SvgPicture.asset(
                    AppConstants.SVG_CLOSE,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 50.h,
                bottom: 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Todo replace TextField with button
                  /// Search textfield
                  /*   SearchTextField(
                    // textKey: GlobalKey(),
                    // controller: TextEditingController(),
                    focusNode: FocusNode(),
                    backgroundColor: AppColors.mansourLightGreyColor_4,
                    iconColor: AppColors.mansourLightGreyColor_8,
                    hint: searchHint,
                  ),
                  Gaps.vGap32,*/

                  /// Recomendations
                  _buildCustomCard(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Translation.current.recommendations,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gaps.vGap32,
                        BlocConsumer<HealthCubit, HealthState>(
                          bloc: widget.sn.healthCubit,
                          listener: (context, state) {
                            if (state is RecommendedSessionLoaded) {
                              widget.sn.onRecommendedSessionLoaded(
                                  state.recommendedSessionListEntity);
                            }
                            if (state is DailySessionCreated) {
                              widget.sn.onDailySessionCreated();
                            }
                          },
                          builder: (context, state) {
                            return state.maybeMap(
                              orElse: ()=>
                              const ScreenNotImplementedError(),
                              healthResultsLoaded: (s) =>
                              const ScreenNotImplementedError(),
                              checkHealthProfileDone: (s) =>
                                  const ScreenNotImplementedError(),
                              healthDashboardLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              updateDailyWater: (s) =>
                                  const ScreenNotImplementedError(),
                              updateGoal: (s) =>
                                  const ScreenNotImplementedError(),
                              dailyWaterUpdated: (s) =>
                                  const ScreenNotImplementedError(),
                              goalUpdated: (s) =>
                                  const ScreenNotImplementedError(),
                              favoriteSessionsLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              dailySessionCreated: (s) =>
                                  _buildRecommendationCard(
                                      widget.sn.oneSessionEntity),
                              dailySessionsLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              favoriteDishesLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              favoriteRecipesLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              profileUpdated: (s) =>
                                  const ScreenNotImplementedError(),
                              updateProfile: (s) =>
                                  const ScreenNotImplementedError(),
                              createProfile: (s) =>
                                  const ScreenNotImplementedError(),
                              answerQuestion: (s) =>
                                  const ScreenNotImplementedError(),
                              questionAnswered: (s) =>
                                  const ScreenNotImplementedError(),
                              profileCreated: (s) =>
                                  const ScreenNotImplementedError(),
                              questionLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              recipeListLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              dishListLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              healthInitState: (s) => WaitingWidget(),
                              healthLoadingState: (s) => WaitingWidget(),
                              createDailyDish: (s) => TextWaitingWidget(
                                Translation.current.add_to_daily_dishes,
                              ),
                              uploadImage: (s) =>
                                  const ScreenNotImplementedError(),
                              dailyDishCreated: (s) =>
                                  const ScreenNotImplementedError(),
                              healthErrorState: (s) => ErrorScreenWidget(
                                error: s.error,
                                callback: s.callback,
                              ),
                              foodCategoriesLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              dailyDishListLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              dishLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              recipeLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              sessionListLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              recommendedFoodLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              recommendedSessionLoaded: (s) =>
                                  _buildRecommendationCard(
                                      widget.sn.oneSessionEntity),
                            );
                          },
                        ),
                      ],
                    ),
                    icon: AppConstants.SVG_CLIPBOARD_CHECK,
                  ),
                  Gaps.vGap64,
                  for (int i = 0; i < widget.actionsNames.length; i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCustomCard(
                          titleText: widget.actionsNames[i],
                          icon: widget.actionsIcons[i],
                          onTap: widget.actionsCallbacks[i],
                        ),
                        if (i != widget.actionsNames.length - 1) Gaps.vGap64,
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildRecommendationCard(OneSessionEntity oneSessionEntity) {
    return Column(
      children: [
        CustomListTile(
          //onTap: () => onRecommendedItemTap(index),
          backgroundColor: AppColors.mansourWhiteBackgrounColor_5,
          borderRadius: BorderRadius.circular(
            30.r,
          ),
          padding: const EdgeInsets.all(
            15,
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(
              20.r,
            ),
            child: Container(
              height: 150.h,
              width: 150.h,
              color: Colors.white,
              child: CachedNetworkImage(
                imageUrl: '${oneSessionEntity.imageUrl}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: 20.h,
              start: 35.w,
            ),
            child: Text(
              '${oneSessionEntity.title}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 37.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsetsDirectional.only(
              start: 35.w,
            ),
            child: Text(
              '${oneSessionEntity.amountOfCalories} Kcal | ${oneSessionEntity.timeInMinutes} min',
              style: TextStyle(
                color: AppColors.accentColorLight,
                fontSize: 35.sp,
              ),
            ),
          ),
        ),
        Gaps.vGap32,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            /*  _buildCustomCard(
              titleText: "decline",
              icon: AppConstants.SVG_CLOSE,
              iconColor: Colors.black,
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 35.sp,
              ),
            ),*/
            _buildCustomCard(
                titleText: Translation.current.refresh,
                icon: AppConstants.SVG_HEART_SYNC,
                iconColor: Colors.black,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 35.sp,
                ),
                onTap: () {
                  widget.onRefreshTap!();
                  setState(() {});
                }),
            _buildCustomCard(
                titleText: Translation.current.select,
                icon: AppConstants.SVG_CHECK_MARK,
                iconColor: Colors.black,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 35.sp,
                ),
                onTap: widget.onSelectTap),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomCard({
    required String icon,
    String? titleText,
    Widget? title,
    Color? iconColor,
    double? iconSize,
    TextStyle? textStyle,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: iconSize ?? 70.h,
              width: iconSize ?? 70.h,
              child: SvgPicture.asset(icon,
                  color: iconColor ?? AppColors.mansourLightGreenColor),
            ),
            SizedBox(
              width: 30.w,
            ),
            title == null
                ? Text(
                    titleText ?? "",
                    style: textStyle ??
                        TextStyle(
                          color: Colors.black,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                : Expanded(child: title),
          ],
        ),
      ),
    );
  }
}
