import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/moment/data/model/request/create_post_param.dart';
import 'package:starter_application/features/moment/domain/repository/imoment_repository.dart';

@injectable
class CreatePostUseCase extends UseCase<EmptyResponse, CreateEditPostParam> {
  final IMomentRepository repository;

  CreatePostUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(CreateEditPostParam param) {
    return repository.createPost(param);
  }
}
