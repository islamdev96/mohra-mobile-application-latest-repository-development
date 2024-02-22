import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/friend/data/model/request/block_friend_params.dart';
import 'package:starter_application/features/friend/data/model/request/get_frined_status_params.dart';
import 'package:starter_application/features/friend/data/model/response/get_frined_status_response.dart';
import 'package:starter_application/features/friend/domain/entity/get_frined_status_response.dart';
import 'package:starter_application/features/friend/domain/repository/ifriend_repository.dart';
import 'package:starter_application/features/messages/data/model/request/add_friend_to_group.dart';
import 'package:starter_application/features/messages/domain/repository/imessages_repository.dart';

@injectable
class GetStatusGroupUseCase extends UseCase<GetFrinedStatusEntity, GetFrinedStatusParams> {
  IMessagesRepository repository;
  GetStatusGroupUseCase(this.repository);
  @override
  Future<Result<AppErrors, GetFrinedStatusEntity>> call(GetFrinedStatusParams param) async {
    return repository.getGroupStatus(param);
  }
}
