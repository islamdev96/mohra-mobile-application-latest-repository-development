import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/data/model/request/create_dream_params.dart';
import 'package:starter_application/features/mylife/domain/entity/DreamListEntity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class CreateDreamUsecase extends UseCase<DreamEntity, CreateDreamParams> {
  IMylifeRepository _iMylifeRepository;

  CreateDreamUsecase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, DreamEntity>> call(CreateDreamParams param)  {
    return  _iMylifeRepository.createDream(param);
  }
}
