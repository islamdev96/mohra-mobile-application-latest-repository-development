import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/Interact/data/model/request/delete_interact_params.dart';
import 'package:starter_application/features/Interact/data/model/request/get_interaction_list_request.dart';
import 'package:starter_application/features/Interact/data/model/request/interaction_request.dart';
import 'package:starter_application/features/Interact/data/model/response/get_interacte_list_response.dart';
import 'package:starter_application/features/Interact/domain/entity/get_interacte_list_entity.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';

import '../datasource/../../domain/repository/iInteraction_repository.dart';
import '../datasource/iInteraction_remote.dart';

@Singleton(as: IInteractRepository)
class InteractRepository extends IInteractRepository {
  final IInteractRemoteSource iInteractRemoteSource;

  InteractRepository(this.iInteractRemoteSource);

  @override
  Future<Result<AppErrors, EmptyResponse>> deleteInteract(
      DeleteInteractParams param) async {
    Either<AppErrors, EmptyResponse> remoteResult =
        await iInteractRemoteSource.deleteInteract(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, InteractionsEntity>> interact(
      InteractRequest param) async {
    final remote = await iInteractRemoteSource.interact(param);
    return remote.result<InteractionsEntity>();
  }

  @override
  Future<Result<AppErrors, GetInteractionListEntity>> getInteractionList(
      GetInteractionListParams param) async {
    final remote = await iInteractRemoteSource.getInteractionList(param);
    return remote.result<GetInteractionListEntity>();
  }
}
