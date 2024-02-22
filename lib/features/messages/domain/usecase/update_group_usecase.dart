import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/messages/data/model/request/update_group_params.dart';
import 'package:starter_application/features/messages/domain/entity/group_entity.dart';
import 'package:starter_application/features/messages/domain/repository/imessages_repository.dart';

@injectable
class UpdateGroupUseCase extends UseCase<GroupEntity, UpdateGroupParams> {
  IMessagesRepository repository;
  UpdateGroupUseCase(this.repository);
  @override
  Future<Result<AppErrors, GroupEntity>> call(UpdateGroupParams param) async {
    return repository.updateGroup(param);
  }
}
