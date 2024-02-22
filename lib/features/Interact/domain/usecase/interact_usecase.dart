import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/Interact/data/model/request/interaction_request.dart';
import 'package:starter_application/features/Interact/domain/entity/Interaction_entity.dart';
import 'package:starter_application/features/Interact/domain/repository/iInteraction_repository.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';

@injectable
class InteractUseCase extends UseCase<InteractionsEntity, InteractRequest> {
  IInteractRepository iInteractRepository;
  InteractUseCase(this.iInteractRepository);

  @override
  Future<Result<AppErrors, InteractionsEntity>> call(InteractRequest param) async {
    return await iInteractRepository.interact(param);
  }
}
