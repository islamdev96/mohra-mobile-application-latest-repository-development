import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/data/model/request/create_dream_params.dart';
import 'package:starter_application/features/mylife/data/model/request/create_positives_params.dart';
import 'package:starter_application/features/mylife/domain/entity/DreamListEntity.dart';
import 'package:starter_application/features/mylife/domain/entity/PositiveListEntity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class CreatePositiveUsecase extends UseCase<PositiveEntity, CreatePositivesParams> {
  IMylifeRepository _iMylifeRepository;

  CreatePositiveUsecase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, PositiveEntity>> call(CreatePositivesParams param)  {
    return  _iMylifeRepository.createPositive(param);
  }
}
