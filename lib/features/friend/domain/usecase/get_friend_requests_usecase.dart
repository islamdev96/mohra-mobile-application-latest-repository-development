import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/friend/data/model/request/get_friends_requests_params.dart';
import 'package:starter_application/features/friend/domain/entity/send_friend_requests_entity.dart';
import 'package:starter_application/features/friend/domain/repository/ifriend_repository.dart';

@injectable
class GetFriendRequestsUseCase
    extends UseCase<SendFriendRequestsEntity, GetFriendsRequestsParams> {
  final IFriendRepository repository;
  GetFriendRequestsUseCase(this.repository);
  @override
  Future<Result<AppErrors, SendFriendRequestsEntity>> call(
      GetFriendsRequestsParams param) async {
    return await repository.getFriendsRequests(param);
  }
}
