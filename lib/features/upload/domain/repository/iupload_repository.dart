import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/upload/data/model/request/upload_image_param.dart';
import 'package:starter_application/features/upload/domain/entity/upload_file_response_entity.dart';

import '../../../../core/repositories/repository.dart';

abstract class IUploadRepository extends Repository {
  Future<Result<AppErrors, UploadFileResponseEntity>> uploadFile(
      UploadFileParams params);
}
