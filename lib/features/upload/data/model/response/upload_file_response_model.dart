import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/upload/domain/entity/upload_file_response_entity.dart';

class UploadFileResponseModel extends BaseModel<UploadFileResponseEntity> {
  UploadFileResponseModel({
    required this.url,
  });

  final String url;

  factory UploadFileResponseModel.fromMap(Map<String, dynamic> json) =>
      UploadFileResponseModel(
        url: stringV(json["url"]),
      );

  Map<String, dynamic> toMap() => {
        "url": url,
      };

  @override
  UploadFileResponseEntity toEntity() {
    return UploadFileResponseEntity(url: url);
  }
}
