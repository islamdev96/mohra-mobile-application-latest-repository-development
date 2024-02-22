import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/messages/data/model/request/delete_friend_from_group_params.dart';
import 'package:starter_application/features/messages/domain/repository/imessages_repository.dart';

@injectable
class DeleteFriendFromGroupUseCase
    extends UseCase<EmptyResponse, DeleteFriendFromGroupParams> {
  IMessagesRepository repository;
  DeleteFriendFromGroupUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      DeleteFriendFromGroupParams param) async {
    return repository.deleteFriendFromGroup(param);
  }
}
