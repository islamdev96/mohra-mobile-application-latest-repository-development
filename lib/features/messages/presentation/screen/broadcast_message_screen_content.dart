import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/features/challenge/presentation/widget/custom_list_pile.dart';
import 'package:starter_application/features/messages/presentation/logic/messages_utils.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/broadcast_message_screen_notifier.dart';

class BroadcastMessageScreenContent extends StatefulWidget {
  @override
  State<BroadcastMessageScreenContent> createState() =>
      _BroadcastMessageScreenContentState();
}

class _BroadcastMessageScreenContentState
    extends State<BroadcastMessageScreenContent> {
  late BroadcastMessageScreenNotifier sn;
  final TextEditingController textFiledController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<BroadcastMessageScreenNotifier>(context);
    sn.context = context;
    final double radius = 120.r;

    return Container(
      width: 1.sw,
      height: 1.sh,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 300.h,
            width: 1.sw,
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
            child: Container(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Row(
                  children: [
                    Gaps.hGap32,
                    IconButton(
                      onPressed: () => Nav.pop(),
                      icon: Icon(
                        AppConstants.getIconBack(),
                        color: AppColors.white,
                        size: 75.sp,
                      ),
                    ),
                    Gaps.hGap32,
                    Text(
                      Translation.current.broadcast_message,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 45.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: 250.h,
            child: Container(
              width: 1.sw,
              height: 1.sh,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.r),
                  topRight: Radius.circular(50.r),
                ),
                color: Colors.white,
              ),
              child: CustomTextField(
                primaryFieldColor: AppColors.regularFontColor,
                textKey: sn.broadCastMessageKey,
                controller: sn.broadCastMessageController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                focusNode: sn.broadCastMessageFocusNode,
                hintText: Translation.current.write_message,
                hintStyle: TextStyle(
                  fontSize: 55.sp,
                  color: AppColors.mansourLightGreyColor_11,
                ),
                maxLines: 10,
                cursorHeight: 6,
                cursorColor: AppColors.primaryColorLight,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
                horizontalMargin: 40.w,
                validator: (value) {
                  if (Validators.isValidName(value!))
                    return null;
                  else
                    return Translation.of(context).errorEmptyField;
                },
                onFieldSubmitted: (term) {
                  sn.broadCastMessageFocusNode.unfocus();
                },
                onChanged: (value) {
                  sn.broadCastMessageKey.currentState!.validate();
                },
              ),
            ),
          ),
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
                        titleText: Translation.current.broadcast_message,
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        titleStyle:
                            TextStyle(fontSize: 40.sp, color: AppColors.white),
                        onPressed: () {
                          sn.sendBroadCastMessage();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 200.h,
            start: 50.w,
            end: 50.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  Translation.current.send_message_to,
                  style:
                      TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold),
                ),
                Gaps.vGap32,
                InkWell(
                  onTap: () {
                    sn.onFriendsTap();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
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
                              child: CustomListPile(
                                  images: MessagesUtils.friendsImages(sn
                                      .selectedFriends
                                      .map((e) => e.image)
                                      .toList())!,
                                  radius: radius,
                                  space: radius * 0.6),
                            ),
                            Gaps.hGap8,
                            Text(
                              "${MessagesUtils.friendsToString(sn.selectedFriends.map((e) => e.name).toList())}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 70.h,
                          width: 70.h,
                          child: SvgPicture.asset(
                              AppConstants.SVG_ARROW_IOS_RIGHT),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
