// To parse this JSON data, do
//
//     final checkExistUserModel = checkExistUserModelFromJson(jsonString);


import 'package:starter_application/core/entities/base_entity.dart';

class CheckExistPhoneEntity extends BaseEntity {
  CheckExistPhoneEntity({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  bool result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
