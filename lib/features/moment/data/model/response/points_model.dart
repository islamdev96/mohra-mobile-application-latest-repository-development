import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/moment/domain/entity/points_entity.dart';

class PointsModel extends BaseModel<PointsEntity> {
  Result? result;

  PointsModel({
    this.result,
  });

  factory PointsModel.fromMap(Map<String, dynamic> json) => PointsModel(
      result: json['result'] != null ? Result.fromMap(json['result']) : null);

  @override
  PointsEntity toEntity() {
    return PointsEntity(result: result?.toEntity());
  }
}

class Result extends BaseModel<ResultEntity> {
  int? points;

  Result({this.points});

  factory Result.fromMap(Map<String, dynamic> json) =>
      Result(points: json['points']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    return data;
  }

  @override
  ResultEntity toEntity() {
    return ResultEntity(points: points);
  }
}
