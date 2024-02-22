import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/comment/data/model/request/comment_request.dart';
import 'package:starter_application/features/comment/data/model/request/get_comments_request.dart';
import 'package:starter_application/features/comment/domain/entity/comment_entity.dart';
import 'package:starter_application/features/comment/domain/entity/comments_entity.dart';

import '../../../../core/repositories/repository.dart';

abstract class ICommentRepository extends Repository {
  Future<Result<AppErrors, CommentsEntity>> getComments(
      GetCommentsRequest param);

  Future<Result<AppErrors, CommentEntity>> comment(CommentRequest param);
}
