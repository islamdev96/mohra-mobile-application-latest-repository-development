import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/messages/data/model/request/get_conversation_request.dart';
import 'package:starter_application/features/messages/domain/entity/conversations_entity.dart';
import 'package:starter_application/features/messages/domain/repository/imessages_repository.dart';

@injectable
class GetConversationsUseCase
    extends UseCase<ConversationsEntity, GetConversationParams> {
  IMessagesRepository repository;
  GetConversationsUseCase(this.repository);
  @override
  Future<Result<AppErrors, ConversationsEntity>> call(
      GetConversationParams param) async {
    return await repository.getConversations(param);
  }
}
