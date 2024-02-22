import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/messages/data/model/request/get_messages_request.dart';
import 'package:starter_application/features/messages/domain/entity/messages_entity.dart';
import 'package:starter_application/features/messages/domain/repository/imessages_repository.dart';

@injectable
class GetMessagesUseCase extends UseCase<MessagesEntity, GetMessagesParams> {
  IMessagesRepository repository;
  GetMessagesUseCase(this.repository);
  @override
  Future<Result<AppErrors, MessagesEntity>> call(
      GetMessagesParams param) async {
    return await repository.getMessages(param);
  }
}
