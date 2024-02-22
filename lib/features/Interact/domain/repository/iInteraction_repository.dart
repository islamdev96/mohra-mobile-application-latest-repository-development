import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/Interact/data/model/request/delete_interact_params.dart';
import 'package:starter_application/features/Interact/data/model/request/get_interaction_list_request.dart';
import 'package:starter_application/features/Interact/data/model/request/interaction_request.dart';
import 'package:starter_application/features/Interact/data/model/response/get_interacte_list_response.dart';
import 'package:starter_application/features/Interact/domain/entity/Interaction_entity.dart';
import 'package:starter_application/features/Interact/domain/entity/get_interacte_list_entity.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';

import '../../../../core/repositories/repository.dart';

abstract class IInteractRepository extends Repository {
  Future<Result<AppErrors, InteractionsEntity>> interact(InteractRequest param);
  Future<Result<AppErrors, EmptyResponse>> deleteInteract(DeleteInteractParams param);
  Future<Result<AppErrors, GetInteractionListEntity>> getInteractionList(GetInteractionListParams param);

}
