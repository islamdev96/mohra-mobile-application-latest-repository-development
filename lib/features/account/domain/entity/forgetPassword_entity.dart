import 'package:starter_application/core/entities/base_entity.dart';

class ForgetPasswordEntity extends BaseEntity {
  ForgetPasswordEntity({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  String? result;
  String? targetUrl;
  String? success;
  dynamic error;
  String? unAuthorizedRequest;
  String? abp;

  @override
  List<Object?> get props => [];
}
