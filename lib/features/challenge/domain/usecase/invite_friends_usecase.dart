import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/challenge/data/model/request/invite_friends_request.dart';
import 'package:starter_application/features/challenge/domain/repository/ichallenge_repository.dart';

@injectable
class InviteFriendsUseCase
    extends UseCase<EmptyResponse, InviteFriendsRequest> {
  final IChallengeRepository repository;

  InviteFriendsUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(InviteFriendsRequest param) {
    return repository.inviteFriends(param);
  }
}
