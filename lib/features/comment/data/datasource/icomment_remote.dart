import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/features/comment/data/model/request/comment_request.dart';
import 'package:starter_application/features/comment/data/model/request/get_comments_request.dart';
import 'package:starter_application/features/comment/data/model/response/comment_model.dart';
import 'package:starter_application/features/comment/data/model/response/comments_model.dart';

import '../../../../core/datasources/remote_data_source.dart';

abstract class ICommentRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, CommentsModel>> getComments(
      GetCommentsRequest param);

  Future<Either<AppErrors, CommentModel>> comment(CommentRequest param);
}
