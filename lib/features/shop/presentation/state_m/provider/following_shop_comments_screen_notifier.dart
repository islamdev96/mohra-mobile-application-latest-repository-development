import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/comment/data/model/request/comment_request.dart';
import 'package:starter_application/features/comment/data/model/request/get_comments_request.dart';
import 'package:starter_application/features/comment/domain/entity/comment_client_entity.dart';
import 'package:starter_application/features/comment/domain/entity/comment_entity.dart' as MainComment;
import 'package:starter_application/features/comment/domain/usecase/get_comments_usecase.dart';
import 'package:starter_application/features/comment/presentation/state_m/cubit/comment_cubit.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';


class FollowingShopCommentsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  List<MainComment.CommentEntity> comments = [];
  CommentCubit commentCubit = CommentCubit();
  CommentCubit getCommentsCubit = CommentCubit();
  TextEditingController commentController = TextEditingController();
  bool isCommentActionLoading = false;
  bool isGetCommentsLoading = false;
  bool noMoreComments = false;
  int commentsFetched = 0;
  late int shopId;

  ScrollController scrollController = ScrollController();
  final RefreshController commentRefreshController = RefreshController();
  /// Getters and Setters


  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

   Future<Result<AppErrors, List<MainComment.CommentEntity>>> getComments(int unit)async {

    final result = await getIt<GetCommentsUseCase>().call(GetCommentsRequest(
        refType: 4,
        refId: shopId.toString(),
        maxResultCount: 10,
        skipCount: commentsFetched),
    );

    return Result<AppErrors, List<MainComment.CommentEntity>>(
        data: result.data?.items, error: result.error);
  }

   getFirstComments()async {
      getCommentsCubit.getComments(
          GetCommentsRequest(
              refType: 4,
              refId: shopId.toString(),
              maxResultCount: 10,
              skipCount: commentsFetched)
      );
  }

  onGetFirstComments(List<MainComment.CommentEntity> items){
    comments = items;
    commentsFetched = items.length;
    notifyListeners();
  }

  gotCommentsSuccessfully(List<MainComment.CommentEntity> items , int unit) {
    commentsFetched = items.length;
    comments = items;
    notifyListeners();
  }

  comment() {
    if (true) {
      isCommentActionLoading = true;
      commentCubit.comment(CommentRequest(
        text: commentController.text,
        refType: 4,
        refId: shopId.toString(),
      ));
    }
  }




  commentedSuccessfully(MainComment.CommentEntity item) {
    isCommentActionLoading = false;
    comments.add(MainComment.CommentEntity(text: item.text, refId: item.refId, client: CommentClientEntity(
      name: UserSessionDataModel.name,
      fullName: UserSessionDataModel.fullName,
      imageUrl: UserSessionDataModel.imageUrl ?? '',
      emailAddress: UserSessionDataModel.emailAddress,
      id: UserSessionDataModel.userId,
      phoneNumber: UserSessionDataModel.phoneNumber
    )));
    commentController.text = '';
    notifyListeners();
  }

  String getTime(DateTime? dateTime) {
    if (dateTime != null) {
      final now = DateTime.now();
      final dif = now.difference(dateTime);
      if (dif.inDays > 365)
        return DateFormat('dd/MM/yyyy hh:mm').format(dateTime);
      else if (dif.inDays > 30)
        return DateFormat('dd/MM hh:mm').format(dateTime);
      else if (dif.inDays > 1)
        return '${dif.inDays} ${Translation.current.days_ago}';
      else if (dif.inDays > 0)
        return '${dif.inDays} ${Translation.current.day_ago}';
      else if (dif.inHours > 1)
        return '${dif.inHours} ${Translation.current.hours_ago}';
      else if (dif.inHours > 0)
        return '${dif.inHours} ${Translation.current.hour_ago}';
      else if (dif.inMinutes > 1)
        return '${dif.inMinutes} ${Translation.current.minutes_ago}';
      else if (dif.inMinutes > 0)
        return '${dif.inMinutes} ${Translation.current.minute_ago}';
      else
        return '${Translation.current.seconds_ago}';
    } else
      return '';
  }

}
