import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starter_application/features/comment/data/model/request/comment_request.dart';
import 'package:starter_application/features/comment/data/model/request/get_comments_request.dart';
import 'package:starter_application/features/comment/domain/entity/comment_entity.dart';
import 'package:starter_application/features/comment/presentation/state_m/cubit/comment_cubit.dart';
import 'package:starter_application/features/news/domain/entity/news_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class HomeCommentsSecationScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late Function onHideAllPressed;
  late Function onAddComment;
  CommentCubit commentCubit = CommentCubit();
  CommentCubit getCommentsCubit = CommentCubit();
  bool _isCommentActionLoading = false;
  bool _isGetCommentsLoading = false;
  bool _noMoreComments = false;
  GlobalKey<FormState> formKey = GlobalKey();
  late NewsItemOfCategoryEntity entity;
  TextEditingController commentController = TextEditingController();
  List<CommentEntity> _comments = [];
  int commentsFetched = 0;

  /// Getters and Setters

  bool get isCommentActionLoading => _isCommentActionLoading;

  set isCommentActionLoading(bool value) {
    _isCommentActionLoading = value;
    notifyListeners();
  }

  List<CommentEntity> get comments => _comments;

  set comments(List<CommentEntity> value) {
    _comments = value;
  }

  bool get isGetCommentsLoading => _isGetCommentsLoading;

  set isGetCommentsLoading(bool value) {
    _isGetCommentsLoading = value;
    notifyListeners();
  }

  bool get noMoreComments => _noMoreComments;

  set noMoreComments(bool value) {
    _noMoreComments = value;
    notifyListeners();
  }

  /// Methods

  comment() {
    if (formKey.currentState?.validate() ?? false) {
      isCommentActionLoading = true;
      commentCubit.comment(CommentRequest(
        text: commentController.text,
        refType: 2,
        refId: entity.id.toString(),
      ));
    }
  }

  gotCommentsSuccessfully(List<CommentEntity> items) {
    commentsFetched = commentsFetched + items.length;
    addToComments(items);
  }

  addToComments(List<CommentEntity> items) {
    List<CommentEntity> rev = comments.reversed.toList();
    rev.addAll(items);
    comments = rev.reversed.toList();
    notifyListeners();
  }

  getComments() {
    isGetCommentsLoading = true;
    getCommentsCubit.getComments(GetCommentsRequest(
        refType: 2,
        refId: entity.id.toString(),
        maxResultCount: 10,
        skipCount: commentsFetched));
  }

  commentedSuccessfully(CommentEntity commentEntity) {
    isCommentActionLoading = false;
    commentController.text = '';
    onAddComment();
    comments.add(commentEntity);
    commentsFetched++;
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
        return '${dif.inDays} days ago';
      else if (dif.inDays > 0)
        return '${dif.inDays} day ago';
      else if (dif.inHours > 1)
        return '${dif.inHours} hours ago';
      else if (dif.inHours > 0)
        return '${dif.inHours} hour ago';
      else if (dif.inMinutes > 1)
        return '${dif.inMinutes} minutes ago';
      else if (dif.inMinutes > 0)
        return '${dif.inMinutes} minute ago';
      else
        return 'seconds ago';
    } else
      return '';
  }

  @override
  void closeNotifier() {
    commentCubit.close();
    getCommentsCubit.close();
    this.dispose();
  }
}
