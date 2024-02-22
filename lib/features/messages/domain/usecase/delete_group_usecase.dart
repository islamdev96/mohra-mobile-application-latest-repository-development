import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/messages/data/model/request/delete_group_params.dart';
import 'package:starter_application/features/messages/domain/repository/imessages_repository.dart';

@injectable
class DeleteGroupUseCase extends UseCase<EmptyResponse, DeleteGroupParams> {
  IMessagesRepository repository;
  DeleteGroupUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(DeleteGroupParams param) async {
    return repository.deleteGroup(param);
  }
}
