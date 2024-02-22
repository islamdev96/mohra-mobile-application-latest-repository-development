import 'dart:convert';

import 'package:starter_application/core/constants/enums/signal_enum.dart';

class SignalEntity {
  SignalType type;
  String data;
  SignalEntity({required this.type, required this.data});
  factory SignalEntity.fromJson(Map<String, dynamic> json) => SignalEntity(
        type: SignalType.values[json['type']],
        data: json['data'],
      );
  Map<String, dynamic> toJson() => {
        "type": type.index,
        "data": data,
      };
  String stringify() {
    return json.encode(toJson());
  }
}
