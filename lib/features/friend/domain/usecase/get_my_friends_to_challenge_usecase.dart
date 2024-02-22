import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/friend/data/model/request/get_my_friends_challenge_request.dart';
import 'package:starter_application/features/friend/domain/repository/ifriend_repository.dart';
import 'package:starter_application/features/messages/domain/entity/friends_entity.dart';

@injectable
class GetMyFriendsToChallengeUseCase
    extends UseCase<FriendsEntity, GetMyFriendsForChallengeRequest> {
  final IFriendRepository repository;
  GetMyFriendsToChallengeUseCase(this.repository);
  @override
  Future<Result<AppErrors, FriendsEntity>> call(
      GetMyFriendsForChallengeRequest param) async {
    return await repository.getMyFriendsToChallenge(param);
  }
}
