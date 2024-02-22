import 'package:dartz/dartz.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/enums/custom_file_type.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/response_validators/default_response_validator.dart';
import 'package:starter_application/features/upload/data/model/request/upload_image_param.dart';
import 'package:starter_application/features/upload/data/model/response/upload_file_response_model.dart';

import 'iupload_remote.dart';

@Singleton(as: IUploadRemoteSource)
class UploadRemoteSource extends IUploadRemoteSource {
  @override
  Future<Either<AppErrors, UploadFileResponseModel>> uploadFile(
      UploadFileParams params) {
    return requestUploadFile(
      converter: (json) {
        return UploadFileResponseModel.fromMap(json);
      },
      url: getUrl(params.type),
      fileKey: 'File',
      filePath: params.path,
      data: {},
      responseValidator: DefaultResponseValidator(),
      mediaType: MediaType(
        params.type.name,
        getFileExtension(params.path),
      ),
    );
  }

  String getUrl(CustomFileType fileType) {
    switch (fileType) {
      case CustomFileType.IMAGE:
        return APIUrls.uploadImage;
      case CustomFileType.VIDEO:
        return APIUrls.uploadVideo;
      case CustomFileType.AUDIO:
        return APIUrls.uploadAudio;
      case CustomFileType.DOC:
        return APIUrls.uploadDoc;
    }
  }
}
