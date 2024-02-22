import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/comment/domain/entity/comment_entity.dart';
import 'package:starter_application/features/comment/presentation/state_m/cubit/comment_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';
import 'package:starter_application/features/user/presentation/widget/custom_text_field.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/following_shop_comments_screen_notifier.dart';

class FollowingShopCommentsScreenContent extends StatelessWidget {
  late FollowingShopCommentsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<FollowingShopCommentsScreenNotifier>(context);
    sn.context = context;
    return Container(
      width: 1.sw,
      height: 1.sh,
      child: Stack(
        children: [
          Container(
            width: 1.sw,
            height: 0.7.sh,
            child: _buildListView(),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              width: 1.sw,
              height: 0.15.sh,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: _buildInsertCommentWidget(),
            ),
          ),

        ],
      ),
    );
  }

  _buildListView() {
    return BlocConsumer<CommentCubit, CommentState>(
      bloc: sn.getCommentsCubit,
      listener: (context, state) {
          if(state is CommentsLoadedState){
              sn.onGetFirstComments(state.commentsEntity.items);
          }
      },
      builder: (context, state) {
        return state.maybeMap(
          commentLoadingState: (s) => WaitingWidget(),
          commentErrorState: (s) {
            return Container();
          },
          orElse: () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: RefreshConfiguration(

              headerBuilder: () => ClassicHeader(
                refreshingIcon: Padding(
                  padding: EdgeInsets.only(top: 0.20.sh),
                  child: SizedBox(
                    height: 70.h,
                    width: 70.h,
                    child: const CircularProgressIndicator.adaptive(),
                  ),
                ),
                releaseIcon: Padding(
                  padding: EdgeInsets.only(top: 0.20.sh),
                  child: SizedBox(
                    height: 70.h,
                    width: 70.h,
                    child: const CircularProgressIndicator.adaptive(),
                  ),
                ),
                textStyle: const TextStyle(
                  fontSize: 0,
                ),
              ),
              child: PaginationWidget<CommentEntity>(
                items: sn.comments,
                getItems: sn.getComments,
                enablePullDown: false,
                onDataFetched: sn.gotCommentsSuccessfully,
                refreshController: sn.commentRefreshController,
                footer: ClassicFooter(
                  loadingText: "",
                  noDataText: Translation.of(context).noDataRefresher,
                  failedText: Translation.of(context).failedRefresher,
                  idleText: "",
                  canLoadingText: "",
                  /*  loadingIcon: Padding(
              padding: EdgeInsets.only(
                bottom: AppConstants.bottomNavigationBarHeight + 300.h,
              ),
              child: const CircularProgressIndicator.adaptive(),
            ), */
                  height: AppConstants.bottomNavigationBarHeight + 300.h,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: sn.comments.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _buildCommentWidget(sn.comments[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Gaps.vGap64;
                  },
                ),
              ),
            ),
          ),
        );
      },
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
                    width: 0.3.sw,
                    child: Text(commentEntity.client?.name ?? '',
                        style: TextStyle(
                            color: AppColors.black_text,
                            fontSize: 35.sp,
                            overflow: TextOverflow.ellipsis),
                        overflow: TextOverflow.ellipsis),
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

  Widget _buildInsertCommentWidget() {
    return BlocConsumer<CommentCubit,CommentState>(
      bloc: sn.commentCubit,
      listener: (context,state){
        if(state is CommentCreatedState){
          sn.commentedSuccessfully(state.commentEntity);
        }
      },
      builder: (context, state){
        return state.maybeMap(
          orElse: ()=>Row(

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
                        child: CustomTextField(

                          width: 0.7.sw,
                          textType: TextInputType.text,
                          action: TextInputAction.done,
                          hintText: Translation.current.write_comment,
                          controller: sn.commentController,
                          maxLines: 1,

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
          )

        );
      },
    );
  }
}
