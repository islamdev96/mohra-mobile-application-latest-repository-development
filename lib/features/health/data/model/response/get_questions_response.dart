// To parse this JSON data, do
//
//     final getQuestions = getQuestionsFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/health/domain/entity/question_entity.dart';

class GetQuestionsModel extends BaseModel<QuestionsEntity> {
  GetQuestionsModel({
    required this.result,

  });

  List<QuestionModel> result;

  factory GetQuestionsModel.fromJson(String str) =>
      GetQuestionsModel.fromMap(json.decode(str));

  factory GetQuestionsModel.fromMap(Map<String, dynamic> json) => GetQuestionsModel(
        result: List<QuestionModel>.from(
                json["result"].map((x) => QuestionModel.fromMap(x))),
      );

  @override
  QuestionsEntity toEntity() {
    return QuestionsEntity(result: result.toListEntity());
  }
}

class QuestionModel extends BaseModel<QuestionEntity> {
  QuestionModel({
    required this.question,
    required this.choices,
  });

  String question;
  List<ChoiceModel> choices;

  factory QuestionModel.fromJson(String str) =>
      QuestionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromMap(Map<String, dynamic> json) => QuestionModel(
        question: json["question"] == null ? null : json["question"],
        choices: json["choices"] == []
            ? []
            : List<ChoiceModel>.from(
                json["choices"].map((x) => ChoiceModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "question": question == null ? null : question,
        "choices": choices == null
            ? null
            : List<dynamic>.from(choices.map((x) => x.toMap())),
      };

  @override
  QuestionEntity toEntity() {
    return QuestionEntity(question: question, choices: choices.toListEntity());
  }
}

class ChoiceModel extends BaseModel<ChoiceEntity> {
  ChoiceModel({
    required this.id,
    required this.arContent,
    required this.enContent,
    required this.content,
  });

  int id;
  String? arContent;
  String? enContent;
  String? content;

  factory ChoiceModel.fromJson(String str) =>
      ChoiceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChoiceModel.fromMap(Map<String, dynamic> json) => ChoiceModel(
        id: json["id"] == null ? null : json["id"],
        arContent: json["arContent"] == null ? null : json["arContent"],
        enContent: json["enContent"] == null ? null : json["enContent"],
        content: json["content"] == null ? null : json["content"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "arContent": arContent == null ? null : arContent,
        "enContent": enContent == null ? null : enContent,
        "content": content == null ? null : content,
      };

  @override
  ChoiceEntity toEntity() {
    return ChoiceEntity(
      id: id,
      arContent: arContent ?? '',
      content: content ?? '',
      enContent: enContent ?? '',
    );
  }
}
