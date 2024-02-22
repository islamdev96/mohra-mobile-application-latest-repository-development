import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/group_screen_params.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/features/challenge/presentation/widget/custom_list_pile.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';
import 'package:starter_application/features/moment/presentation/widget/pick_images_grid.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/group_details_screen_notifier.dart';
import 'group_screen.dart';

class GroupDetailsScreenContent extends StatefulWidget {
  @override
  State<GroupDetailsScreenContent> createState() =>
      _GroupDetailsScreenContentState();
}

class _GroupDetailsScreenContentState extends State<GroupDetailsScreenContent> {
  late GroupDetailsScreenNotifier sn;
  final double radius = 120.r;
  double HeaderHeight = 0.15.sh;
  double ContentHeight = 0.13.sh;
  double footerHeight = 0.17.sh;
    final _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        20.r,
      ),
      borderSide: const BorderSide(
        color: AppColors.mansourLightGreyColor_10,
      ),
    );

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<GroupDetailsScreenNotifier>(context);
    sn.context = context;
    return ModalProgressHUD(
      inAsyncCall: sn.showHud,
      child: Stack(
        children: [
          Positioned(
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
                          "Enter Group Details",
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
          ),
          Positioned.fill(
            top: ContentHeight - 40.h,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.r),
                  topRight: Radius.circular(50.r),
                ),
                color: AppColors.mansourLightGreyColor_4,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gaps.vGap32,
                      _buildPickImagesGrid(),
                      Gaps.vGap64,
                      _buildGroupTitle(),
                      if (!sn.params.isEditGroup)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 45.w),
                          child: Text(
                            "Participants",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 35.sp),
                          ),
                        ),
                      if (!sn.params.isEditGroup)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 30.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.w, vertical: 30.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.white,
                              border: Border.all(
                                  color: AppColors.mansourLightGreyColor_5),
                            ),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Nav.to(GroupScreen.routeName,
                                        arguments: GroupScreenParams(
                                            friends: sn.friends
                                                .map((e) => e.id!)
                                                .toList()))
                                    .then((value) {
                                  sn.friends = (value as List<FriendEntity>);
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: radius,
                                          child: CustomListPile(
                                              images: sn.friends
                                                  .map(
                                                    (e) => _buildPile(
                                                        radius,
                                                        CustomNetworkImageWidget(
                                                            imgPath: e
                                                                    .friendInfo
                                                                    ?.imageUrl ??
                                                                '')),
                                                  )
                                                  .toList(),
                                              radius: radius,
                                              space: radius * 0.6),
                                        ),
                                        Expanded(
                                          child: Text(
                                            sn.getParticipantsText(),
                                            style: TextStyle(
                                                fontSize: 40.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 70.h,
                                    width: 70.h,
                                    child: SvgPicture.asset(
                                        AppConstants.SVG_ARROW_IOS_RIGHT
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      Gaps.vGap256,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
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
                  children: [_buildButton()],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return SlidingAnimated(
      initialOffset: 5,
      intervalStart: 0.5,
      intervalEnd: 0.6,
      direction: Axis.vertical,
      child: CustomMansourButton(
        borderRadius: Radius.circular(20.r),
        height: 120.h,
        backgroundColor: AppColors.primaryColorLight,
        titleText: sn.params.isEditGroup
            ? Translation.current.edit_group
            : Translation.current.Create_Group,
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        titleStyle: TextStyle(fontSize: 45.sp, color: AppColors.white),
        onPressed: () {
          sn.navToGroup();
        },
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

  /// PickImagesGrid
  Widget _buildPickImagesGrid() {
    return PickImagesGrid(
      cameraButtonBackgroundColor: AppColors.white,
      padding: AppConstants.screenPadding,
      shrinkWrap: true,
      maxImagesCount: 1,
      physics: const NeverScrollableScrollPhysics(),
      onImagesPicked: sn.onImagesPicked,
      onImageDeleted: sn.onImageDeleted,
      imagesPaths: sn.imagesPaths,
    );
  }

  Widget _buildGroupTitle() {
    return Form(
      key: sn.form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.w),
            child: Text(
              "Group Title",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 35.sp),
            ),
          ),
          Gaps.vGap32,
          _buildNameField(),
          Gaps.vGap32,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.w),
            child: Text(
              "Group Details",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 35.sp),
            ),
          ),
          Gaps.vGap32,
          _buildDetailsField()
        ],
      ),
    );
  }

  _buildNameField() {
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
        textKey: sn.groupTitleKey,
        controller: sn.groupTitleController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        focusNode: sn.groupTitleFocusNode,
        hintText: "Enter group title",
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
        horizontalMargin: 40.w,
        validator: (value) {
          if (Validators.isValidName(value!))
            return null;
          else
            return Translation.of(context).errorEmptyField;
        },
        onFieldSubmitted: (term) {
          fieldFocusChange(
              context, sn.groupTitleFocusNode, sn.groupDetailsFocusNode);
        },
        onChanged: (value) {},
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
        hintText: "Enter your group details",
        contentPadding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h),
        horizontalMargin: 40.w,
        validator: (value) {
          if (Validators.isValidName(value!))
            return null;
          else
            return Translation.of(context).errorEmptyField;
        },
        onFieldSubmitted: (term) {},
        onChanged: (value) {},
      ),
    );
  }
}
