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
import 'package:starter_application/features/news/presentation/state_m/provider/news_comments_secation_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../main.dart';

class NewsCommentsSecationScreenContent extends StatefulWidget {
  @override
  State<NewsCommentsSecationScreenContent> createState() =>
      _NewsCommentsSecationScreenContentState();
}

class _NewsCommentsSecationScreenContentState
    extends State<NewsCommentsSecationScreenContent> {
  late NewsCommentsSecationScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<NewsCommentsSecationScreenNotifier>(context);
    sn.context = context;
    return Column(
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
        if (sn.noMoreComments)
          const SizedBox.shrink()
        else
          GestureDetector(
            onTap: () {
              sn.getComments();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Translation.of(context).view_previous_comments,
                style: TextStyle(
                  color: AppColors.textLight2,
                  fontSize: 45.sp,
                  fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                ),
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
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: AppColors.textLight2,
                fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
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
            height: 120.w,
            width: 120.w,
            imageUrl: UserSessionDataModel.imageUrl,
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
            height: 140.w,
            width: 140.w,
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
          height: 140.w,
          width: 140.w,
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
                  Text(
                    commentEntity.client?.name ?? '',
                    style: TextStyle(
                      color: AppColors.black_text,
                      fontSize: 45.sp,
                      fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                    ),
                  ),
                  const Spacer(),
                  Text(
                    sn.getTime(commentEntity.creationTime),
                    style: TextStyle(
                      color:
                          AppColors.mansourLightGreyColor_17.withOpacity(0.5),
                      fontWeight: FontWeight.w100,
                      fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                    ),
                  ),
                ],
              ),
              Text(
                commentEntity.text,
                style: TextStyle(
                  color: AppColors.mansourLightGreyColor_17,
                  height: 1.5,
                  fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
