import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/features/challenge/presentation/widget/custom_list_pile.dart';
import 'package:starter_application/features/messages/presentation/screen/single_message_screen.dart';
import '../../../../main.dart';
import '../screen/../state_m/provider/poll_screen_notifier.dart';

class PollScreenContent extends StatefulWidget {
  @override
  State<PollScreenContent> createState() => _PollScreenContentState();
}

class _PollScreenContentState extends State<PollScreenContent> {
  late PollScreenNotifier sn;
  double HeaderHeight = 0.15.sh;
  double ContentHeight = 0.13.sh;
  final double radius = 120.r;

  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      35.r,
    ),
    borderSide: const BorderSide(
      color: AppColors.mansourLightGreyColor_8,
    ),
  );

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<PollScreenNotifier>(context);
    sn.context = context;

    return Stack(
      children: [
        _buildHeader(),
        _buildContent(),
        PositionedDirectional(
          bottom: 0.h,
          child: Container(
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.r),
                topRight: Radius.circular(50.r),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.mansourNotSelectedBorderColor
                      .withOpacity(0.3),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SlidingAnimated(
                    initialOffset: 5,
                    intervalStart: 0.5,
                    intervalEnd: 0.6,
                    direction: Axis.vertical,
                    child: CustomMansourButton(
                      borderRadius: Radius.circular(20.r),
                      height: 120.h,
                      backgroundColor: AppColors.primaryColorLight,
                      titleText: "Save & Create Poll",
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      titleStyle:
                      TextStyle(fontSize: 40.sp, color: AppColors.white),
                      onPressed: () {
                        Nav.to(SingleMessageScreen.routeName);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 0,
      child: Container(
        width: 1.sw,
        height: HeaderHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(35.r),
            bottomLeft: Radius.circular(35.r),
          ),
          gradient: const LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: AppColors.MessageOrangeGradiant,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Nav.pop(),
                    icon: Icon(
                      AppConstants.getIconBack(),
                      color: AppColors.white,
                      size: 75.sp,
                    ),
                  ),
                  Text(
                    "Create Poll",
                    style: TextStyle(
                        fontSize: 50.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Positioned.fill(
        top: ContentHeight - 40.h,
        left: 0.0,
        right: 0.0,
        child: Container(
          width: 1.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.r),
              topRight: Radius.circular(50.r),
            ),
            color: AppColors.mansourLightGreyColor_4,
            boxShadow: [
              BoxShadow(
                color: AppColors.mansourNotSelectedBorderColor.withOpacity(0.3),
                blurRadius: 5,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Poll Type",
                    style: TextStyle(
                        fontSize: 40.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Gaps.vGap64,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.r),
                      color: Colors.white,
                    ),
                    width: 0.9.sw,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 40.h),
                      child: Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: sn.onPollType,
                            child: Container(
                              height: 100.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35.r),
                                color: sn.isText
                                    ? AppColors.primaryColorLight
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  "Text",
                                  style: TextStyle(
                                      fontSize: 40.sp,
                                      color: sn.isText
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                          Gaps.hGap64,
                          Expanded(
                              child: InkWell(
                            onTap: sn.onPollType,
                            child: Container(
                              height: 100.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35.r),
                                color: sn.isDate
                                    ? AppColors.primaryColorLight
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  "Date",
                                  style: TextStyle(
                                      fontSize: 40.sp,
                                      color: sn.isDate
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  Gaps.vGap128,
                  Text(
                    "Question Text",
                    style: TextStyle(
                        fontSize: 40.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Gaps.vGap32,
                  CustomTextField(
                    border: _border,
                    errorBorder: _border,
                    enabledBorder: _border,
                    disabledBorder: _border,
                    focusedBorder: _border,
                    filled: true,
                    fillColor: Colors.white,
                    primaryFieldColor: AppColors.regularFontColor,
                    textKey: sn.groupDetailsKey,
                    controller: sn.groupDetailsController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    focusNode: sn.groupDetailsFocusNode,
                    minLines: 4,
                    maxLines: 9,
                    hintText: "Enter your question here",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h),
                    horizontalMargin: 0.w,
                    onFieldSubmitted: (term) {},
                    onChanged: (value) {},
                  ),
                  Gaps.vGap64,
                  Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    thickness: 1,
                    height: 30.h,
                  ),
                  Gaps.vGap64,
                  Text(
                    "Answer Choice",
                    style: TextStyle(
                        fontSize: 40.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SlidingAnimated(
                        initialOffset: 5,
                        intervalStart: 0.4,
                        intervalEnd: 0.5,
                        child: Container(
                          width: 0.9.sw,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35.r),
                              color: Colors.white,
                              border: Border.all(
                                  color: AppColors.mansourLightGreyColor_8)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50.w, vertical: 40.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "1.",
                                      style: TextStyle(fontSize: 45.sp),
                                    ),
                                    const Text("RTX 2080 Super Today"),
                                  ],
                                ),
                                Container(
                                  height: 50.h,
                                  width: 50.h,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Gaps.vGap64;
                    },
                    itemCount: 2,
                  ),
                  Gaps.vGap64,
                  SlidingAnimated(
                    direction: Axis.vertical,
                    initialOffset: 5,
                    intervalStart: 0.4,
                    intervalEnd: 0.5,
                    child: CustomTextField(
                      border: _border,
                      errorBorder: _border,
                      enabledBorder: _border,
                      disabledBorder: _border,
                      focusedBorder: _border,
                      filled: true,
                      fillColor: Colors.white,
                      primaryFieldColor: AppColors.regularFontColor,
                      textKey: sn.groupTitleKey,
                      controller: sn.groupTitleController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      focusNode: sn.groupTitleFocusNode,
                      hintText: "Enter group title",
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 40.h),

                      // validator: (value) {
                      //   if (Validators.isValidName(value!))
                      //     return null;
                      //   else
                      //     return Translation.of(context).errorEmptyField;
                      // },
                      onFieldSubmitted: (term) {
                        // fieldFocusChange(
                        //     context, sn.groupTitleFocusNode, sn.groupDetailsFocusNode);
                      },
                      onChanged: (value) {},
                    ),
                  ),
                  Gaps.vGap64,
                  Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    thickness: 1,
                    height: 30.h,
                  ),
                  Gaps.vGap64,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Set Ending Poll Date",
                        style: TextStyle(
                            fontSize: 40.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      FlutterSwitch(
                        height: 60.h,
                        width: 120.w,
                        value: sn.selectDate,
                        onToggle: sn.SelectSwitchDate,
                        activeColor: AppColors.primaryColorLight,
                        inactiveColor: AppColors.mansourLightGreyColor_3,
                        toggleColor: Colors.white,
                      ),
                    ],
                  ),
                  Gaps.vGap64,
                  SlidingAnimated(
                    initialOffset: 5,
                    intervalStart: 0.3,
                    intervalEnd: 0.4,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 40.w,
                      ),
                      child: CustomListTile(
                        title: Text(
                          sn.date != null
                              ? DateFormat('yMd').format(sn.date!)
                              : "Date",
                          style: TextStyle(
                            color: sn.date != null
                                ? Colors.black
                                : AppColors.mansourNotSelectedBorderColor,
                            fontSize: 40.sp,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColors.mansourBackArrowColor,
                          size: 45.sp,
                        ),
                        onTap: sn.onDatePickerTap,
                      ),
                    ),
                  ),
                  Gaps.vGap32,
                  Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    thickness: 1,
                    height: 30.h,
                  ),
                  Gaps.vGap64,
                  Text(
                    "Participants",
                    style: TextStyle(
                        fontSize: 40.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Gaps.vGap32,
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 30.w, vertical: 30.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.r),
                      color: Colors.white,
                      border: Border.all(
                          color: AppColors.mansourLightGreyColor_5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: radius,
                              child: CustomListPile(images: [
                                _buildPile(
                                  radius,
                                  Image.asset(
                                    "assets/images/png/temp/friendR1.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                _buildPile(
                                  radius,
                                  Image.asset(
                                    "assets/images/png/temp/friendR2.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                _buildPile(
                                  radius,
                                  Image.asset(
                                    "assets/images/png/temp/friendR3.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ], radius: radius, space: radius * 0.6),
                            ),
                            Gaps.hGap8,
                            Text(
                              "You,Jack & Sam",
                              style: TextStyle(
                                  fontSize: 25.sp, color: Colors.black),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 70.h,
                          width: 70.h,
                          child: SvgPicture.asset(
                            isArabic ? AppConstants.SVG_ARROW_IOS_LEFT : AppConstants.SVG_ARROW_IOS_RIGHT,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.vGap32,
                  Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    thickness: 1,
                    height: 30.h,
                  ),
                  Gaps.vGap64,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Allow Motivates",
                        style: TextStyle(
                            fontSize: 40.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      FlutterSwitch(
                        height: 60.h,
                        width: 120.w,
                        value: sn.multivotes,
                        onToggle: sn.SelectSwitchMultivotes,
                        activeColor: AppColors.primaryColorLight,
                        inactiveColor: AppColors.mansourLightGreyColor_3,
                        toggleColor: Colors.white,
                      ),
                    ],
                  ),
                  Gaps.vGap32,
                  Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    thickness: 1,
                    height: 30.h,
                  ),
                  Gaps.vGap64,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Anonymous Votes",
                        style: TextStyle(
                            fontSize: 40.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      FlutterSwitch(
                        height: 60.h,
                        width: 120.w,
                        value: sn.votes,
                        onToggle: sn.SelectSwitchVotes,
                        activeColor: AppColors.primaryColorLight,
                        inactiveColor: AppColors.mansourLightGreyColor_3,
                        toggleColor: Colors.white,
                      ),
                    ],
                  ),
                  Gaps.vGap32,
                  Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    thickness: 1,
                    height: 30.h,
                  ),
                  Gaps.vGap64,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Allow New Option",
                        style: TextStyle(
                            fontSize: 40.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      FlutterSwitch(
                        height: 60.h,
                        width: 120.w,
                        value: sn.option,
                        onToggle: sn.SelectSwitchOption,
                        activeColor: AppColors.primaryColorLight,
                        inactiveColor: AppColors.mansourLightGreyColor_3,
                        toggleColor: Colors.white,
                      ),
                    ],
                  ),
                  Gaps.vGap32,
                  Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    thickness: 1,
                    height: 30.h,
                  ),
                  Gaps.vGap256,
                ],
              ),
            ),
          ),
        ));
  }
  Widget _buildPile(double radius, Widget child) {
    return Container(
      height: radius,
      width: radius,
      color: Colors.white,
      child: Center(
        child: ClipOval(
          child: Container(
            height: radius * 0.9,
            width: radius * 0.9,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
