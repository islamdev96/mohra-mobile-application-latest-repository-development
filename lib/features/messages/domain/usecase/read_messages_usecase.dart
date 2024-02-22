import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/messages/data/model/request/read_messages_request.dart';
import 'package:starter_application/features/messages/domain/repository/imessages_repository.dart';

@injectable
class ReadMessagesUseCase extends UseCase<EmptyResponse, ReadMessagesParams> {
  IMessagesRepository repository;
  ReadMessagesUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      ReadMessagesParams param) async {
    return repository.readMessages(param);
  }
}
