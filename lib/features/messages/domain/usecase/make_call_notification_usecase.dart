import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/messages/data/model/request/read_messages_request.dart';
import 'package:starter_application/features/messages/domain/repository/imessages_repository.dart';

import '../../data/model/request/make_notification_call_params.dart';

@injectable
class MakeCallNotificationUseCase
    extends UseCase<EmptyResponse, MakeNotificationCallParams> {
  IMessagesRepository repository;

  MakeCallNotificationUseCase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      MakeNotificationCallParams param) async {
    return repository.makeCallNotification(param);
  }
}
