import 'package:dio/dio.dart';
import 'package:starter_application/core/params/base_params.dart';

class GetEventRequest extends BaseParams {
  GetEventRequest({required this.id, CancelToken? cancelToken})
      : super(cancelToken: cancelToken);

  final int id;

  factory GetEventRequest.fromMap(Map<String, dynamic> json) => GetEventRequest(
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
