import 'package:flutter/cupertino.dart';
import 'package:starter_application/features/challenge/domain/entity/challange_entity.dart';

class ChallengeDetailsScreenParams {
  final ChallangeItemEntity? challangeItemEntity;
  final Function(int newStep)? onStepChange;
  ChallengeDetailsScreenParams({
    this.challangeItemEntity,
    this.onStepChange,
  });
}
