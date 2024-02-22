import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/features/upload/data/model/request/upload_image_param.dart';
import 'package:starter_application/features/upload/data/model/response/upload_file_response_model.dart';

import '../../../../core/datasources/remote_data_source.dart';

abstract class IUploadRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, UploadFileResponseModel>> uploadFile(
      UploadFileParams params);
}
