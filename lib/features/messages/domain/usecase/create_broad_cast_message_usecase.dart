import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/messages/data/model/request/create_brodcast_message_params.dart';
import 'package:starter_application/features/messages/domain/repository/imessages_repository.dart';

@injectable
class CreateBrodCastMessageUseCase
    extends UseCase<EmptyResponse, CreateBroadCastMessageParams> {
  IMessagesRepository repository;
  CreateBrodCastMessageUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      CreateBroadCastMessageParams param) async {
    return await repository.createBroadCastMessage(param);
  }
}
