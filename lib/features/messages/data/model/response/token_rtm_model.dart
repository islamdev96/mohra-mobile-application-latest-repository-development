import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/messages/domain/entity/token_rtm_entity.dart';

class TokenRtmModel extends BaseModel<TokenRtmEntity> {
  TokenRtmModel({
    required this.uid,
    required this.token,
  });

  final String uid;
  final String token;

  factory TokenRtmModel.fromMap(Map<String, dynamic> json) => TokenRtmModel(
        uid: stringV(json["uid"]),
        token: stringV(json["token"]),
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "token": token,
      };

  @override
  TokenRtmEntity toEntity() {
    return TokenRtmEntity(uid: uid, token: token);
  }
}
