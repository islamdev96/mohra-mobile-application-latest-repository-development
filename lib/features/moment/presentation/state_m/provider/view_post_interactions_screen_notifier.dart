import 'package:flutter/material.dart';
import 'package:starter_application/features/Interact/data/model/request/get_interaction_list_request.dart';
import 'package:starter_application/features/Interact/domain/entity/Interaction_entity.dart';
import 'package:starter_application/features/Interact/domain/entity/get_interacte_list_entity.dart';
import 'package:starter_application/features/Interact/presentation/state_m/cubit/Interact_cubit.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';


class ViewPostInteractionsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late MomentItemEntity momentItemEntity;
  final interactCubit = InteractCubit();

  List<InteractionEntity> interactions = [];
  /// Getters and Setters


  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }


  getPostInteraction(){
   interactCubit.getAll(GetInteractionListParams(refId: momentItemEntity.id!, refType: 2));
  }

  onInteractionListLoaded(GetInteractionListEntity getInteractionListEntity){
    this.interactions = getInteractionListEntity.items;
    notifyListeners();
  }

}
