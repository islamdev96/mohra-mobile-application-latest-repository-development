import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/messages/data/model/request/clear_group_messages_params.dart';
import 'package:starter_application/features/messages/domain/repository/imessages_repository.dart';

@injectable
class ClearGroupMessagesUseCase
    extends UseCase<EmptyResponse, ClearGroupMessagesParams> {
  IMessagesRepository repository;
  ClearGroupMessagesUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      ClearGroupMessagesParams param) async {
    return repository.clearGroupMessages(param);
  }
}
