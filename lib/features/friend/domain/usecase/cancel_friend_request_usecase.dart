import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/friend/data/model/request/delete_friend_request_params.dart';
import 'package:starter_application/features/friend/domain/repository/ifriend_repository.dart';
@injectable
class CancelFriendRequestUseCase
    extends UseCase<EmptyResponse, CancelFriendRequestParams> {
  final IFriendRepository repository;

  CancelFriendRequestUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(CancelFriendRequestParams param) {
    return repository.cancelFriendRequest(param);
  }
}
