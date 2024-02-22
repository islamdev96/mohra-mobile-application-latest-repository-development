import 'package:starter_application/core/entities/base_entity.dart';

class UploadFileResponseEntity extends BaseEntity {
  UploadFileResponseEntity({
    required this.url,
  });

  final String url;

  @override
  List<Object?> get props => [];
}
