import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/features/comment/data/model/request/comment_request.dart';
import 'package:starter_application/features/comment/data/model/request/get_comments_request.dart';
import 'package:starter_application/features/comment/data/model/response/comment_model.dart';
import 'package:starter_application/features/comment/data/model/response/comments_model.dart';

import 'icomment_remote.dart';

@Singleton(as: ICommentRemoteSource)
class CommentRemoteSource extends ICommentRemoteSource {
  @override
  Future<Either<AppErrors, CommentsModel>> getComments(
      GetCommentsRequest param) {
    return request(
        converter: (json) => CommentsModel.fromMap(json),
        method: HttpMethod.GET,
        url: APIUrls.API_GET_COMMENTS,
        queryParameters: param.toMap());
  }

  @override
  Future<Either<AppErrors, CommentModel>> comment(CommentRequest param) {
    return request(
        converter: (json) => CommentModel.fromMap(json),
        method: HttpMethod.POST,
        url: APIUrls.API_COMMENT,
        body: param.toMap());
  }
}
