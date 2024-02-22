import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/data/model/request/check_dream_params.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class CheckDreamUsecase extends UseCase<EmptyResponse, CheckDreamParams> {
  IMylifeRepository _iMylifeRepository;

  CheckDreamUsecase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      CheckDreamParams param) async {
    return await _iMylifeRepository.checkUnCheckDream(param);
  }
}
