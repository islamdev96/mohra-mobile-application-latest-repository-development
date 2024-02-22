import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/features/Interact/data/model/request/delete_interact_params.dart';
import 'package:starter_application/features/Interact/data/model/request/get_interaction_list_request.dart';
import 'package:starter_application/features/Interact/data/model/request/interaction_request.dart';
import 'package:starter_application/features/Interact/data/model/response/get_interacte_list_response.dart';
import 'package:starter_application/features/moment/data/model/response/moment_model.dart';


import '../../../../core/datasources/remote_data_source.dart';

abstract class IInteractRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, InteractionModel>> interact(InteractRequest param);
  Future<Either<AppErrors, EmptyResponse>> deleteInteract(DeleteInteractParams param);
  Future<Either<AppErrors, GetInteractionListModel>> getInteractionList(GetInteractionListParams param);
}
