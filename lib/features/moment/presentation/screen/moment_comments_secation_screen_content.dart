import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/comment/domain/entity/comment_entity.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/home_comments_secation_screen_notifier.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/moment_comments_secation_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

class MomentCommentsSecationScreenScreenContent extends StatefulWidget {
  @override
  State<MomentCommentsSecationScreenScreenContent> createState() =>
      _MomentCommentsSecationScreenScreenContentState();
}

class _MomentCommentsSecationScreenScreenContentState
    extends State<MomentCommentsSecationScreenScreenContent> {
  late MomentCommentsSecationNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<MomentCommentsSecationNotifier>(context);
    sn.context = context;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHideAllWidget(),
          SizedBox(
            height: 40.h,
          ),
          _buildInsertCommentWidget(),
          SizedBox(
            height: 20.h,
          ),
          sn.noMoreComments
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () {
                    sn.getComments();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      Translation.of(context).view_previous_comments,
                      style: TextStyle(
                          color: AppColors.textLight2, fontSize: 35.sp),
                    ),
                  ),
                ),
          SizedBox(
            height: 20.h,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildCommentWidget(sn.comments.elementAt(index));
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: 30.h,
                  ),
              itemCount: sn.comments.length)
        ],
      ),
    );
  }

  Widget _buildHideAllWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            sn.onHideAllPressed();
          },
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Text(
              Translation.of(context).hide_all,
              style: const TextStyle(
                decoration: TextDecoration.underline,
                color: AppColors.textLight2,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildInsertCommentWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRect(
          child: ProfilePic(
            imageUrl: UserSessionDataModel.imageUrl,
            height: 120.w,
            width: 120.w,
          ),
        ),
        SizedBox(
          width: 30.w,
        ),
        Expanded(
            child: Container(
          height: 120.w,
          decoration: BoxDecoration(
              color: AppColors.mansourLightGreyColor_5.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20.r)),
          child: Center(
            child: Form(
              key: sn.formKey,
              child: CustomTextField(
                focusNode: sn.currentFocus,
                validator: (value) {
                  if (value == '' || value == null)
                    return Translation.of(context).insert_comment;
                },
                hintText: Translation.of(context).write_comment,
                hintStyle:
                    const TextStyle(color: AppColors.mansourLightGreyColor_17),
                controller: sn.commentController,
                maxLines: 1,
                padding: EdgeInsets.zero,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
              ),
            ),
          ),
        )),
        sn.isCommentActionLoading
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    SizedBox(height: 60.w, width: 60.w, child: WaitingWidget()),
              )
            : IconButton(
                onPressed: () {
                  sn.comment();
                  sn.currentFocus.unfocus();
                },
                icon: const Icon(Icons.send),
                splashRadius: 50.w,
              )
      ],
    );
  }

  Widget _buildCommentWidget(CommentEntity commentEntity) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomNetworkImageWidget(
          radius: 1.sw,
          errorImage: Container(
            height: 100.w,
            width: 100.w,
            decoration: BoxDecoration(
              color: AppColors.accentColorLight.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                AppConstants.SVG_MY_LIFE,
              ),
            ),
          ),
          imgPath: commentEntity.client?.imageUrl ?? '',
          height: 120.w,
          width: 120.w,
        ),
        SizedBox(
          width: 30.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width : 0.3.sw,
                    child: Text(
                      commentEntity.client?.name ?? '',
                      style: TextStyle(
                        color: AppColors.black_text,
                        fontSize: 35.sp,
                        overflow: TextOverflow.ellipsis
                      ),
                        overflow: TextOverflow.ellipsis
                    ),
                  ),
                  const Spacer(),
                  Text(
                    sn.getTime(commentEntity.creationTime),
                    style: TextStyle(
                        fontSize: 30.sp,
                        color:
                            AppColors.mansourLightGreyColor_17.withOpacity(0.5),
                        fontWeight: FontWeight.w100),
                  ),
                ],
              ),
              Text(
                commentEntity.text,
                style: const TextStyle(
                    color: AppColors.mansourLightGreyColor_17, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
