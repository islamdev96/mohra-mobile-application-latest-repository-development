import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/comment/data/model/request/comment_request.dart';
import 'package:starter_application/features/comment/data/model/request/get_comments_request.dart';
import 'package:starter_application/features/comment/data/model/response/comment_model.dart';
import 'package:starter_application/features/comment/data/model/response/comments_model.dart';
import 'package:starter_application/features/comment/domain/entity/comment_entity.dart';
import 'package:starter_application/features/comment/domain/entity/comments_entity.dart';

import '../datasource/../../domain/repository/icomment_repository.dart';
import '../datasource/icomment_remote.dart';

@Singleton(as: ICommentRepository)
class CommentRepository extends ICommentRepository {
  final ICommentRemoteSource iCommentRemoteSource;

  CommentRepository(this.iCommentRemoteSource);

  @override
  Future<Result<AppErrors, CommentsEntity>> getComments(
      GetCommentsRequest param) async {
    final Either<AppErrors, CommentsModel> remoteResult =
        await iCommentRemoteSource.getComments(param);
    return remoteResult.result<CommentsEntity>();
  }

  @override
  Future<Result<AppErrors, CommentEntity>> comment(CommentRequest param) async {
    final Either<AppErrors, CommentModel> remoteResult =
        await iCommentRemoteSource.comment(param);
    return remoteResult.result<CommentEntity>();
  }
}
