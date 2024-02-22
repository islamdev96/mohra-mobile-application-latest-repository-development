import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/messages/data/model/request/create_group_params.dart';
import 'package:starter_application/features/messages/domain/entity/group_entity.dart';
import 'package:starter_application/features/messages/domain/repository/imessages_repository.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';

@injectable
class CreateGroupUseCase extends UseCase<GroupEntity, CreateGroupParams> {
  IMessagesRepository repository;
  CreateGroupUseCase(this.repository);
  @override
  Future<Result<AppErrors, GroupEntity>> call(CreateGroupParams param) async {
    final result = await repository.createGroup(param);
    if (result.hasDataOnly)
      Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
          .addToGroups(group: result.data);

    return result;
  }
}
