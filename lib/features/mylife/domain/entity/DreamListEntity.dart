import 'package:starter_application/core/entities/base_entity.dart';

class DreamListEntity extends BaseEntity{
  DreamListEntity({
    required this.totalCount,
    required this.items,
  });

  int totalCount;
  List<DreamEntity> items;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DreamEntity extends BaseEntity{
  DreamEntity({
    required this.title,
    required this.imageUrl,
    required this.steps,
    required this.isAchieved,
    required this.totalStepsCount,
    required this.clientId,
    required this.achievedStepsCount,
    required this.pendingStepsCount,
    required this.id,
  });

  String title;
  String imageUrl;
  List<StepEntity> steps;
  bool isAchieved;
  int totalStepsCount;
  int clientId;
  int achievedStepsCount;
  int pendingStepsCount;
  int id;

  @override
  // TODO: implement props
  List<Object?> get props => [];


}

class StepEntity extends BaseEntity{
  StepEntity({
    required this.title,
    required this.order,
    required this.status,
    required this.id,
  });

  String title;
  int order;
  int status;
  int id;

  @override
  // TODO: implement props
  List<Object?> get props => [];


}