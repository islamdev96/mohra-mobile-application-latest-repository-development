import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/data/model/request/create_dream_params.dart';
import 'package:starter_application/features/mylife/data/model/request/create_positives_params.dart';
import 'package:starter_application/features/mylife/data/model/request/delet_item_request.dart';
import 'package:starter_application/features/mylife/domain/entity/DreamListEntity.dart';
import 'package:starter_application/features/mylife/domain/entity/PositiveListEntity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class DeletePositiveUsecase extends UseCase<EmptyResponse, DeleteItemRequest> {
  IMylifeRepository _iMylifeRepository;

  DeletePositiveUsecase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(DeleteItemRequest param)  {
    return  _iMylifeRepository.deletePositive(param);
  }
}
