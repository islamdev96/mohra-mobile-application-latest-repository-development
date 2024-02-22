import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/friend/data/model/request/answer_friend_request_params.dart';
import 'package:starter_application/features/friend/domain/repository/ifriend_repository.dart';

@injectable
class RejectFriendRequestUseCase
    extends UseCase<EmptyResponse, AnswerFriendRequestParams> {
  final IFriendRepository repository;
  RejectFriendRequestUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      AnswerFriendRequestParams param) async {
    return await repository.rejectFriendRequest(param);
  }
}
