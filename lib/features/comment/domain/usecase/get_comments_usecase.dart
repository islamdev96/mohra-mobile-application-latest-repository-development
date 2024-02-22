import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/comment/data/model/request/get_comments_request.dart';
import 'package:starter_application/features/comment/domain/entity/comments_entity.dart';
import 'package:starter_application/features/comment/domain/repository/icomment_repository.dart';

@injectable
class GetCommentsUseCase extends UseCase<CommentsEntity, GetCommentsRequest> {
  ICommentRepository commentRepository;
  GetCommentsUseCase(this.commentRepository);
  @override
  Future<Result<AppErrors, CommentsEntity>> call(
      GetCommentsRequest param) async {
    return await commentRepository.getComments(param);
  }
}
