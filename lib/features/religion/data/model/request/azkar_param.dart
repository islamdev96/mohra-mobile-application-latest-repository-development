import 'package:dio/dio.dart';
import 'package:starter_application/core/params/base_params.dart';

class AzkarParam extends BaseParams {
  String categoryId;

  AzkarParam({required this.categoryId,required CancelToken cancelToken}):super(cancelToken: cancelToken);

  @override
  Map<String, dynamic> toMap() => {
        "CategoryId": categoryId,
      };
}
