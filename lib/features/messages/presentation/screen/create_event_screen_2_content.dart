import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/features/challenge/presentation/widget/custom_list_pile.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/create_event_screen_notifier.dart';

class CreateEventScreen2Content extends StatefulWidget {
  @override
  State<CreateEventScreen2Content> createState() =>
      _CreateEventScreen2ContentState();
}

class _CreateEventScreen2ContentState extends State<CreateEventScreen2Content> {
  late CreateEventScreenNotifier sn;
  double HeaderHeight = 0.15.sh;
  double ContentHeight = 0.13.sh;
  final double radius = 120.r;
  final EdgeInsets padding =
      EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h);
  final EdgeInsets rowPadding =
      EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h);
  final EdgeInsets hpadding =
      EdgeInsets.only(left: 40.w, right: 40.w, top: 40.h);
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
    sn = Provider.of<CreateEventScreenNotifier>(context);
    sn.context = context;
    return Stack(
      children: [_buildHeader(), _buildContent()],
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
                    Translation.current.create_event,
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
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Event Title",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold),
                ),
                Gaps.vGap32,
                Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.white,
                      border:
                          Border.all(color: AppColors.mansourLightGreyColor_5)),
                  child: Padding(
                    padding: rowPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Enter event title",
                          style: TextStyle(
                              fontSize: 40.sp,
                              color: AppColors.mansourLightGreyColor_11),
                        ),
                        SizedBox(
                          height: 60.h,
                          width: 60.h,
                          child: SvgPicture.asset(
                            AppConstants.SVG_IMAGE_MESSAGE,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gaps.vGap32,
                Text(
                  "Starting Date",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold),
                ),
                Gaps.vGap32,
                Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.white,
                      border:
                          Border.all(color: AppColors.mansourLightGreyColor_5)),
                  child: Padding(
                    padding: rowPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select the date",
                          style: TextStyle(
                              fontSize: 40.sp,
                              color: AppColors.mansourLightGreyColor_11),
                        ),
                        SizedBox(
                          height: 60.h,
                          width: 60.h,
                          child: SvgPicture.asset(
                            AppConstants.SVG_ARROW_IOS_RIGHT,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gaps.vGap32,
                Text(
                  "End Date",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold),
                ),
                Gaps.vGap32,
                Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.white,
                      border:
                          Border.all(color: AppColors.mansourLightGreyColor_5)),
                  child: Padding(
                    padding: rowPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select the date",
                          style: TextStyle(
                              fontSize: 40.sp,
                              color: AppColors.mansourLightGreyColor_11),
                        ),
                        SizedBox(
                          height: 60.h,
                          width: 60.h,
                          child: SvgPicture.asset(
                            AppConstants.SVG_ARROW_IOS_RIGHT,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gaps.vGap32,
                Text(
                  "Location",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold),
                ),
                Gaps.vGap32,
                Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.white,
                      border:
                          Border.all(color: AppColors.mansourLightGreyColor_5)),
                  child: Padding(
                    padding: rowPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select event location",
                          style: TextStyle(
                              fontSize: 40.sp,
                              color: AppColors.mansourLightGreyColor_11),
                        ),
                        SizedBox(
                          height: 60.h,
                          width: 60.h,
                          child: SvgPicture.asset(
                            AppConstants.SVG_ARROW_IOS_RIGHT,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gaps.vGap32,
                Text(
                  "Participants",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold),
                ),
                Gaps.vGap32,
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.r),
                    color: Colors.white,
                    border:
                        Border.all(color: AppColors.mansourLightGreyColor_5),
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
                                fontSize: 40.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 70.h,
                        width: 70.h,
                        child:
                            SvgPicture.asset(AppConstants.SVG_ARROW_IOS_RIGHT),
                      ),
                    ],
                  ),
                ),
                Gaps.vGap32,
                Text(
                  "Detail",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold),
                ),
                Gaps.vGap32,
                _buildDetailsField(),
                Gaps.vGap64,
                CustomMansourButton(
                  titleText: "Create Now",
                  textColor: AppColors.white,
                  backgroundColor: AppColors.primaryColorLight,
                  onPressed: () {
                    sn.onCreateCustom(
                        context,
                        AppConstants.SVG_ORDER_DONE,
                        "Successful",
                        'your order has been successfully placed',
                        true);
                  },
                ),
              ],
            ),
          )),
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

  _buildDetailsField() {
    return Container(
      child: CustomTextField(
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
        hintText: "Enter event detail",
        contentPadding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h),
        horizontalMargin: 0.w,
        validator: (value) {},
        onFieldSubmitted: (term) {},
        onChanged: (value) {},
      ),
    );
  }
}
