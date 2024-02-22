// To parse this JSON data, do
//
//     final savePersonaliityAnswers = savePersonaliityAnswersFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/params/base_params.dart';

class SavePersonaliityAnswers extends BaseParams {
  SavePersonaliityAnswers(){
    this.answers = [];
  }

  List<AnswermModelRequest> answers = [];


  String toJson() => json.encode(toMap());


  Map<String, dynamic> toMap() => {
    "answers":  List<dynamic>.from(answers.map((x) => x.toMap())),
  };
}

class AnswermModelRequest {
  AnswermModelRequest({
    required this.questionId,
    required this.choiceId,
  });

  int questionId;
  int choiceId;

  factory AnswermModelRequest.fromJson(String str) => AnswermModelRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AnswermModelRequest.fromMap(Map<String, dynamic> json) => AnswermModelRequest(
    questionId: json["questionId"] == null ? null : json["questionId"],
    choiceId: json["choiceId"] == null ? null : json["choiceId"],
  );

  Map<String, dynamic> toMap() => {
    "questionId": questionId == null ? null : questionId,
    "choiceId": choiceId == null ? null : choiceId,
  };

  @override
  String toString() {
    return 'AnswermModelRequest{questionId: $questionId, choiceId: $choiceId}';
  }
}
