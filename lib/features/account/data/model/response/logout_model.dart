import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/account/domain/entity/login_entity.dart';
import 'package:starter_application/features/account/domain/entity/logout_entity.dart';

class LogoutModel extends BaseModel<LogoutEntity> {
  LogoutModelResult? result;

  LogoutModel({this.result});

  factory LogoutModel.fromMap(Map<String, dynamic> json)   {
    print('eerr');
    print(json);
    return LogoutModel(
      result: LogoutModelResult.fromMap(json),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }

  @override
  LogoutEntity toEntity() {
    return LogoutEntity(result: result!.toEntity());
  }
}

class LogoutModelResult extends BaseModel<LogoutEntityResult> {
  int? status;
  String? message;

  LogoutModelResult({this.status, this.message});
  factory LogoutModelResult.fromMap(Map<String, dynamic> json) =>
      LogoutModelResult(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
      );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
  @override
  LogoutEntityResult toEntity() {
    return LogoutEntityResult(message: message,status: status);
  }
}
