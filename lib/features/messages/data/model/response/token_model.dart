import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/messages/domain/entity/token_entity.dart';

class TokenModel extends BaseModel<TokenEntity> {
  TokenModel({
    required this.channel,
    required this.token,
  });

  final String channel;
  final String token;

  factory TokenModel.fromMap(Map<String, dynamic> json) => TokenModel(
        channel: stringV(json["channel"]),
        token: stringV(json["token"]),
      );

  Map<String, dynamic> toMap() => {
        "channel": channel,
        "token": token,
      };

  @override
  TokenEntity toEntity() {
    return TokenEntity(channel: channel, token: token);
  }
}
