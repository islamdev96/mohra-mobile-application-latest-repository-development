import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/comment/presentation/state_m/cubit/comment_cubit.dart';
import 'package:starter_application/features/moment/presentation/widget/comment_card.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import '../screen/../state_m/provider/view_post_comments_screen_notifier.dart';

class ViewPostCommentsScreenContent extends StatelessWidget {
  late ViewPostCommentsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ViewPostCommentsScreenNotifier>(context);
    sn.context = context;
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        padding: EdgeInsets.symmetric(horizontal: 50.h),
        child: BlocConsumer<CommentCubit, CommentState>(
          bloc: sn.commentCubit,
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => Container(),
              commentLoadingState: (s) => WaitingWidget(),
              commentsLoadedState: (s) => ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [

                  Container(
                    height: 0.9.sh,
                    width: 0.9.sw,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              CommentCard(
                                width: .85.sw,
                                height: 120,
                                username: sn.comments[index].client!.fullName,
                                date: DateTimeHelper.getFormatedDate(
                                    sn.comments[index].creationTime!),
                                comment: sn.comments[index].text,
                                imageUrl: sn.comments[index].client!.imageUrl,
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Column(
                            children: [
                              Gaps.vGap32,
                            ],
                          );
                        },
                        itemCount: sn.comments.length),
                  )
                ],
              ),
            );
          },
          listener: (context, state) {
            if (state is CommentsLoadedState) {
              sn.onCommentsLoaded(state.commentsEntity);
            }
          },
        ),
      ),
    );
  }
}
