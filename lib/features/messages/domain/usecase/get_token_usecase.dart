import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/messages/data/model/request/get_token_params.dart';
import 'package:starter_application/features/messages/domain/entity/token_entity.dart';
import 'package:starter_application/features/messages/domain/repository/imessages_repository.dart';

@injectable
class GetTokenUseCase extends UseCase<TokenEntity, GetTokenParams> {
  IMessagesRepository repository;
  GetTokenUseCase(this.repository);
  @override
  Future<Result<AppErrors, TokenEntity>> call(GetTokenParams param) async {
    return await repository.getToken(param);
  }
}
