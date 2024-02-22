import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/friend/data/model/request/unblock_friend_params.dart';
import 'package:starter_application/features/friend/domain/repository/ifriend_repository.dart';

@injectable
class UnblockFriendUseCase extends UseCase<EmptyResponse, UnblockFriendParams> {
  final IFriendRepository repository;
  UnblockFriendUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      UnblockFriendParams param) async {
    return repository.unblockFriend(param);
  }
}
