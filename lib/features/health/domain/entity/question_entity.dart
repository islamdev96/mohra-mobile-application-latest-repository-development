import 'package:starter_application/core/entities/base_entity.dart';

class QuestionsEntity extends BaseEntity{

  QuestionsEntity({
    required this.result,

  });

  List<QuestionEntity> result;



  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class QuestionEntity extends BaseEntity{
  String question;
  List<ChoiceEntity> choices;

  QuestionEntity({
    required this.question,
    required this.choices,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];


}

class ChoiceEntity extends BaseEntity{
  int id;
  String? arContent;
  String? enContent;
  String? content;

  ChoiceEntity({
    required this.id,
    this.arContent,
    this.enContent,
    this.content,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}