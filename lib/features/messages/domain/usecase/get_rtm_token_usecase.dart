import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/messages/data/model/request/get_rtm_token_params.dart';
import 'package:starter_application/features/messages/domain/entity/token_rtm_entity.dart';
import 'package:starter_application/features/messages/domain/repository/imessages_repository.dart';

@injectable
class GetTokenRtmUseCase extends UseCase<TokenRtmEntity, GetRtmTokenParams> {
  IMessagesRepository repository;
  GetTokenRtmUseCase(this.repository);
  @override
  Future<Result<AppErrors, TokenRtmEntity>> call(
      GetRtmTokenParams param) async {
    return await repository.getRtmToken(param);
  }
}
