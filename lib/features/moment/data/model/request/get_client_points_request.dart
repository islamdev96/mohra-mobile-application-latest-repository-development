import 'package:dio/dio.dart';
import 'package:starter_application/core/params/base_params.dart';

class GetClientPointsRequest extends BaseParams {
  GetClientPointsRequest(
      {
      this.id,
      CancelToken? cancelToken})
      : super(cancelToken: cancelToken);


  final int? id;

  factory GetClientPointsRequest.fromMap(Map<String, dynamic> json) =>
      GetClientPointsRequest(
        id:
            json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> _map = {};
    _map['id'] = id;
    return _map;
  }
}
