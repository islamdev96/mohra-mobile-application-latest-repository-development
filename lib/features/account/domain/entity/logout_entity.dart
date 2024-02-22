import 'dart:convert';

import 'package:starter_application/core/entities/base_entity.dart';

class LogoutEntity extends BaseEntity {
  LogoutEntity({
    required this.result,
  });

  LogoutEntityResult result;

  @override
  List<Object?> get props => [];
}

class LogoutEntityResult extends BaseEntity{
  int? status;
  String? message;

  LogoutEntityResult({this.status, this.message});

  @override
  List<Object?> get props => [];
}
