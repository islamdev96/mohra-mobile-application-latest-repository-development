import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/comment/data/model/request/comment_request.dart';
import 'package:starter_application/features/comment/domain/entity/comment_entity.dart';
import 'package:starter_application/features/comment/domain/repository/icomment_repository.dart';

@injectable
class CommentUseCase extends UseCase<CommentEntity, CommentRequest> {
  ICommentRepository commentRepository;
  CommentUseCase(this.commentRepository);
  @override
  Future<Result<AppErrors, CommentEntity>> call(CommentRequest param) async {
    return await commentRepository.comment(param);
  }
}
