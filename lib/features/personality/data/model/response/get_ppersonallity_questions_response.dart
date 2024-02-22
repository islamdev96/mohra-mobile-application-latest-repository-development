// To parse this JSON data, do
//
//     final getPersonallityQuestionsResponse = getPersonallityQuestionsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/personality/domain/entity/personality_question_entity.dart';

class GetPersonallityQuestionsResponse {
  GetPersonallityQuestionsResponse({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  PersonalityQuestionListModel result;
  String? targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetPersonallityQuestionsResponse.fromJson(String str) =>
      GetPersonallityQuestionsResponse.fromMap(json.decode(str));

  factory GetPersonallityQuestionsResponse.fromMap(Map<String, dynamic> json) =>
      GetPersonallityQuestionsResponse(
        result: PersonalityQuestionListModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );
}

class PersonalityQuestionListModel
    extends BaseModel<PersonalityQuestionListEntity> {
  PersonalityQuestionListModel({
    required this.totalCount,
    required this.questions,
  });

  int totalCount;
  List<PersonalityQuestionModel> questions;

  factory PersonalityQuestionListModel.fromJson(String str) =>
      PersonalityQuestionListModel.fromMap(json.decode(str));

  factory PersonalityQuestionListModel.fromMap(Map<String, dynamic> json) =>
      PersonalityQuestionListModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        questions: json["items"] == null
            ? []
            : List<PersonalityQuestionModel>.from(
                json["items"].map((x) => PersonalityQuestionModel.fromMap(x))),
      );

  @override
  PersonalityQuestionListEntity toEntity() {
    return PersonalityQuestionListEntity(
      totalCount: totalCount,
      questions: questions.toListEntity(),
    );
  }
}

class PersonalityQuestionModel extends BaseModel<PersonalityQuestionEntity> {
  PersonalityQuestionModel({
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
  List<PersonalityChoiceModel> choices;
  int id;

  factory PersonalityQuestionModel.fromJson(String str) =>
      PersonalityQuestionModel.fromMap(json.decode(str));

  factory PersonalityQuestionModel.fromMap(Map<String, dynamic> json) =>
      PersonalityQuestionModel(
        type: json["type"] == null ? null : json["type"],
        id: json["id"] == null ? null : json["id"],
        arContent: json["arContent"] == null ? null : json["arContent"],
        enContent: json["enContent"] == null ? null : json["enContent"],
        content: json["content"] == null ? null : json["content"],
        order: json["order"] == null ? null : json["order"],
        choices: json["choices"] == null
            ? []
            : List<PersonalityChoiceModel>.from(
                json["choices"].map((x) => PersonalityChoiceModel.fromMap(x))),
      );

  @override
  PersonalityQuestionEntity toEntity() {
    return PersonalityQuestionEntity(
      type: type,
      arContent: arContent,
      enContent: enContent,
      content: content,
      order: order,
      choices: choices.toListEntity(),
      id: id,
    );
  }
}

class PersonalityChoiceModel extends BaseModel<PersonalityChoiceEntity> {
  PersonalityChoiceModel({
    required this.arContent,
    required this.enContent,
    required this.imageUrl,
    required this.id,
  });

  String arContent;
  String enContent;
  String imageUrl;
  int id;

  factory PersonalityChoiceModel.fromJson(String str) =>
      PersonalityChoiceModel.fromMap(json.decode(str));

  factory PersonalityChoiceModel.fromMap(Map<String, dynamic> json) =>
      PersonalityChoiceModel(
        arContent: json["arContent"] == null ? null : json["arContent"],
        id: json["id"] == null ? null : json["id"],
        enContent: json["enContent"] == null ? null : json["enContent"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
      );

  @override
  PersonalityChoiceEntity toEntity() {
    return PersonalityChoiceEntity(
        arContent: arContent, enContent: enContent, imageUrl: imageUrl , id:id);
  }
}
