import 'package:starter_application/core/constants/enums/custom_file_type.dart';
import 'package:starter_application/core/params/base_params.dart';

class UploadFileParams extends BaseParams {
  String path;
  final CustomFileType type;

  UploadFileParams({
    required this.path,
    required this.type,
  });

  @override
  Map<String, dynamic> toMap() => {};
}
