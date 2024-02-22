import 'package:injectable/injectable.dart';
import 'package:starter_application/features/moment/data/model/request/delete_post_param.dart';

import '../../../../core/errors/app_errors.dart';
import '../../../../core/models/empty_response.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/imoment_repository.dart';

@injectable
class DeletePostUseCase extends UseCase<EmptyResponse, DeletePostParam> {
  final IMomentRepository repository;

  DeletePostUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(DeletePostParam param) {
    return repository.deletePost(param);
  }
}