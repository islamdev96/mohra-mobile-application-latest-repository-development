

import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/Interact/domain/entity/Interaction_entity.dart';

class GetInteractionListEntity extends BaseEntity {
  GetInteractionListEntity({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<InteractionEntity> items;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}

