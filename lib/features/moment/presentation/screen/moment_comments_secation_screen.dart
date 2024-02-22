import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/features/comment/presentation/state_m/cubit/comment_cubit.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/moment_comments_secation_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'moment_comments_secation_screen_content.dart';

class MomentCommentsSecationScreenScreen extends StatefulWidget {
  static const String routeName = "/NewsCommentsSecationScreen";
  final Function onHideAllPressed;
  final Function onAddComment;
  final MomentItemEntity entity;
  const MomentCommentsSecationScreenScreen(
      {Key? key,
      required this.onHideAllPressed,
      required this.onAddComment,
      required this.entity})
      : super(key: key);

  @override
  _MomentCommentsSecationScreenScreenState createState() =>
      _MomentCommentsSecationScreenScreenState();
}

class _MomentCommentsSecationScreenScreenState
    extends State<MomentCommentsSecationScreenScreen> {
  final sn = MomentCommentsSecationNotifier();

  @override
  void initState() {
    super.initState();
    sn.entity = widget.entity;
    sn.onHideAllPressed = widget.onHideAllPressed;
    sn.onAddComment = widget.onAddComment;
    sn.getComments();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MomentCommentsSecationNotifier>.value(
        value: sn,
        child: MultiBlocListener(
          listeners: [
            BlocListener<CommentCubit, CommentState>(
              listener: (context, state) {
                state.mapOrNull(
                  commentCreatedState: (value) {
                    ErrorViewer.showError(
                        context: context,
                        error: AppErrors.customError(
                            message: Translation.of(context).comment_success),
                        callback: () {});
                    sn.commentedSuccessfully(value.commentEntity);
                  },
                  commentErrorState: (value) {
                    sn.isCommentActionLoading = false;
                    ErrorViewer.showError(
                        context: context, error: value.error, callback: () {});
                  },
                );
              },
              bloc: sn.commentCubit,
            ),
            BlocListener<CommentCubit, CommentState>(
              listener: (context, state) {
                state.mapOrNull(
                  commentsLoadedState: (value) {
                    sn.isGetCommentsLoading = false;
                    if (value.commentsEntity.items.isEmpty) {
                      AppErrors.customError(
                          message: Translation.of(context).no_more_comments);
                      sn.noMoreComments = true;
                    } else
                      sn.gotCommentsSuccessfully(value.commentsEntity.items);
                  },
                );
              },
              bloc: sn.getCommentsCubit,
            ),
          ],
          child: MomentCommentsSecationScreenScreenContent(),
        ));
  }
}
