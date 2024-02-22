import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/default_create_model_inteceptor.dart';
import 'package:starter_application/core/net/response_validators/default_response_validator.dart';
import 'package:starter_application/features/Interact/data/model/request/delete_interact_params.dart';
import 'package:starter_application/features/Interact/data/model/request/get_interaction_list_request.dart';
import 'package:starter_application/features/Interact/data/model/request/interaction_request.dart';
import 'package:starter_application/features/Interact/data/model/response/get_interacte_list_response.dart';
import 'package:starter_application/features/moment/data/model/response/moment_model.dart';


import 'iInteraction_remote.dart';

@Singleton(as: IInteractRemoteSource)
class InteractRemoteSource extends IInteractRemoteSource {
  @override
  Future<Either<AppErrors, InteractionModel>> interact(InteractRequest param) {
    return request(
        converter: (json) => InteractionModel.fromMap(json),
        method: HttpMethod.POST,
        body: param.toMap(),
        url: APIUrls.API_INTERACT,
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deleteInteract(DeleteInteractParams param) {
    return request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.DELETE,
        queryParameters: param.toMap(),
        url: APIUrls.API_DELETE_INTERACT);
  }

  @override
  Future<Either<AppErrors, GetInteractionListModel>> getInteractionList(GetInteractionListParams param) {
    return request(
        converter: (json) => GetInteractionListModel.fromJson(json),
        method: HttpMethod.GET,
        queryParameters: param.toMap(),
        url: APIUrls.getInteraction,
    );
  }
}
