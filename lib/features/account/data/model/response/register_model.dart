// To parse this JSON data, do
//
//     final registerModel = registerModelFromMap(jsonString);

import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/account/domain/entity/register_entity.dart';

RegisterModel registerModelFromMap(String str) =>
    RegisterModel.fromMap(json.decode(str));

String registerModelToMap(RegisterModel data) => json.encode(data.toMap());

class RegisterModel extends BaseModel<RegisterEntity> {
  RegisterModel({
    this.canLogin,
  });

  bool? canLogin;

  factory RegisterModel.fromMap(Map<String, dynamic> json) => RegisterModel(
        canLogin: json["canLogin"],
      );

  Map<String, dynamic> toMap() => {
        "canLogin": canLogin,
      };

  @override
  RegisterEntity toEntity() {
    return RegisterEntity(canLogin: canLogin);
  }
}
