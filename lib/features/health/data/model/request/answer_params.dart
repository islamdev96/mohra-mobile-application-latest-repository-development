import 'package:starter_application/core/params/base_params.dart';

class AnswerParams extends BaseParams{
  late List<int> choices;

  @override
  Map<String, dynamic> toMap() => {
    "choices":  List<int>.from(choices.map((x) => x)),
  };
}