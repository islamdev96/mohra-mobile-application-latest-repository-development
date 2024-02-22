import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/Interact/data/model/request/get_interaction_list_request.dart';
import 'package:starter_application/features/Interact/data/model/request/interaction_request.dart';
import 'package:starter_application/features/Interact/domain/entity/Interaction_entity.dart';
import 'package:starter_application/features/Interact/domain/entity/get_interacte_list_entity.dart';
import 'package:starter_application/features/Interact/domain/repository/iInteraction_repository.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';

@injectable
class GetInteractListUseCase extends UseCase<GetInteractionListEntity, GetInteractionListParams> {
  IInteractRepository iInteractRepository;
  GetInteractListUseCase(this.iInteractRepository);

  @override
  Future<Result<AppErrors, GetInteractionListEntity>> call(GetInteractionListParams param) async {
    return await iInteractRepository.getInteractionList(param);
  }
}
