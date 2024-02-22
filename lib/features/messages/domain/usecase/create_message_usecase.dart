import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/messages/data/model/request/create_message_params.dart';
import 'package:starter_application/features/messages/domain/repository/imessages_repository.dart';

@injectable
class CreateMessageUseCase extends UseCase<EmptyResponse, CreateMessageParams> {
  IMessagesRepository repository;
  CreateMessageUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      CreateMessageParams param) async {
    return await repository.createMessage(param);
  }
}
