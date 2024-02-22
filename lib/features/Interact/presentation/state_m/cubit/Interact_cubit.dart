import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/Interact/data/model/request/delete_interact_params.dart';
import 'package:starter_application/features/Interact/data/model/request/get_interaction_list_request.dart';
import 'package:starter_application/features/Interact/data/model/request/interaction_request.dart';
import 'package:starter_application/features/Interact/domain/entity/Interaction_entity.dart';
import 'package:starter_application/features/Interact/domain/entity/get_interacte_list_entity.dart';
import 'package:starter_application/features/Interact/domain/usecase/delete_interact_usecase.dart';
import 'package:starter_application/features/Interact/domain/usecase/get_interactions_list_usecase.dart';
import 'package:starter_application/features/Interact/domain/usecase/interact_usecase.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import '../../../../../core/errors/app_errors.dart';

part 'Interact_state.dart';

part 'Interact_cubit.freezed.dart';

class InteractCubit extends Cubit<InteractState> {
  InteractCubit() : super(const InteractState.interactInitState());

    Interact(InteractRequest params) async {
    emit(const InteractState.interactLoadingState());
    final result = await getIt<InteractUseCase>().call(params);

    result.pick(
      onData: (data) {
        print('rrrrrrrrrrrr');
        emit(InteractState.interactCreatedState(data));
    },
      onError: (error) => emit(InteractState.interactErrorState(error, () {
        Interact(params);
      })),
    );
  }


  // deleteInteract(DeleteInteractParams params) async {
  //   emit(const InteractState.interactLoadingState());
  //   final result = await getIt<DeleteInteractUseCase>().call(params);
  //
  //   result.pick(
  //     onData: (data) => emit(InteractState.interactDeletedState()),
  //     onError: (error) => emit(InteractState.interactErrorState(error, () {
  //       deleteInteract(params);
  //     })),
  //   );
  // }
  getAll(GetInteractionListParams params) async {
    emit(const InteractState.interactLoadingState());
    final result = await getIt<GetInteractListUseCase>().call(params);

    result.pick(
      onData: (data) => emit(InteractState.interactListLoaded(data)),
      onError: (error) => emit(InteractState.interactErrorState(error, () {
        getAll(params);
      })),
    );
  }
  
}
