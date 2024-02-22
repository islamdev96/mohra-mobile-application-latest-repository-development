import 'package:starter_application/core/entities/base_entity.dart';

class PersonalityQuestionListEntity extends BaseEntity {
  PersonalityQuestionListEntity({
    required this.totalCount,
    required this.questions,
  });

  int totalCount;
  List<PersonalityQuestionEntity> questions;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}

class PersonalityQuestionEntity extends BaseEntity {
  PersonalityQuestionEntity({
    required this.type,
    required this.arContent,
    required this.enContent,
    required this.content,
    required this.order,
    required this.choices,
    required this.id,
  });

  int type;
  String arContent;
  String enContent;
  String content;
  int order;
  List<PersonalityChoiceEntity> choices;
  int id;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class PersonalityChoiceEntity  extends BaseEntity{
  PersonalityChoiceEntity({
    required this.arContent,
    required this.enContent,
    required this.imageUrl,
    required this.id,
  });

  String arContent;
  String enContent;
  String imageUrl;
  int id;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}
