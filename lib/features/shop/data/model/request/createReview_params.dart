import 'package:starter_application/core/params/base_params.dart';

class CreateReviewParams extends BaseParams {
  int? rate;
  String? comment;
  int? refType;
  int? refId;
  List<String>? images;
  int? profesionalismRate;
  int? waitTimeRate;
  int? experienceRate;
  int? valueRate;
  CreateReviewParams(
      {this.rate,
      this.comment,
      this.refType,
      this.refId,
      this.images,
      this.experienceRate,
      this.profesionalismRate,
      this.valueRate,
      this.waitTimeRate});

  @override
  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
      "comment": comment,
      "refType": refType,
      "refId": refId,
      "images": images,
      "experienceRate": experienceRate,
      "profesionalismRate": profesionalismRate,
      "valueRate": valueRate,
      "waitTimeRate": waitTimeRate,
    };
  }
}
