import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/health/domain/entity/health_profile_entity.dart';
import 'package:starter_application/features/health/domain/entity/question_entity.dart';

class CheckHealthProfileEntity extends BaseEntity{
  HealthProfileEntity? healthProfile;
  List<ChoiceEntity> healthProfileAnswers;

  CheckHealthProfileEntity({
    required this.healthProfile,
    required this.healthProfileAnswers,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}