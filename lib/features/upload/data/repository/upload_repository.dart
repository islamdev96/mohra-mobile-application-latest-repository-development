import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/upload/data/model/request/upload_image_param.dart';
import 'package:starter_application/features/upload/domain/entity/upload_file_response_entity.dart';

import '../datasource/../../domain/repository/iupload_repository.dart';
import '../datasource/iupload_remote.dart';

@Singleton(as: IUploadRepository)
class UploadRepository extends IUploadRepository {
  final IUploadRemoteSource iUploadRemoteSource;

  UploadRepository(this.iUploadRemoteSource);

  @override
  Future<Result<AppErrors, UploadFileResponseEntity>> uploadFile(
      UploadFileParams params) async {
    final remote = await iUploadRemoteSource.uploadFile(params);
    return remote.result<UploadFileResponseEntity>();
  }
}
