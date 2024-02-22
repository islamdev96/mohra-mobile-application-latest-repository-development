import 'package:starter_application/core/entities/base_entity.dart';

class TokenEntity extends BaseEntity {
  TokenEntity({
    required this.channel,
    required this.token,
  });

  final String channel;
  final String token;

  @override
  List<Object?> get props => [];
}
