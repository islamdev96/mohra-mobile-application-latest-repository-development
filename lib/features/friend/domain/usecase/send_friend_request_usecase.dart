import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/friend/data/model/request/send_friend_request_params.dart';
import 'package:starter_application/features/friend/domain/entity/send_friend_request_entity.dart';
import 'package:starter_application/features/friend/domain/repository/ifriend_repository.dart';

@injectable
class SendFriendRequestUseCase
    extends UseCase<SendFriendRequestEntity, SendFriendRequestParams> {
  final IFriendRepository repository;
  SendFriendRequestUseCase(this.repository);
  @override
  Future<Result<AppErrors, SendFriendRequestEntity>> call(
      SendFriendRequestParams param) async {
    return await repository.sendFriendRequest(param);
  }
}
