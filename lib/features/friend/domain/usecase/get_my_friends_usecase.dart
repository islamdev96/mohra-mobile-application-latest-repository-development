import 'package:injectable/injectable.dart';
import 'package:provider/src/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/friend/data/model/request/get_my_friends_request.dart';
import 'package:starter_application/features/friend/domain/repository/ifriend_repository.dart';
import 'package:starter_application/features/messages/domain/entity/friends_entity.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';

@injectable
class GetMyFriendsUseCase extends UseCase<FriendsEntity, GetMyFriendsRequest> {
  final IFriendRepository repository;
  GetMyFriendsUseCase(this.repository);
  @override
  Future<Result<AppErrors, FriendsEntity>> call(
      GetMyFriendsRequest param) async {
    final result = await repository.getMyFriends(param);
    if (result.hasDataOnly &&
        param ==
            AppConfig()
                .appContext
                .read<GlobalMessagesNotifier>()
                .getFriendsParam) {
      AppConfig().appContext.read<GlobalMessagesNotifier>().friends =
          result.data!.items;
    }
    return result;
  }
}
