import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/upload/data/model/request/upload_image_param.dart';
import 'package:starter_application/features/upload/domain/entity/upload_file_response_entity.dart';
import 'package:starter_application/features/upload/domain/repository/iupload_repository.dart';

@singleton
class UploadFileUseCase
    extends UseCase<UploadFileResponseEntity, UploadFileParams> {
  final IUploadRepository repository;
  UploadFileUseCase(this.repository);

  @override
  Future<Result<AppErrors, UploadFileResponseEntity>> call(
      UploadFileParams param) {
    return repository.uploadFile(param);
  }
}
