import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/Interact/data/model/request/delete_interact_params.dart';
import 'package:starter_application/features/Interact/data/model/request/interaction_request.dart';
import 'package:starter_application/features/Interact/domain/entity/Interaction_entity.dart';
import 'package:starter_application/features/Interact/domain/repository/iInteraction_repository.dart';

@injectable
class DeleteInteractUseCase extends UseCase<EmptyResponse, DeleteInteractParams> {
  IInteractRepository iInteractRepository;
  DeleteInteractUseCase(this.iInteractRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(DeleteInteractParams param) async {
    return await iInteractRepository.deleteInteract(param);
  }
}
