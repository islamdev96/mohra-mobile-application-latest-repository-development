import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/friend/data/model/request/delete_friend_params.dart';
import 'package:starter_application/features/friend/domain/repository/ifriend_repository.dart';

@injectable
class DeleteFriendUseCase extends UseCase<EmptyResponse, DeleteFriendParams> {
  final IFriendRepository repository;
  DeleteFriendUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      DeleteFriendParams param) async {
    return repository.deleteFriend(param);
  }
}
