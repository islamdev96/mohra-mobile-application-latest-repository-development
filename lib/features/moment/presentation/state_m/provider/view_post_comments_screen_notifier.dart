import 'package:flutter/material.dart';
import 'package:starter_application/features/comment/data/model/request/get_comments_request.dart';
import 'package:starter_application/features/comment/domain/entity/comment_entity.dart';
import 'package:starter_application/features/comment/domain/entity/comments_entity.dart';
import 'package:starter_application/features/comment/presentation/state_m/cubit/comment_cubit.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
//import 'lib/features/comment/domain/entity/comment_entity.dart';


class ViewPostCommentsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late MomentItemEntity momentItemEntity;
  final commentCubit = CommentCubit();
  late CommentsEntity commentsEntity;
  List<CommentEntity> comments = [];
  int limit = 10;
  int offset =0;
  /// Getters and Setters


  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }


  getComments(){
    commentCubit.getComments(GetCommentsRequest(refType: 3, refId: '${momentItemEntity.id}' , skipCount: offset , maxResultCount: limit));
  }

  getMore(){
    commentCubit.getComments(GetCommentsRequest(refType: 3, refId: '${momentItemEntity.id}', skipCount: limit, maxResultCount: offset));
  }


  onCommentsLoaded(CommentsEntity commentsEntity){
    this.commentsEntity = commentsEntity;
    comments  = commentsEntity.items;
    offset  = commentsEntity.items.length;
  }


}
