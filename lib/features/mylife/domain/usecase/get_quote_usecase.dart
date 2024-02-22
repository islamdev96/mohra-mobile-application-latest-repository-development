import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/domain/entity/quote_entity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class GetQuoteUseCase extends UseCase<QuoteEntity, NoParams> {
  IMylifeRepository _iMylifeRepository;

  GetQuoteUseCase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, QuoteEntity>> call(NoParams param) {
    return _iMylifeRepository.getQuote(param);
  }
}
